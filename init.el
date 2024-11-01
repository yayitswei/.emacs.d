
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
  (global-set-key (kbd "s-f") 'find-file)
  (global-set-key (kbd "s-p") 'previous-buffer)
  (global-set-key (kbd "s-n") 'next-buffer)
  (global-set-key (kbd "s-s") 'save-buffer)
  (global-set-key (kbd "C-s") 'save-buffer)
  (global-set-key (kbd "C-s-f") 'spacemacs/toggle-frame-fullscreen))

;; comment form
(setq clojure-toplevel-inside-comment-form t)

;(set-default-font "Monaco 28" nil t)
(set-face-attribute 'default nil :font "Monaco 14" :height 140)

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
   '(evil gptel rust-mode clojure-mode monroe scala-mode solidity-mode evil-cleverparens fennel-mode lua-mode php-mode go-mode docker-tramp helm-ls-git helm-git-grep helm-ag helm yaml-mode with-editor web-mode tide textmate smartparens smart-tab slamhound simplenote2 s robe rainbow-delimiters queue paredit markdown-mode magit list-processes+ linum-relative jump jsx-mode jade-mode html-to-markdown highlight-parentheses haml-mode evil-nerd-commenter evil-leader csv-mode color-theme-sanityinc-tomorrow color-theme clojurescript-mode clojure-mode-extra-font-locking cljsbuild-mode base16-theme ack))
 '(safe-local-variable-values
   '((cider-ns-refresh-after-fn . "development/go")
     (cider-ns-refresh-before-fn . "development/stop")
     (eval put-clojure-indent :require 0)
     (clojure-indent-style . always-indent)
     (cider-refresh-after-fn . "integrant.repl/resume")
     (cider-refresh-before-fn . "integrant.repl/suspend")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

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
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/"))

; too slow
;(when (not package-archive-contents)
;  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/custom/tomorrow-theme")
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
(require 'color-theme)
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

(define-key global-map [f7]
  (lambda ()  (interactive)
    (monroe "localhost:9995")
    (visual-line-mode)))
(define-key global-map [f5]
  (lambda ()  (interactive)
    (monroe "localhost:7888")
    (visual-line-mode)))

(define-key global-map [f6]
  (lambda ()  (interactive)
    (visual-line-mode)
    (insert "(shadow.cljs.devtools.api/repl :dev)")))

;(define-key global-map [f6]
;  (lambda ()  (interactive)
;    (monroe "localhost:9000")
;    (visual-line-mode)
;    (insert "(shadow/repl :main)")))

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

(setq mac-pass-command-to-system nil)
(global-set-key (kbd "s-l") 'windmove-right)
(global-set-key (kbd "s-h") 'windmove-left)
(global-set-key (kbd "s-j") 'windmove-down)
(global-set-key (kbd "s-k") 'windmove-up)

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

;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(default ((t (:inherit nil :stipple nil :background "#1d1f21" :foreground "#c5c8c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco")))))

;; indents

(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(put 'upcase-region 'disabled nil)

;; (require 'simplenote2)
;; (setq simplenote2-email "yayitswei@gmail.com")
;; (setq simplenote2-password nil)
;; (simplenote2-setup)

;; (add-hook 'python-mode-hook
      ;; (lambda ()
        ;; (setq indent-tabs-mode t)
        ;; (setq tab-width 4)
        ;; (setq python-indent 4)))

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

(setq tramp-default-method "ssh")


;; fennel
;(autoload 'fennel-mode "/Users/wei/.emacs.d/elpa/fennel-mode-20190927.4" nil t)
(autoload 'fennel-mode "/Users/wei/.emacs.d/checkouts/fennel-mode/fennel-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.fnl\\'" . fennel-mode))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
