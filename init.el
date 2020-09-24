(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(clojure-defun-indents (quote (always-ident)))
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("cda6cb17953b3780294fa6688b3fe0d3d12c1ef019456333e3d5af01d4d6c054" "6ebb2401451dc6d01cd761eef8fe24812a57793c5ccc427b600893fa1d767b1d" "6b2c6e5bc1e89cf7d927d17f436626eac98a04fdab89e080f4e193f6d291c93d" "4cdea318a3efab7ff7c832daea05f6b2d5d0a18b9bfa79763b674e860ecbc6da" "00f09a2728377a37e9a24d631de94cc7440e0803e218474cac287061951c205c" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-selected-packages
   (quote
    (clojure-mode lua-mode php-mode go-mode docker-tramp helm-ls-git helm-git-grep helm-ag helm yaml-mode with-editor web-mode tide textmate smartparens smart-tab slamhound simplenote2 s robe rainbow-delimiters queue paredit markdown-mode magit list-processes+ linum-relative jump jsx-mode jade-mode html-to-markdown highlight-parentheses haml-mode evil-nerd-commenter evil-leader csv-mode ack)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(when (equal system-type 'darwin)
  ;; Treat option as meta and command as super
  (setq mac-option-key-is-meta t)
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)

  ;; Keybindings
  (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-c") 'kill-ring-save)
  (global-set-key (kbd "s-x") 'kill-region)
  (global-set-key (kbd "s-w") 'kill-this-buffer)
  (global-set-key (kbd "s-k") 'kill-this-buffer)
  (global-set-key (kbd "s-z") 'undo-tree-undo)
  (global-set-key (kbd "s-s") 'save-buffer)
  (global-set-key (kbd "s-Z") 'undo-tree-redo)
  (global-set-key (kbd "C-s-f") 'spacemacs/toggle-frame-fullscreen))

;; backup files in separate directory
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

(setq default-directory "/Users/wei/code")

(desktop-save-mode 0)

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
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

; too slow
;(when (not package-archive-contents)
;  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/checkouts/custom")

;; Visual bell
;; http://emacsblog.org/2007/02/06/quick-tip-visible-bell/
(require 'rwd-bell)
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)


;; PLUGINS

;; Line numbers
;; (global-linum-mode t)

;; Vim-mode (Evil-mode)
(require 'evil)
(require 'goto-last-change)
;(require 'evil-paredit)
(evil-mode 1)
(setq evil-default-cursor t)
;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key (kbd "C-u") 'scroll-down-command)

;; evil nerd commenter
(evilnc-default-hotkeys)

(defvar clojure--prettify-symbols-alist nil)

(unless (package-installed-p 'clojure-mode)
  (package-refresh-contents)
  (package-install 'clojure-mode))

(require 'monroe)
(add-hook 'clojure-mode-hook 'clojure-enable-monroe)

(setenv "PATH" (concat (getenv "HOME") "/bin:" (getenv "PATH")))
(setq exec-path (cons "~/bin" exec-path))

;; Super Tab
(require 'smart-tab)
(global-smart-tab-mode 1)

;; APPEARANCE

;; Set color-theme
;; (require 'color-theme)

;; (set-face-attribute 'default nil :height 120)
;; (set-cursor-color 'white)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; (font-lock-add-keywords 'clojure-mode '(("(\\|)" . 'esk-paren-face)))

;; WHITESPACES
;; (require 'whitespace)
;; (add-hook 'after-save-hook 'whitespace-cleanup)

;; UNDO TREE
(require 'undo-tree)
(global-undo-tree-mode)
(define-key global-map [(super shift z)] 'undo-tree-redo)

;; INDENT
(defun prev-line-new ()
  (interactive)
  (previous-line)
  (textmate-next-line))

;; SMARTPARENS (paredit replacement)
(require 'smartparens-custom-config)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)

; SQLi

(setq sql-connection-alist
      '((pool-a
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "wei")
         (sql-database "sf_dev"))
        (pool-b
         (sql-product 'postgres)
         (sql-server "r"))))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
           (flet ((sql-get-login (&rest what)))
             (sql-product-interactive sql-product)))))

(defun connect-pool-a ()
  (interactive)
  (sql-connect-preset 'pool-a))

(defun connect-pool-b ()
  (interactive)
  (sql-connect-preset 'pool-b))

; TODO: add to nrepl-interaction-mode-map
;; (define-key global-map (kbd "<f2> b") 'simplenote2-browse)
;; (define-key global-map (kbd "<f2> n") 'simplenote2-create-note-from-buffer)
;; (define-key global-map (kbd "<f2> s") 'simplenote2-sync-notes)

(define-key global-map [f3] 'connect-pool-a)

;; open this config file
(define-key global-map [f12] (lambda () (interactive) (find-file user-init-file)))

;; toggle line wrap
(define-key global-map (kbd "<f9> l") 'visual-line-mode)

(define-key global-map [f5]
  (lambda ()  (interactive) (monroe "localhost:7888")))
(define-key global-map [f6]
  (lambda ()  (interactive) (monroe "localhost:7889")))
(define-key global-map [f7]
  (lambda ()  (interactive) (monroe "localhost:9000")))

(define-key global-map (kbd "<f8> k")
  (lambda () (interactive)
    (ignore-errors (kill-process "monroe"))))

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

;; comment region
(global-set-key (kbd "C-c ;") 'comment-region)

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
(setq css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(put 'upcase-region 'disabled nil)

;; (require 'simplenote2)
;; (setq simplenote2-email "yayitswei@gmail.com")
;; (setq simplenote2-password nil)
;; (simplenote2-setup)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)))

(put 'downcase-region 'disabled nil)

;; use tabs in php mode
(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  (setq indent-tabs-mode t)
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (setq c-basic-indent my-tab-width)
    (set (make-local-variable 'tab-stop-list)
         (number-sequence my-tab-width 200 my-tab-width))))

;; (with-eval-after-load 'evil-maps (define-key evil-insert-state-map (kbd "f1") 'evil-normal-state)) 
(define-key evil-insert-state-map (kbd "<f1>") 'evil-normal-state) 

;; (setq tramp-default-method "ssh")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'sanityinc-tomorrow-day t)
