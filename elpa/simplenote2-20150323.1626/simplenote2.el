;;; simplenote2.el --- Interact with simple-note.appspot.com

;; Copyright (C) 2009, 2010 Konstantinos Efstathiou <konstantinos@efstathiou.gr>
;; Copyright (C) 2015 alpha22jp <alpha22jp@gmail.com>

;; Author: alpha22jp <alpha22jp@gmail.com>
;; Based on: simplenote.el
;;     by Konstantinos Efstathiou <konstantinos@efstathiou.gr>
;; Package-Requires: ((request-deferred "0.2.0"))
;; Keywords: simplenote
;; Package-Version: 20150323.1626
;; Version: 2.2.1

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 2 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; this program; if not, write to the Free Software Foundation, Inc., 51
;; Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

;;; Commentary:

;; This is a new version of simplenote.el which assists the interaction with
;; Simplenote (http://app.simplenote.com/). The major improvement points from
;; the original version are
;; 
;; * Use of Simplenote API ver.2 to interact with server which can provide the
;;   support of tags, automatic merge of notes, and some other features.
;; * Asynchronous and concurrent access to server which brings faster sync of
;;   notes and non-blocking UI.

;;; Code:



(eval-when-compile (require 'cl))
(require 'url)
(require 'json)
(require 'widget)
(require 'request-deferred)

(defcustom simplenote2-directory (expand-file-name "~/.simplenote2/")
  "Simplenote directory."
  :type 'directory
  :safe 'stringp
  :group 'simplenote2)

(defcustom simplenote2-email nil
  "Simplenote account email."
  :type 'string
  :safe 'stringp
  :group 'simplenote2)

(defcustom simplenote2-password nil
  "Simplenote account password."
  :type 'string
  :safe 'stringp
  :group 'simplenote2)

(defcustom simplenote2-notes-mode 'text-mode
  "The mode used for editing notes opened from Simplenote.

Since notes do not have file extensions, the default mode must be
set via this option.  Individual notes can override this setting
via the usual `-*- mode: text -*-' header line."
  :type 'function
  :group 'simplenote2)

(defcustom simplenote2-markdown-notes-mode 'text-mode
  "The mode used for editing markdown notes opened from Simplenote.

This option is used for editing notes which are set to
\"Markdown formatted\" on Simplenote. If you want to use `markdown-mode'
to edit them, set this option to `markdown-mode'."
  :type 'function
  :group 'simplenote2)

(defcustom simplenote2-note-head-size 78
  "Length of note headline in the notes list."
  :type 'integer
  :safe 'integerp
  :group 'simplenote2)

(defcustom simplenote2-show-note-file-name t
  "Show file name for each note in the note list."
  :type 'boolean
  :safe 'booleanp
  :group 'simplenote2)

(defvar simplenote2-browser-mode-hook nil)

(defcustom simplenote2-create-note-hook nil
  "List of functions to be called when a new file is created locally."
  :type 'hook
  :group 'simplenote2)

(put 'simplenote2-browser-mode 'mode-class 'special)

(defvar simplenote2--server-url "https://simple-note.appspot.com/")

(defvar simplenote2--email-was-read-interactively nil)
(defvar simplenote2--password-was-read-interactively nil)

(defvar simplenote2--token nil)

(defvar simplenote2-notes-info (make-hash-table :test 'equal))
(defvar simplenote2-new-notes-info (make-hash-table :test 'equal))

(defvar simplenote2-tag-list nil)

(defconst simplenote2-notes-info-version 1)

(defvar simplenote2--filename-for-notes-info
  (concat (file-name-as-directory simplenote2-directory) ".notes-info.el"))

(defvar simplenote2-filter-note-tag-list nil)

(defvar simplenote2--sync-process-running nil)


;;; Unitity functions

(defun simplenote2--file-mtime (path)
  (nth 5 (file-attributes path)))

(defun simplenote2--time-to-seconds (time)
  ;; Use "format" to omit microseconds since server doesn't accept it
  (format "%.6f" (float-time time)))

(defun simplenote2--get-file-string (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(defun simplenote2--tag-existp (tag tag-list)
  "Return non-nil if there is a string named TAG in TAG-LIST"
  (if (arrayp tag-list)
      (loop for i from 0 below (length tag-list)
            thereis (string= tag (aref tag-list i)))
    (member tag tag-list)))

(defun simplenote2--make-tag-list ()
  (let ((files
	 (mapcar 'file-name-nondirectory
		 (append
		  (directory-files (simplenote2--notes-dir) t "^[a-zA-Z0-9_\\-]+$")
		  (directory-files (simplenote2--trash-dir) t "^[a-zA-Z0-9_\\-]+$"))))
	tag-list)
    (dolist (file files)
      (let ((note-info (gethash file simplenote2-notes-info)))
        (dolist (tag (nth 4 note-info))
          (unless (member tag tag-list)
            (push tag tag-list)))))
    (setq simplenote2-tag-list tag-list)))


;;; Save/Load notes information file

(defconst simplenote2--save-file-header
  ";;; Automatically generated by `simplenote2' on %s.\n"
  "Header to be written into the `simplenote2-save-notes-info'.")

(defsubst simplenote2--trunc-list (l n)
  "Return from L the list of its first N elements."
  (let (nl)
    (while (and l (> n 0))
      (setq nl (cons (car l) nl)
            n  (1- n)
            l  (cdr l)))
    (nreverse nl)))

(defun simplenote2--dump-variable (variable &optional limit)
  (let ((value (symbol-value variable)))
    (if (atom value)
        (insert (format "\n(setq %S '%S)\n" variable value))
      (when (and (integerp limit) (> limit 0))
        (setq value (simplenote2--trunc-list value limit)))
      (insert (format "\n(setq %S\n      '(" variable))
      (dolist (e value)
        (insert (format "\n        %S" e)))
      (insert "\n        ))\n"))))

(defun simplenote2-save-notes-info ()
  (condition-case error
      (with-temp-buffer
        (erase-buffer)
        (insert (format simplenote2--save-file-header (current-time-string)))
        (simplenote2--dump-variable 'simplenote2-notes-info)
        (simplenote2--dump-variable 'simplenote2-new-notes-info)
        (simplenote2--dump-variable 'simplenote2-tag-list)
        (simplenote2--dump-variable 'simplenote2-notes-info-version)
        (write-file simplenote2--filename-for-notes-info)
        nil)
    (error (warn "Simplenote2: %s" (error-message-string error)))))

(defun simplenote2-load-notes-info ()
  (when (file-readable-p simplenote2--filename-for-notes-info)
    (load-file simplenote2--filename-for-notes-info)))

(defun simplenote2--save-note (note)
  "Save note information and content gotten from server."
  (let ((key (cdr (assq 'key note)))
        (systemtags (cdr (assq 'systemtags note)))
        (createdate (string-to-number (cdr (assq 'createdate note))))
        (modifydate (string-to-number (cdr (assq 'modifydate note))))
        (content (cdr (assq 'content note))))
    ;; Save note information to 'simplenote2-notes-info
    (puthash key (list (cdr (assq 'syncnum note))
                       (cdr (assq 'version note))
                       createdate
                       modifydate
                       (append (cdr (assq 'tags note)) nil)
                       (simplenote2--tag-existp "markdown" systemtags)
                       (simplenote2--tag-existp "pinned" systemtags)
                       nil)
             simplenote2-notes-info)
    ;; Write note content to local file
    ;; "content" may not be returned from server in the case process is "update"
    ;; but content isn't changed
    (when content
      (let ((file (simplenote2--filename-for-note key))
            (text (decode-coding-string content 'utf-8)))
        (write-region text nil file nil)
        (set-file-times file (seconds-to-time modifydate))))
    key))


;;; Simplenote authentication

(defun simplenote2--email ()
  (when (not simplenote2-email)
    (setq simplenote2-email (read-string "Simplenote email: "))
    (setq simplenote2--email-was-read-interactively t))
  simplenote2-email)

(defun simplenote2--password ()
  (when (not simplenote2-password)
    (setq simplenote2-password (read-passwd "Simplenote password: "))
    (setq simplenote2--password-was-read-interactively t))
  simplenote2-password)

(defun simplenote2--get-token-deferred ()
  "Return simplenote token wrapped with deferred object

This function returns cached token if it has been already gotten,
otherwise gets token from server using `simplenote2-email' and
`simplenote2-password' and cache it for future use."
  (if simplenote2--token
      (deferred:next (lambda () simplenote2--token))
    (deferred:$
      (request-deferred
       (concat simplenote2--server-url "api/login")
       :type "POST"
       :data (base64-encode-string
              (format "email=%s&password=%s"
                      (url-hexify-string (simplenote2--email))
                      (url-hexify-string (simplenote2--password))))
       :parser 'buffer-string)
      (deferred:nextc it
        (lambda (res)
          (if (request-response-error-thrown res)
              (progn
                (if simplenote2--email-was-read-interactively
                    (setq simplenote2-email nil))
                (if simplenote2--password-was-read-interactively
                    (setq simplenote2-password nil))
                (setq simplenote2--token nil)
                (error "Simplenote authentication failed"))
            (message "Simplenote authentication succeeded")
            (setq simplenote2--token (request-response-data res))))))))


;;; API calls for index and notes

(defun simplenote2--get-index-deferred (&optional index mark)
  "Get note index from server and return it wrapped with deferred

Index returned is a list whose element consists of (KEY . SYNCNUM), where
KEY is a string for note key and SYNCNUM is a number which means the times
of syncing note. Notes marked as deleted are not included in the list.

This function is intended to be called recursively. When MARK is non-nil,
it's added to the parameter for requesting index, and index gotten from
server is concatenated to the index provided by INDEX."
  (lexical-let ((index index)
                (mark mark))
    (deferred:nextc
      (simplenote2--get-token-deferred)
      (lambda (token)
        (deferred:$
          (let ((params (list '("length" . "100")
                              (cons "auth" token)
                              (cons "email" simplenote2-email))))
            (when mark (push (cons "mark" mark) params))
            (request-deferred
             (concat simplenote2--server-url "api2/index")
             :type "GET"
             :params params
             :parser 'json-read))
          (deferred:nextc it
            (lambda (res)
              (if (request-response-error-thrown res)
                  (progn (message "Could not get index") t)
                (mapc (lambda (e)
                        (unless (= (cdr (assq 'deleted e)) 1)
                          (push (cons (cdr (assq 'key e))
                                      (cdr (assq 'syncnum e))) index)))
                      (cdr (assq 'data (request-response-data res))))
                (if (assq 'mark (request-response-data res))
                    (simplenote2--get-index-deferred
                     index
                     (cdr (assq 'mark (request-response-data res))))
                  index)))))))))

(defun simplenote2--get-note-deferred (key)
  "Get note information for KEY including content from server"
  (lexical-let ((key key))
    (deferred:nextc
      (simplenote2--get-token-deferred)
      (lambda (token)
        (deferred:$
          (request-deferred
           (concat simplenote2--server-url "api2/data/" key)
           :type "GET"
           :params (list (cons "auth" token)
                         (cons "email" simplenote2-email))
           :parser 'json-read)
          (deferred:nextc it
            (lambda (res)
              (if (request-response-error-thrown res)
                  (message "Could not retreive note %s" key)
                (simplenote2--save-note (request-response-data res))))))))))

(defun simplenote2--mark-note-as-deleted-deferred (key)
  "Request server to mark note for KEY as deleted"
  (lexical-let ((key key))
    (deferred:nextc
      (simplenote2--get-token-deferred)
      (lambda (token)
        (deferred:$
          (request-deferred
           (concat simplenote2--server-url "api2/data/" key)
           :type "POST"
           :params (list (cons "auth" token)
                         (cons "email" simplenote2-email))
           :data (json-encode (list (cons "deleted" 1)))
           :parser 'json-read)
          (deferred:nextc it
            (lambda (res)
              (if (request-response-error-thrown res)
                  (progn (message "Could not delete note %s" key) nil)
                (request-response-data res)))))))))

(defun simplenote2--update-note-deferred (key)
  "Request server to update note for KEY with local data"
  (lexical-let ((key key)
                (file (simplenote2--filename-for-note key))
                (note-info (gethash key simplenote2-notes-info)))
    (deferred:nextc
      (simplenote2--get-token-deferred)
      (lambda (token)
        (deferred:$
          (let ((post-data
                 (list (cons "content" (url-hexify-string
                                        (simplenote2--get-file-string file)))
                       (cons "version" (number-to-string
                                        (if note-info (nth 1 note-info) 0)))
                       (cons "modifydate"
                             (simplenote2--time-to-seconds
                              (simplenote2--file-mtime file))))))
            ;; When locally modified flag is set, update tags and systemtags
            (when (nth 7 note-info)
              (let ((system-tags []))
                (when (nth 5 note-info)
                  (setf system-tags (vconcat system-tags ["markdown"])))
                (when (nth 6 note-info)
                  (setf system-tags (vconcat system-tags ["pinned"])))
                (push (cons "systemtags" system-tags) post-data))
              ;; json-encode can handle list as the same as array, but only
              ;; "empty" tags should be described as [] because empty list
              ;; (which is the same as nil) is converted to "null".
              (push (cons "tags" (if (nth 4 note-info) (nth 4 note-info) []))
                    post-data))
            (request-deferred
             (concat simplenote2--server-url "api2/data/" key)
             :type "POST"
             :params (list (cons "auth" token)
                           (cons "email" simplenote2-email))
             :data (json-encode post-data)
             :headers '(("Content-Type" . "application/json"))
             :parser 'json-read))
          (deferred:nextc it
            (lambda (res)
              (if (request-response-error-thrown res)
                  (progn (message "Could not update note %s" key) nil)
                (simplenote2--save-note (request-response-data res))))))))))

(defun simplenote2--create-note-deferred (file)
  "Request server to create a note whose content is FILE"
  (lexical-let ((file file)
                (note-info
                 (and (string-match (simplenote2--new-notes-dir)
                                     (file-name-directory file))
                       (gethash (file-name-nondirectory file)
                                simplenote2-new-notes-info)))
                (content (simplenote2--get-file-string file))
                (createdate (simplenote2--time-to-seconds
                             (simplenote2--file-mtime file))))
    (deferred:nextc
      (simplenote2--get-token-deferred)
      (lambda (token)
        (deferred:$
          (let ((post-data
                 (list (cons "content" (url-hexify-string content))
                       (cons "createdate" createdate)
                       (cons "modifydate" createdate))))
            ;; When note info exists (which means the note is under simplenote
            ;; dir), and locally modified flag is set, add tags and systemtags
            (when (nth 7 note-info)
              (let ((system-tags []))
                (when (nth 5 note-info)
                  (setf system-tags (vconcat system-tags ["markdown"])))
                (when (nth 6 note-info)
                  (setf system-tags (vconcat system-tags ["pinned"])))
                (push (cons "systemtags" system-tags) post-data))
              (when (nth 4 note-info)
                (push (cons "tags" (nth 4 note-info)) post-data)))
            (request-deferred
             (concat simplenote2--server-url "api2/data")
             :type "POST"
             :params (list (cons "auth" token)
                           (cons "email" simplenote2-email))
             :data (json-encode post-data)
             :headers '(("Content-Type" . "application/json"))
             :parser 'json-read))
          (deferred:nextc it
            (lambda (res)
              (if (request-response-error-thrown res)
                  (progn (message "Could not create note") nil)
                (let ((note (request-response-data res)))
                  (push (cons 'content content) note)
                  (simplenote2--save-note note))))))))))


;;; Push and pull buffer as note

(defun simplenote2-push-buffer ()
  "Push changes to server which are added to the note currently visiting

This function works depending on where the current buffer file is located. 
1) If the file is on new note directory, it does just the same process as
   `simplenote2-create-note-from-buffer'.
2) If the file is on notes directory, it requests server to merge changes
   locally added to the note.
3) Otherwise, show error message and do nothing."
  (interactive)
  (lexical-let ((file (buffer-file-name))
                (buf (current-buffer)))
    (cond
     ;; File is located on new notes directory
     ((string-match (simplenote2--new-notes-dir)
                    (file-name-directory file))
      (simplenote2-create-note-from-buffer))
     ;; File is located on notes directory
     ((string-match (simplenote2--notes-dir)
                    (file-name-directory file))
      (lexical-let* ((key (file-name-nondirectory file))
                     (note-info (gethash key simplenote2-notes-info)))
        (save-buffer)
        (if (and note-info
                 (or (time-less-p (seconds-to-time (nth 3 note-info))
                                  (simplenote2--file-mtime file))
                     (nth 7 note-info)))
            (deferred:nextc
              (simplenote2--update-note-deferred key)
              (lambda (ret)
                (if ret (progn
                          (message "Pushed note %s" key)
                          (when (eq buf (current-buffer))
                            (revert-buffer nil t t))
                          (simplenote2-browser-refresh))
                  (message "Failed to push note %s" key))))
          (message "No need to push this note"))))
    (t (message "This buffer is not a Simplenote note")))))

;;;###autoload
(defun simplenote2-create-note-from-buffer ()
  "Create a new note from the buffer currently visiting

This function requests server to create a new note. The buffer currently
visiting is used as the content of the note. When the note is created
successfully, the current buffer file is moved to `simplenote2-directory'
and can be handled from the browser screen."
  (interactive)
  (lexical-let ((file (buffer-file-name))
                (buf (current-buffer)))
    (if (or (string= (simplenote2--notes-dir) (file-name-directory file))
            (not file))
        (message "Can't create note from this buffer")
      (save-buffer)
      (deferred:nextc
        (simplenote2--create-note-deferred file)
        (lambda (key)
          (if (not key)
              (message "Failed to create note")
            (message "Created note %s" key)
            (when (string= (simplenote2--new-notes-dir) (file-name-directory file))
              (remhash (file-name-nondirectory file) simplenote2-new-notes-info))
            (let ((new-file (simplenote2--filename-for-note key)))
              (rename-file file new-file t)
              (rename-buffer new-file)
              (set-visited-file-name new-file)
              (set-buffer-modified-p nil))
            (simplenote2-browser-refresh)))))))

(defun simplenote2-pull-buffer ()
  "Pull the latest status of note currently visiting from the server

This function retrieves the latest status of note including content from the
server, and overwrite local data with them. In the case the note is modified
locally, you'll be asked if you push the modification to the server first.
If you answer yes, this function does the same as `simplenote2-push-buffer'.
Otherwise, the local modification is discarded."
  (interactive)
  (lexical-let ((file (buffer-file-name))
                (buf (current-buffer)))
    (if (string= (simplenote2--notes-dir) (file-name-directory file))
        (lexical-let* ((key (file-name-nondirectory file))
                       (note-info (gethash key simplenote2-notes-info)))
          (if (and note-info
                   (or (time-less-p (seconds-to-time (nth 3 note-info))
                                    (simplenote2--file-mtime file))
                       (nth 7 note-info))
                   (y-or-n-p
                    "This note appears to have been modified. Do you push it on ahead?"))
              (simplenote2-push-buffer)
            (save-buffer)
            (deferred:nextc
              (simplenote2--get-note-deferred key)
              (lambda (ret)
                (when (eq buf (current-buffer))
                  (revert-buffer nil t t))
                (simplenote2-browser-refresh)))))
      (message "This buffer is not a Simplenote note"))))


;;; Browser helper functions

(defun simplenote2--trash-dir ()
  (file-name-as-directory (concat (file-name-as-directory simplenote2-directory) "trash")))

(defun simplenote2--notes-dir ()
  (file-name-as-directory (concat (file-name-as-directory simplenote2-directory) "notes")))

(defun simplenote2--new-notes-dir ()
  (file-name-as-directory (concat (file-name-as-directory simplenote2-directory) "new")))

;;;###autoload
(defun simplenote2-setup ()
  (interactive)
  (simplenote2-load-notes-info)
  (add-hook 'kill-emacs-hook 'simplenote2-save-notes-info)
  (when (not (file-exists-p simplenote2-directory))
    (make-directory simplenote2-directory t))
  (when (not (file-exists-p (simplenote2--notes-dir)))
    (make-directory (simplenote2--notes-dir) t))
  (when (not (file-exists-p (simplenote2--trash-dir)))
    (make-directory (simplenote2--trash-dir) t))
  (when (not (file-exists-p (simplenote2--new-notes-dir)))
    (make-directory (simplenote2--new-notes-dir) t)))

(defun simplenote2--filename-for-note (key)
  (concat (simplenote2--notes-dir) key))

(defun simplenote2--filename-for-note-marked-deleted (key)
  (concat (simplenote2--trash-dir) key))

(defun simplenote2--note-headline (text)
  "The first non-empty line of a note."
  (let ((begin (string-match "^.+$" text)))
    (when begin
      (substring text begin (min (match-end 0)
                                 (+ begin simplenote2-note-head-size))))))

(defun simplenote2--note-headrest (text)
  "Text after the first non-empty line of a note, to fill in the list display."
  (let* ((headline (simplenote2--note-headline text))
         (text (replace-regexp-in-string "\n" " " text))
         (begin (when headline (string-match (regexp-quote headline) text))))
    (when begin
      (truncate-string-to-width (substring text (match-end 0)) (- simplenote2-note-head-size (string-width headline))))))

(defun simplenote2--open-note (file)
  "Opens FILE in a new buffer, setting its mode, and returns the buffer.

The major mode of the resulting buffer will be set to
`simplenote2-notes-mode' but can be overridden by a file-local
setting."
  (prog1 (find-file-other-window file)
    ;; Don't switch mode when set via file cookie
    (when (eq major-mode (default-value 'major-mode))
      (let* ((key (file-name-nondirectory file))
             (note-info (or (gethash key simplenote2-notes-info)
                            (gethash key simplenote2-new-notes-info))))
        (funcall (if (nth 5 note-info)
                     simplenote2-markdown-notes-mode
                   simplenote2-notes-mode))))
    (simplenote2-note-mode)
    ;; Refresh notes display after save
    (add-hook 'after-save-hook
              (lambda () (simplenote2-browser-refresh))
              nil t)))


;; Simplenote sync

(defun simplenote2-sync-notes (&optional arg)
  "Sync all notes between the server and the local data

This function syncs all notes between the server and the local data. The steps
of the process are as below.

1) Sync update made on local side.
  1. Delete notes locally marked as deleted.
  2. Push notes locally created.
  3. Push modifications locally added.
2) Sync update made on server side.
  1. Get the index of notes from the server, then
    a) Delete notes which aren't included in the index.
    b) Update/Create notes which are older then that on server.

If the prefix ARG is specified, this function doesn't check if the local data
is older than that on server in the step 2)-1-b) above, which means all notes
are retrieved from the server forcefully."
  (interactive "P")
  (when simplenote2--sync-process-running
      (error "Simplenote sync process is still running"))
  (setq simplenote2--sync-process-running t)
  (message "Start syncing...")
  (lexical-let ((arg arg))
    (deferred:$
      ;; Step1: Sync update on local
      (deferred:parallel
        (append
         ;; Step1-1: Delete notes locally marked as deleted.
         (mapcar (lambda (file)
                   (lexical-let* ((file file)
                                  (key (file-name-nondirectory file)))
                     (deferred:nextc
                       (simplenote2--mark-note-as-deleted-deferred key)
                       (lambda (ret) (when ret
                                       (message "Deleted on local: %s" key)
                                       (remhash key simplenote2-notes-info)
                                       (let ((buf (get-file-buffer file)))
                                         (when buf (kill-buffer buf)))
                                       (delete-file file))))))
                 (directory-files (simplenote2--trash-dir) t "^[a-zA-Z0-9_\\-]+$"))
         ;; Step1-2: Push notes locally created
         (mapcar (lambda (file)
                   (lexical-let ((file file))
                     (deferred:nextc
                       (simplenote2--create-note-deferred file)
                       (lambda (key) (when key
                                       (message "Created on local: %s" key)
                                       (let ((buf (get-file-buffer file)))
                                         (when buf (kill-buffer buf)))
                                       (remhash (file-name-nondirectory file)
                                                simplenote2-new-notes-info)
                                       (delete-file file))))))
                 (directory-files (simplenote2--new-notes-dir) t "^note-[0-9]+$"))
         ;; Step1-3: Push notes locally modified
         (let (files-to-push)
           (dolist (file (directory-files
                          (simplenote2--notes-dir) t "^[a-zA-Z0-9_\\-]+$"))
             (let ((note-info (gethash (file-name-nondirectory file)
                                       simplenote2-notes-info)))
               (when (and note-info
                          (or (time-less-p (seconds-to-time (nth 3 note-info))
                                           (simplenote2--file-mtime file))
                              (nth 7 note-info)))
                 (push file files-to-push))))
           (mapcar (lambda (file)
                     (lexical-let ((key (file-name-nondirectory file)))
                       (deferred:nextc
                         (simplenote2--update-note-deferred key)
                         (lambda (ret) (when (eq ret key)
                                         (message "Updated on local: %s" key))))))
                   files-to-push))))
      ;; Step2: Sync update on server
      (deferred:nextc it
        (lambda ()
          (message "Syncing update on local done")
          ;; Step2-1: Get index from server and update local files.
          (deferred:nextc
            (simplenote2--get-index-deferred)
            (lambda (index)
              (if (eq index t)
                  ;; Failed to get index, skip the following steps.
                  (progn
                    (setq simplenote2--sync-process-running nil)
                    (message "Failed to get index, abort sync"))
                ;; Step2-2: Delete notes on local which are not included in the index.
                (message "Getting index from server done")
                (let ((keys-in-index (mapcar (lambda (e) (car e)) index)))
                  (dolist (file (directory-files
                                 (simplenote2--notes-dir) t "^[a-zA-Z0-9_\\-]+$"))
                    (let ((key (file-name-nondirectory file)))
                      (unless (member key keys-in-index)
                        (message "Deleted on server: %s" key)
                        (remhash key simplenote2-notes-info)
                        (let ((buf (get-file-buffer file)))
                          (when buf (kill-buffer buf)))
                        (delete-file file)))))
                ;; Step2-3: Update notes on local which are older than that on server.
                (let (keys-to-update)
                  (if (not arg)
                      (dolist (elem index)
                        (let* ((key (car elem))
                               (note-info (gethash key simplenote2-notes-info)))
                          ;; Compare syncnum on server and local data.
                          ;; If the note information isn't found, the note would be a
                          ;; newly created note on server.
                          (when (< (if note-info (nth 0 note-info) 0) (cdr elem))
                            (message "Updated on server: %s" key)
                            (push key keys-to-update))))
                    (setq keys-to-update (mapcar (lambda (e) (car e)) index)))
                  (deferred:nextc
                    (deferred:parallel
                      (mapcar (lambda (key) (simplenote2--get-note-deferred key))
                              keys-to-update))
                    (lambda (notes)
                      (simplenote2--make-tag-list)
                      (simplenote2-save-notes-info)
                      (setq simplenote2--sync-process-running nil)
                      (message "Syncing all notes done")
                      ;; Refresh the browser
                      (simplenote2-browser-refresh)))))))))
      (deferred:error it
        (lambda (err)
          (message "Sync notes error: %s" err)
          (setq simplenote2--sync-process-running nil))))))


;;; Simplenote browser

(defvar simplenote2-browser-mode-map
  (let ((map (copy-keymap widget-keymap)))
    (define-key map (kbd "g") 'simplenote2-sync-notes)
    (define-key map (kbd "q") 'quit-window)
    (define-key map (kbd "n") 'widget-forward)
    (define-key map (kbd "p") 'widget-backward)
    map))

(defun simplenote2-browser-mode ()
  "Browse and edit Simplenote notes locally and sync with the server.

\\{simplenote2-browser-mode-map}"
  (kill-all-local-variables)
  (setq buffer-read-only t)
  (use-local-map simplenote2-browser-mode-map)
  (simplenote2--menu-setup)
  (setq major-mode 'simplenote2-browser-mode
        mode-name "Simplenote")
  (run-mode-hooks 'simplenote2-browser-mode-hook))

;;;###autoload
(defun simplenote2-browse ()
  "Show Simplenote browser screen"
  (interactive)
  (when (not (file-exists-p simplenote2-directory))
      (make-directory simplenote2-directory t))
  (switch-to-buffer "*Simplenote*")
  (simplenote2-browser-mode)
  (goto-char 1))

(defun simplenote2-browser-refresh ()
  "Refresh Simplenote browser screen"
  (interactive)
  (save-excursion
    (when (get-buffer "*Simplenote*")
      (set-buffer "*Simplenote*")
      (simplenote2--menu-setup))))


(defun simplenote2--menu-setup ()
  (let ((inhibit-read-only t))
    (erase-buffer))
  (remove-overlays)
  ;; Buttons
  (widget-create 'link
                 :format "%[%v%]"
                 :help-echo "Synchronize with the Simplenote server"
                 :notify (lambda (widget &rest ignore)
                           (simplenote2-sync-notes)
                           (simplenote2-browser-refresh))
                 "Sync with server")
  (widget-insert "  ")
  (widget-create 'link
                 :format "%[%v%]"
                 :help-echo "Create a new note"
                 :notify (lambda (widget &rest ignore)
                           (let (buf)
                             (setq buf (simplenote2--create-note-locally))
                             (simplenote2-browser-refresh)
                             (switch-to-buffer buf)
                             (run-hooks 'simplenote2-create-note-hook)))
                 "Create new note")
  (widget-insert "\n\n")
  ;; New notes list
  (let ((new-notes (directory-files (simplenote2--new-notes-dir) t "^note-[0-9]+$")))
    (when new-notes
      (widget-insert "== NEW NOTES\n\n")
      (mapc 'simplenote2--new-note-widget new-notes)))
  ;; Other notes list
  (let (files)
    (setq files (append
                 (mapcar (lambda (file) (cons file nil))
                         (directory-files (simplenote2--notes-dir) t "^[a-zA-Z0-9_\\-]+$"))
                 (mapcar (lambda (file) (cons file t))
                         (directory-files (simplenote2--trash-dir) t "^[a-zA-Z0-9_\\-]+$"))))
    (when files
      (setq files (sort files (lambda (p1 p2) (simplenote2--file-newer-p (car p1) (car p2)))))
      (setq files (sort files (lambda (p1 p2) (simplenote2--pinned-note-p (car p1) (car p2)))))
      (widget-insert "== NOTES")
      (dolist (tag simplenote2-filter-note-tag-list)
        (widget-insert (format " [%s]" tag)))
      (widget-insert "\n\n")
      (dolist (file files)
        (let ((note-info (gethash (file-name-nondirectory (car file))
                                  simplenote2-notes-info)))
          (when (or (not simplenote2-filter-note-tag-list)
                    (loop for tag in simplenote2-filter-note-tag-list
                          when (simplenote2--tag-existp tag (nth 4 note-info))
                          collect tag))
            (simplenote2--other-note-widget file))))))
  (use-local-map simplenote2-browser-mode-map)
  (widget-setup))

(defun simplenote2-filter-note-by-tag (&optional arg)
  "Filter the notes displayed on the browser by tags

This function sets the filter used for the browser screen interactively.
You can specify one or more tags until you input just [enter]. If the prefix
ARG is specified, this function resets the filter already set."
  (interactive "P")
  (setq simplenote2-filter-note-tag-list nil)
  (when (not arg)
    (let (tag)
      (setq tag (completing-read "Input tag: " simplenote2-tag-list))
      (while (not (string= tag ""))
        (push tag simplenote2-filter-note-tag-list)
        (setq tag (read-string "Input tag: ")))))
  (simplenote2-browser-refresh))

(defun simplenote2-add-tag (arg)
  "Add a tag to the note currently visiting"
  (interactive "p")
  (let* ((file (buffer-file-name))
         (key (file-name-nondirectory file))
         (note-info (or (gethash key simplenote2-notes-info)
                        (gethash key simplenote2-new-notes-info)))
         tag)
    (if (not note-info)
        (message "This buffer is not a Simplenote note")
      (if (called-interactively-p 'interactive)
          (setq tag (completing-read "Input tag: " simplenote2-tag-list))
        (setq tag (if (stringp arg) arg "")))
      (unless (or (string= tag "")
                  (simplenote2--tag-existp tag (nth 4 note-info)))
        (push tag (nth 4 note-info))
        (setf (nth 7 note-info) t)
        (simplenote2-browser-refresh)
        (message "Added tag: %s" tag)))))

(defun simplenote2-delete-tag ()
  "Delete a tag from the note currently visiting"
  (interactive)
  (let* ((file (buffer-file-name))
         (key (file-name-nondirectory file))
         (note-info (or (gethash key simplenote2-notes-info)
                        (gethash key simplenote2-new-notes-info)))
         tag)
    (if (not note-info)
        (message "This buffer is not a Simplenote note")
      (setq tag (completing-read "Input tag: " (nth 4 note-info) nil t))
      (setf (nth 4 note-info) (remove tag (nth 4 note-info)))
      (setf (nth 7 note-info) t)
      (simplenote2-browser-refresh)
      (message "Deleted tag: %s" tag))))

(defun simplenote2-set-markdown (&optional arg)
  "Set/reset markdown flag to the note currently visiting"
  (interactive "P")
  (let* ((file (buffer-file-name))
         (key (file-name-nondirectory file))
         (note-info (or (gethash key simplenote2-notes-info)
                        (gethash key simplenote2-new-notes-info))))
    (if (not note-info)
        (message "This buffer is not a Simplenote note")
      (unless (eq (not arg) (nth 5 note-info))
        (setf (nth 5 note-info) (if arg nil t))
        (setf (nth 7 note-info) t)
        (funcall (if (nth 5 note-info)
                     simplenote2-markdown-notes-mode
                   simplenote2-notes-mode))
        (simplenote2-browser-refresh)
        (message "%s markdown flag" (if arg "Unset" "Set"))))))

(defun simplenote2-set-pinnped (&optional arg)
  "Set/reset pinned flag to the note currently visiting"
  (interactive "P")
  (let* ((file (buffer-file-name))
         (key (file-name-nondirectory file))
         (note-info (or (gethash key simplenote2-notes-info)
                        (gethash key simplenote2-new-notes-info))))
    (if (not note-info)
        (message "This buffer is not a Simplenote note")
      (unless (eq (not arg) (nth 6 note-info))
        (setf (nth 6 note-info) (if arg nil t))
        (setf (nth 7 note-info) t)
        (simplenote2-browser-refresh)
        (message "%s pinned flag" (if arg "Unset" "Set"))))))

(defun simplenote2--file-newer-p (file1 file2)
  (let (time1 time2)
    (setq time1 (nth 5 (file-attributes file1)))
    (setq time2 (nth 5 (file-attributes file2)))
    (time-less-p time2 time1)))

(defun simplenote2--pinned-note-p (file1 file2)
  (and (nth 6 (gethash (file-name-nondirectory file1) simplenote2-notes-info))
       (not (nth 6 (gethash (file-name-nondirectory file2) simplenote2-notes-info)))))

(defun simplenote2--new-note-widget (file)
  (let* ((modify (nth 5 (file-attributes file)))
         (modify-string (format-time-string "%Y-%m-%d %H:%M:%S" modify))
         (note (simplenote2--get-file-string file))
         (note-info (gethash (file-name-nondirectory file) simplenote2-new-notes-info))
         (headline (concat (if (nth 6 note-info) "*" "")
                           (simplenote2--note-headline note)))
         (shorttext (or (simplenote2--note-headrest note) "[Empty]")))
    (widget-create 'link
                   :button-prefix ""
                   :button-suffix ""
                   :format "%[%v%]"
                   :tag file
                   :help-echo "Edit this note"
                   :notify (lambda (widget &rest ignore)
                             (simplenote2--open-note (widget-get widget :tag)))
                   headline)
    (widget-insert shorttext "\n")
    (widget-insert "  " modify-string "\t")
    (widget-create 'link
                   :format "%[%v%]"
                   :tag file
                   :help-echo "Permanently remove this file"
                   :notify (lambda (widget &rest ignore)
                             (let ((file (widget-get widget :tag)))
                               (delete-file file)
                               (remhash (file-name-nondirectory file)
                                        simplenote2-new-notes-info)
                               (let ((buf (get-file-buffer file)))
                                 (when buf (kill-buffer buf)))
                               (simplenote2-browser-refresh)))
                   "Remove")
    (widget-insert "\t")
    (dolist (tag (nth 4 note-info))
      (widget-insert (format "[%s] " tag)))
    (widget-insert "\n\n")))

(defun simplenote2--other-note-widget (pair)
  (let* ((file (car pair))
         (deleted (cdr pair))
         (key (file-name-nondirectory file))
         (modify (nth 5 (file-attributes file)))
         (modify-string (format-time-string "%Y-%m-%d %H:%M:%S" modify))
         (note (simplenote2--get-file-string file))
         (note-info (gethash key simplenote2-notes-info))
         (headline (concat (if (nth 6 note-info) "*" "")
                           (simplenote2--note-headline note)))
         (shorttext (or (simplenote2--note-headrest note) "[Empty]")))
    (widget-create 'link
                   :button-prefix ""
                   :button-suffix ""
                   :format "%[%v%]"
                   :tag file
                   :help-echo "Edit this note"
                   :notify (lambda (widget &rest ignore)
                             (simplenote2--open-note (widget-get widget :tag)))
                   headline)
    (widget-insert shorttext "\n")
    (widget-insert "  " modify-string "\t")
    (widget-create 'link
                   :format "%[%v%]"
                   :tag key
                   :help-echo (if deleted
                                  "Mark this note as not deleted"
                                "Mark this note as deleted")
                   :notify (if deleted
                               simplenote2--undelete-me
                             simplenote2--delete-me)
                   (if deleted
                       "Undelete"
                     "Delete"))
    (widget-insert "\t")
    (dolist (tag (nth 4 note-info))
      (widget-insert (format "[%s] " tag)))
    (widget-insert "\n    ")
    (when simplenote2-show-note-file-name
      (widget-insert (propertize key 'face 'shadow)))
    (widget-insert "\n")))

(setq simplenote2--delete-me
      (lambda (widget &rest ignore)
        (simplenote2--mark-note-for-deletion (widget-get widget :tag))
        (widget-put widget :notify simplenote2--undelete-me)
        (widget-value-set widget "Undelete")
        (widget-setup)))

(setq simplenote2--undelete-me
  (lambda (widget &rest ignore)
    (simplenote2--unmark-note-for-deletion (widget-get widget :tag))
    (widget-put widget :notify simplenote2--delete-me)
    (widget-value-set widget "Delete")
    (widget-setup)))

(defun simplenote2--mark-note-for-deletion (key)
  (rename-file (simplenote2--filename-for-note key)
               (simplenote2--filename-for-note-marked-deleted key)))

(defun simplenote2--unmark-note-for-deletion (key)
  (rename-file (simplenote2--filename-for-note-marked-deleted key)
               (simplenote2--filename-for-note key)))

(defun simplenote2--create-note-locally ()
  (let (new-filename counter)
    (setq counter 0)
    (setq new-filename (concat (simplenote2--new-notes-dir) (format "note-%d" counter)))
    (while (file-exists-p new-filename)
      (setq counter (1+ counter))
      (setq new-filename (concat (simplenote2--new-notes-dir) (format "note-%d" counter))))
    (write-region "New note" nil new-filename nil)
    ;; Save note information to 'simplenote2-new-notes-info
    (puthash (file-name-nondirectory new-filename)
             (list 0 0 (simplenote2--file-mtime new-filename) 0 nil nil nil nil)
             simplenote2-new-notes-info)
    (simplenote2-browser-refresh)
    (simplenote2--open-note new-filename)))

(defvar simplenote2-note-mode-map (make-sparse-keymap))

(define-minor-mode simplenote2-note-mode ()
  "Enable for Simplenote note"
  :group      'simplenote2
  :init-value nil
  :global     nil
  :keymap     simplenote2-note-mode-map
  :lighter    " S-note"
  (if simplenote2-note-mode
      (run-hooks 'simplenote2-note-mode-hook)))


(provide 'simplenote2)

;;; simplenote2.el ends here
