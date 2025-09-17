(setq byte-compile-warnings '(not cl-functions obsolete))
(setq warning-suppress-types '((comp cl-functions) 
                             (comp obsolete)
                             (defvaralias)))

;(setq desktop-path '("~/code/emacs/desktop")) 
;(desktop-save-mode 1)

(require 'cl-lib)

(add-to-list 'load-path "~/.emacs.d/custom")

;; bootstrap straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; end bootstrap straight

(straight-use-package
 '(clojure-mode :type git
                :host github
                :repo "clojure-emacs/clojure-mode"))
(require 'clojure-mode)

(straight-use-package 'helm)

(setq helm-split-window-in-side-p t)
(setq helm-split-window-preferred-function 'split-window-below)

(straight-use-package 'gptel)

(defvar my-gptel-claude
  (gptel-make-anthropic "Claude"
    :key (lambda ()
           (string-trim
            (shell-command-to-string "security find-generic-password -s anthropic-api-key -w")))
    :stream t))

(defvar my-gptel-gemini
  (gptel-make-gemini "Gemini"
    :key (lambda ()
           (string-trim
            (shell-command-to-string "security find-generic-password -s gemini-api-key -w")))
    :stream t))


;; Define model preferences as an association list (backend name -> preferred model)
(defvar my-gptel-model-preferences
  '(("Claude" . claude-3-7-sonnet-20250219)
    ("Gemini" . gemini-2.5-pro-exp-03-25))
  "Association list mapping backend names to preferred models.")

;; Function to switch between backends
(defun my-gptel-switch-backend ()
  "Switch gptel backend interactively."
  (interactive)
  (let* ((backend-list (list my-gptel-claude my-gptel-gemini))
         (backend-names (mapcar #'gptel-backend-name backend-list))
         (selected-name (completing-read 
                         "Select backend: " 
                         backend-names
                         nil t))
         (selected-backend (cl-find-if (lambda (backend)
                                         (string= (gptel-backend-name backend) selected-name))
                                       backend-list))
         (preferred-model (cdr (assoc selected-name my-gptel-model-preferences))))
    (when selected-backend
      (setq gptel-backend selected-backend)
      ;; Set the preferred model for this backend
      (when preferred-model
        (setq gptel-model preferred-model))
      (message "Switched to %s backend with model %s" 
               selected-name 
               (symbol-name gptel-model)))))

;; Set initial default backend and model
(let* ((default-backend-name "Gemini")
       (default-backend my-gptel-gemini)
       (default-model (cdr (assoc default-backend-name my-gptel-model-preferences))))
  (setq gptel-backend default-backend
        gptel-model default-model))

;; TODO: remove if above works
;(setq gptel-model 'gemini-2.5-pro-exp-03-25
;      gptel-backend my-gptel-gemini)

(straight-use-package
 '(helm-ls-git :type git
               :host github
               :repo "emacs-helm/helm-ls-git"))
(require 'helm-ls-git)

(straight-use-package
 '(monroe :type git
          :host github
          :repo "sanel/monroe"
          :commit "508f5ed0f88b0b5e01a37d456186ea437f44d93c" ;; note: this does NOT fix the version, i went to ~/.emacs.d/straight/repos/monroe and used git checkout directly. the right approach is to use a lockfile
          ;; reason for using a previous version is that the newer monroe tries to be multi-repl, and breaks some functionality 
          ))

(require 'monroe)
(add-hook 'clojure-mode-hook 'clojure-enable-monroe)

;; Fix monroe-get-clojure-ns to work with both clojure-mode and clojurec-mode
(defun monroe-get-clojure-ns-fixed ()
  "Get the clojure namespace for both .clj and .cljc files."
  (and (or (eq major-mode 'clojure-mode) (eq major-mode 'clojurec-mode))
       (fboundp 'clojure-find-ns)
       (funcall 'clojure-find-ns)))

;; Fix monroe-eval-namespace to work with clojure-mode and clojurec-mode
(defun monroe-eval-namespace-fixed ()
  "Evaluate the namespace form in the current buffer."
  (interactive)
  (when (monroe-get-clojure-ns-fixed)
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^(ns\\s-" nil t)
        (goto-char (match-beginning 0))
        (let ((end (save-excursion (end-of-defun) (point))))
          ;; Send ns form without namespace context so it can switch namespaces
          (monroe-input-sender
           (get-buffer-process (monroe-repl-buffer))
           (buffer-substring-no-properties (point) end)
           nil))))))  ; nil namespace so the ns form can execute properly

;; Override the original function
(advice-add 'monroe-eval-namespace :override #'monroe-eval-namespace-fixed)

;; Fix monroe-connection to handle remote connections properly
(defun monroe-connection-fixed ()
  "Returns the monroe connection, checking all possible process names."
  (or 
   ;; Try the standard local connection format
   (get-process (concat "monroe/" (monroe-locate-running-nrepl-host)))
   ;; Try extracting from current buffer name
   (when (string-match "\\*monroe: \\(.+\\)\\*" (buffer-name))
     (get-process (concat "monroe/" (match-string 1 (buffer-name)))))
   ;; Try finding any monroe process
   (car (seq-filter (lambda (p) 
                      (string-prefix-p "monroe/" (process-name p)))
                    (process-list)))))

;; Override the original monroe-connection function
(advice-add 'monroe-connection :override #'monroe-connection-fixed)

;; this adds a port name but unfortunately monroe doesn't work with it
;; (defadvice monroe-connect (after monroe-rename-buffer-with-port activate)
;;   "Rename the monroe buffer to include the port number."
;;   (let* ((hp (split-string (monroe-strip-protocol host-and-port) ":"))
;;          (port (string-to-number (monroe-valid-host-string (second hp) "7888")))
;;          (buffer (get-buffer monroe-repl-buffer)))
;;     (when buffer
;;       (with-current-buffer buffer
;;         (rename-buffer (format "*monroe:[%s]*" port) t)))))

(straight-use-package
 '(simplenote2 :type git
                :host github
                :repo "alpha22jp/simplenote2.el"))
(require 'simplenote2)

(setq evil-want-keybinding nil)

(straight-use-package
 '(evil :type git
        :host github
        :repo "emacs-evil/evil"))
(require 'evil)

(straight-use-package
 '(evil-cleverparens :type git
                :host github
                :repo "emacs-evil/evil-cleverparens"))
(require 'evil-cleverparens)

(straight-use-package 'markdown-mode)

(put 'markdown-code-block 'bounds-of-thing-at-point
     (lambda ()
       (let* ((start (save-excursion
                      (if (and (looking-at "^```") 
                              (looking-back "^" (line-beginning-position)))
                          (point)
                        (when (search-backward-regexp "^```" nil t)
                          (point)))))
              (end (when start  ; only search for end if we found start
                    (save-excursion
                      (goto-char start)
                      (forward-line)
                      (when (search-forward-regexp "^```$" nil t)
                        (line-end-position))))))
         (when (and start end)
           (cons start end)))))

(put 'markdown-code-block-content 'bounds-of-thing-at-point
     (lambda ()
       (let ((bounds (bounds-of-thing-at-point 'markdown-code-block)))
         (when bounds
           (save-excursion
             (goto-char (car bounds))
             (forward-line 1)
             (cons (point)
                   (progn
                     (goto-char (cdr bounds))
                     (forward-line -1)
                     (line-end-position))))))))

(evil-define-text-object evil-outer-markdown-code-block (count &optional beg end type)
  "Select a markdown code block (including backticks)."
  (let ((bounds (bounds-of-thing-at-point 'markdown-code-block)))
    (when bounds
      (evil-range (car bounds) (cdr bounds)))))

(evil-define-text-object evil-inner-markdown-code-block (count &optional beg end type)
  "Select inside a markdown code block (excluding backticks)."
  (let ((bounds (bounds-of-thing-at-point 'markdown-code-block-content)))
    (when bounds
      (evil-range (car bounds) (cdr bounds)))))

(define-key evil-outer-text-objects-map "c" 'evil-outer-markdown-code-block)
(define-key evil-inner-text-objects-map "c" 'evil-inner-markdown-code-block)

(straight-use-package
 '(evil-collection :type git
                   :host github
                   :repo "emacs-evil/evil-collection"))
(require 'evil-collection)

;; mac specific settings
(when (equal system-type 'darwin)
  ;; Treat option as meta and command as super
  (setq mac-option-key-is-meta t)
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))

;; Keybindings
(global-set-key (kbd "C-s-f") 'spacemacs/toggle-frame-fullscreen)
(global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-w") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "s-f") 'find-file)
(global-set-key (kbd "s-p") 'previous-buffer)
(global-set-key (kbd "s-n") 'next-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "C-s") 'save-buffer)

;;(set-face-attribute 'default nil :font "Monaco 10" :height 140)

;; Set default font and size (adjust the height value for size)
;; Height 160 = 16pt, 140 = 14pt, 120 = 12pt, 180 = 18pt, etc.
(set-face-attribute 'default nil :height 140)

;; (define-key key-translation-map (kbd "f1") (kbd "ESC"))

;; backup files in separate directory
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(clojure-defun-indents '(always-ident))
 '(column-number-mode t)
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default))
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(rust-mode scala-mode solidity-mode fennel-mode lua-mode go-mode helm-git-grep helm-ag yaml-mode with-editor web-mode tide textmate smart-tab s rainbow-delimiters queue markdown-mode magit list-processes+ linum-relative jump jade-mode html-to-markdown highlight-parentheses haml-mode evil-leader csv-mode color-theme-sanityinc-tomorrow  clojurescript-mode clojure-mode-extra-font-locking cljsbuild-mode base16-theme ack))
 '(safe-local-variable-values
   '((cider-ns-refresh-after-fn . "development/go")
     (cider-ns-refresh-before-fn . "development/stop")
     (eval put-clojure-indent :require 0)
     (clojure-indent-style . always-indent)
     (cider-refresh-after-fn . "integrant.repl/resume")
     (cider-refresh-before-fn . "integrant.repl/suspend")))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(setq default-directory "/home/wei/code")

(global-auto-revert-mode 0)

;; Fix the PATH variable
;(defun set-exec-path-from-shell-PATH ()
;  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
;    (setenv "PATH" path-from-shell)
;    (setq exec-path (split-string path-from-shell path-separator))))

(defun set-exec-path-from-shell-PATH ()
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system
  (set-exec-path-from-shell-PATH)
  (global-unset-key "\C-z"))

(global-set-key (kbd "s-t") 'helm-ls-git-ls)
(global-set-key (kbd "s-b") 'helm-buffers-list)
(global-set-key (kbd "s-F") 'helm-git-grep)

;; Package.el customization
(package-initialize)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/"))

; too slow
;(when (not package-archive-contents)
;  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/custom/tomorrow-theme")

;; Visual bell
;; http://emacsblog.org/2007/02/06/quick-tip-visible-bell/
(require 'rwd-bell)
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; PLUGINS

;; Line numbers
;; (global-linum-mode t)

;; Vim-mode (Evil-mode)
;; use default undo
(evil-set-undo-system 'undo-redo)

(evil-mode 1)

;; evil mode everywhere
(setq evil-collection-mode-list
      (remove 'gptel evil-collection-mode-list))
(evil-collection-init)
;(add-hook 'gptel-context-buffer-mode-hook 'turn-off-evil-mode)
(evil-set-initial-state 'gptel-context-buffer-mode 'emacs)
;(add-to-list 'evil-emacs-state-modes 'gptel-context-mode)

(setq evil-default-cursor t)
(electric-pair-mode 1)

;; leader
(evil-set-leader 'normal (kbd "SPC"))
;; elisp eval
(evil-define-key 'normal 'global (kbd "SPC er") 'eval-region)
(evil-define-key 'visual 'global (kbd "SPC er") 'eval-region)
(evil-define-key 'normal 'global (kbd "SPC eb") 'eval-buffer)

;; evil gptel shortcuts
(evil-global-set-key 'normal (kbd "C-.") 'gptel-send)
(evil-global-set-key 'normal (kbd "M-.") 'gptel)
(evil-global-set-key 'insert (kbd "C-.") 'gptel-send)
(evil-global-set-key 'insert (kbd "M-.") 'gptel)

;; Add current file to context
(defun my-gptel-add-current-file ()
  "Add current file to gptel conversation context"
  (interactive)
  (gptel-add-file (buffer-file-name)))

(evil-define-key 'normal 'global (kbd "SPC ..") 'gptel)           ;; Start chat (alternative to C-.)
(evil-define-key 'normal 'global (kbd "SPC .f") 'my-gptel-add-current-file)
(evil-define-key 'normal 'global (kbd "SPC .t") 'my-gptel-switch-backend)
(evil-define-key 'normal 'global (kbd "SPC .a") 'gptel-add)
(evil-define-key 'normal 'global (kbd "SPC .s") 'gptel-send)     ;; Send region (alternative to M-.)
(evil-define-key 'normal 'global (kbd "SPC .n") 'gptel-next)     ;; Next chat session
(evil-define-key 'normal 'global (kbd "SPC .p") 'gptel-prev)     ;; Previous chat session 
(evil-define-key 'normal 'global (kbd "SPC .k") 'gptel-abort)    ;; Kill/abort current request
(evil-define-key 'normal 'global (kbd "SPC .m") 'gptel-menu)     ;; GPT settings menu

;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key (kbd "C-u") 'scroll-down-command)

(global-set-key [M-backspace] 'backward-kill-word)
(define-key minibuffer-local-map (kbd "M-<backspace>") 'backward-kill-word)

(defvar clojure--prettify-symbols-alist nil)
(setq clojure-toplevel-inside-comment-form t) ;; comment form

(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
(add-hook 'emacs-lisp-mode-hook #'evil-cleverparens-mode)
(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

(setenv "PATH" (concat (getenv "HOME") "/bin:" (getenv "PATH")))
(setq exec-path (cons "~/bin" exec-path))

;; Super Tab
(require 'smart-tab)
(global-smart-tab-mode 1)

;; Relative line numbers
;; (require 'linum-relative)
;; (set-face-foreground 'linum-relative-current-face nil)
;; (set-face-background 'linum-relative-current-face nil)

;; APPEARANCE

;; Set color-theme
(require 'color-theme-tomorrow)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; (color-theme-tomorrow-night)
     (color-theme-sanityinc-tomorrow-night)
     ;; (color-theme-sanityinc-tomorrow-bright)
     ;; (color-theme-sanityinc-tomorrow-day)
     ;; (color-theme-sanityinc-tomorrow-blue)
     ;; (color-theme-sanityinc-tomorrow-eighties)
     ))

(setq color-theme-is-global t)

(defun toggle-night-color-theme ()
  "Switch to/from night color scheme."
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
      (color-theme-snapshot) ; restore default (light) colors
    ;; create the snapshot if necessary
    (when (not (commandp 'color-theme-snapshot))
      (fset 'color-theme-snapshot (color-theme-make-snapshot)))
    (color-theme-solarized-dark)))
(global-set-key (kbd "<f9> n") 'toggle-night-color-theme)
(evil-define-key 'normal 'global (kbd "SPC at") 'toggle-night-color-theme)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; Set parentheses color
;; (defface esk-paren-face
   ;; '((((class color) (background dark))
      ;; (:foreground "grey40"))
     ;; (((class color) (background light))
      ;; (:foreground "grey55")))
   ;; "Face used to dim parentheses."
   ;; :group 'starter-kit-faces)

;; (font-lock-add-keywords 'clojure-mode '(("(\\|)" . 'esk-paren-face)))

;; WHITESPACES
;; (require 'whitespace)
;; (add-hook 'after-save-hook 'whitespace-cleanup)

;; INDENT
(defun prev-line-new ()
  (interactive)
  (previous-line)
  (textmate-next-line))

;; open this config file
(define-key global-map [f12] (lambda () (interactive) (find-file user-init-file)))

;; toggle line wrap
(define-key global-map (kbd "<f9> l") 'visual-line-mode)
(evil-define-key 'normal 'global (kbd "SPC al") 'visual-line-mode)

(define-key global-map [f8]
  (lambda ()  (interactive)
    (monroe "localhost:9995")
    (visual-line-mode)))
(define-key global-map [f5]
  (lambda ()  (interactive)
    (monroe "localhost:7888")
    (visual-line-mode)))
(define-key global-map [f7]
  (lambda ()  (interactive)
    (visual-line-mode)
    (insert "(shadow.cljs.devtools.api/repl :app)")))
(define-key global-map [f6]
  (lambda ()  (interactive)
    (monroe "localhost:7889")
    (visual-line-mode)))
;; (define-key global-map (kbd "<f8> k")
;;   (lambda () (interactive)
;;     (ignore-errors (kill-process "monroe"))))

(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map [(super return)] 'textmate-next-line)
(define-key global-map [(super shift return)] 'prev-line-new)

;; window navigation
;; use Apple+arrow_keys to move cursor around split panes
;(windmove-default-keybindings 'super)
(global-set-key (kbd "<s-left>")  'windmove-left)
(global-set-key (kbd "<s-right>") 'windmove-right)
(global-set-key (kbd "<s-up>")    'windmove-up)
(global-set-key (kbd "<s-down>")  'windmove-down)

(setq mac-pass-command-to-system nil)
(global-set-key (kbd "s-l") 'windmove-right)
(global-set-key (kbd "s-h") 'windmove-left)
(global-set-key (kbd "s-j") 'windmove-down)
(global-set-key (kbd "s-k") 'windmove-up)

;; comment region
(global-set-key (kbd "C-c ;") 'comment-region)
(global-set-key (kbd "C-c :") 'uncomment-region)

; Switch to prev buffer
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

;; add clipboard to kill ring
;; http://stackoverflow.com/questions/848936/how-to-preserve-clipboard-content-in-emacs-on-windows
(defadvice kill-new (before kill-new-push-xselection-on-kill-ring activate)
  "Before putting new kill onto the kill-ring, add the clipboard/external selection to the kill ring"
  (let ((have-paste (and interprogram-paste-function
                         (funcall interprogram-paste-function))))
    (when have-paste (push have-paste kill-ring))))

;; indents

(setq js-indent-level 2)
(setq js2-basic-offset 4)
(setq typescript-indent-level 2)
(setq css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(put 'upcase-region 'disabled nil)

(require 'simplenote2)

(setq simplenote2-email
      (string-trim
       (shell-command-to-string "security find-generic-password -s simplenote-email -w")))
(setq simplenote2-password
      (string-trim
       (shell-command-to-string "security find-generic-password -s simplenote-password -w")))
(simplenote2-setup)
(evil-define-key 'normal 'global (kbd "SPC sb") 'simplenote2-browse)
(evil-define-key 'normal 'global (kbd "SPC sl") 'simplenote2-list)
(evil-define-key 'normal 'global (kbd "SPC sn") 'simplenote2-create-note-from-buffer)
(evil-define-key 'normal 'global (kbd "SPC ss") 'simplenote2-sync-notes)

;; TODO: add to nrepl-interaction-mode-map
;; (define-key global-map (kbd "<f2> b") 'simplenote2-browse)
;; (define-key global-map (kbd "<f2> l") 'simplenote2-list)
;; (define-key global-map (kbd "<f2> n") 'simplenote2-create-note-from-buffer)
;; (define-key global-map (kbd "<f2> s") 'simplenote2-sync-notes)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)))

(put 'downcase-region 'disabled nil)

;; typescript

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; (with-eval-after-load 'evil-maps (define-key evil-insert-state-map (kbd "f1") 'evil-normal-state)) 
(define-key evil-insert-state-map (kbd "<f1>") 'evil-normal-state) 

(setq tramp-default-method "ssh")
