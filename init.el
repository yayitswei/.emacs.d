;; TODO: use rail https://github.com/Sasanidas/Rail
;; TODO: use visual-wrap-prefix-mode

(setq byte-compile-warnings '(not cl-functions obsolete))
(setq warning-suppress-types '((comp cl-functions) 
                             (comp obsolete)
                             (defvaralias)))

;(setq desktop-path '("~/code/emacs/desktop")) 
;(desktop-save-mode 1)

(require 'cl-lib)

(add-to-list 'load-path "~/.emacs.d/custom")

(setq ring-bell-function 'ignore)

;; Initialize package.el first
;(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
;(package-initialize)

;; Set up use-package (built-in in Emacs 29+)
(require 'use-package)
(setq use-package-always-ensure t)

;; Enable package-vc support (built-in in Emacs 30+)
(when (>= emacs-major-version 30)
  (require 'package-vc))

(use-package clojure-mode
  :vc (:url "https://github.com/clojure-emacs/clojure-mode.git")
  :demand t)

(use-package helm
  :ensure t)

(setq helm-split-window-in-side-p t)
(setq helm-split-window-preferred-function 'split-window-below)

(use-package helm-ls-git
  :vc (:url "https://github.com/emacs-helm/helm-ls-git.git")
  :after helm
  :demand t)

(use-package helm-git-grep
  :vc (:url "https://github.com/yasuyk/helm-git-grep.git")
  :after helm
  :demand t)

(use-package monroe
  :vc (:url "https://github.com/sanel/monroe.git" :rev "508f5ed0f88b0b5e01a37d456186ea437f44d93c")
  ;; reason for using a previous version is that the newer monroe tries to be multi-repl, and breaks some functionality
  :demand t)

;; monroe is loaded via use-package
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

(use-package simplenote2
  :vc (:url "https://github.com/alpha22jp/simplenote2.el.git")
  :demand t
  :config
  (setq simplenote2-email
        (string-trim
         (shell-command-to-string "security find-generic-password -s simplenote-email -w")))
  (setq simplenote2-password
        (string-trim
         (shell-command-to-string "security find-generic-password -s simplenote-password -w")))
  (simplenote2-setup)
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "<leader>sb") 'simplenote2-browse)
    (evil-define-key 'normal 'global (kbd "<leader>sl") 'simplenote2-list)
    (evil-define-key 'normal 'global (kbd "<leader>sn") 'simplenote2-create-note-from-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>ss") 'simplenote2-sync-notes)))

(use-package evil
  :vc (:url "https://github.com/emacs-evil/evil.git")
  :demand t
  :init
  (setq evil-want-keybinding nil)
  :config
  ;; use default undo
  (evil-set-undo-system 'undo-redo)
  (evil-mode 1)
  (setq evil-default-cursor t)

  ;; Set up key bindings after evil is fully loaded
  (with-eval-after-load 'evil
    ;; leader key setup
    (evil-set-leader 'normal (kbd "SPC"))
    (evil-set-leader 'visual (kbd "SPC"))

    ;; esc quits
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

    ;; elisp eval - use leader key
    (evil-define-key 'normal 'global (kbd "<leader>er") 'eval-region)
    (evil-define-key 'visual 'global (kbd "<leader>er") 'eval-region)
    (evil-define-key 'normal 'global (kbd "<leader>eb") 'eval-buffer)))

(use-package evil-cleverparens
  :vc (:url "https://github.com/emacs-evil/evil-cleverparens.git")
  :after evil
  :demand t)

(use-package markdown-mode
  :ensure t)

(use-package evil-collection
  :vc (:url "https://github.com/emacs-evil/evil-collection.git")
  :after evil
  :demand t
  :config
  (evil-collection-init))

(use-package color-theme-sanityinc-tomorrow
  :vc (:url "https://github.com/purcell/color-theme-sanityinc-tomorrow.git")
  :demand t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

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

(set-face-attribute 'default nil :font "Monaco 10" :height 140)

;; Set default font and size (adjust the height value for size)
;; Height 160 = 16pt, 140 = 14pt, 120 = 12pt, 180 = 18pt, etc.
(set-face-attribute 'default nil :height 140)

;; (define-key key-translation-map (kbd "f1") (kbd "ESC"))

;; backup files in separate directory
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

;; TODO: move to local.el
;; (setq default-directory "/home/wei/code")

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

;; Package archives already configured at the top of file

; too slow
;(when (not package-archive-contents)
;  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/custom")







;; PLUGINS

;; Line numbers
;; (global-linum-mode t)

;; Evil configuration is now in use-package declarations above
(electric-pair-mode 1)
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
;(require 'smart-tab)
;(global-smart-tab-mode 1)

;; APPEARANCE

;; Remove UI elements for cleaner look
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Color theme is now loaded via use-package declaration above
;; Old color-theme configuration removed in favor of use-package

(setq color-theme-is-global t)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; INDENT
(defun prev-line-new ()
  (interactive)
  (previous-line)
  (textmate-next-line))

;; open this config file
(define-key global-map [f12] (lambda () (interactive) (find-file user-init-file)))

;; toggle line wrap
(define-key global-map (kbd "<f9> l") 'visual-line-mode)
(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>al") 'visual-line-mode))

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
(setq css-indent-offset 2)
(put 'upcase-region 'disabled nil)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)))

(put 'downcase-region 'disabled nil)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "<f1>") 'evil-normal-state)) 

(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((color-theme-sanityinc-tomorrow :url
                                     "https://github.com/purcell/color-theme-sanityinc-tomorrow.git")
     (evil-collection :url
                      "https://github.com/emacs-evil/evil-collection.git")
     (evil-cleverparens :url
                        "https://github.com/emacs-evil/evil-cleverparens.git")
     (evil :url "https://github.com/emacs-evil/evil.git")
     (simplenote2 :url
                  "https://github.com/alpha22jp/simplenote2.el.git")
     (monroe :url "https://github.com/sanel/monroe.git")
     (helm-ls-git :url "https://github.com/emacs-helm/helm-ls-git.git")
     (clojure-mode :url
                   "https://github.com/clojure-emacs/clojure-mode.git"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
