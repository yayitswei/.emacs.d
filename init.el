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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#000000"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#424242")
 '(helm-cmd-t-cache-threshhold nil)
 '(hl-paren-colors
   (quote
    ("#d54e53" "#e78c45" "#e7c547" "#b9ca4a" "#70c0b1" "#7aa6da" "#c397d8")))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil))

(setq default-directory "/Users/wei/code")

(desktop-save-mode 1)

(global-auto-revert-mode 1)

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

(require 'bs)
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Package.el customization
(package-initialize)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

; too slow
;(when (not package-archive-contents)
;  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/custom/tomorrow-theme")
(add-to-list 'load-path "~/.emacs.d/checkouts/custom")

;; Visual bell
;; http://emacsblog.org/2007/02/06/quick-tip-visible-bell/
(require 'rwd-bell)
(setq visible-bell t)

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

;; Textmate mode
;; too slow, too many features I don't need
;(require 'textmate)
;(textmate-mode)

;; faster command-t search
(add-to-list 'load-path "~/.emacs.d/elpa/helm-20140223.1212")
(require 'helm-config)
(add-to-list 'load-path "~/.emacs.d/checkouts/helm-cmd-t")
(require 'helm-cmd-t)
(global-set-key (kbd "s-t") 'helm-cmd-t)
(require 'helm-C-x-b)
(global-set-key [remap switch-to-buffer] 'helm-C-x-b)
(global-set-key (kbd "s-b") 'helm-C-x-b)
(global-set-key (kbd "s-F") 'helm-cmd-t-grep)


;; Highlight-parentheses
;; (require 'highlight-parentheses)
;; (define-globalized-minor-mode global-highlight-parentheses-mode
  ;; highlight-parentheses-mode
  ;; (lambda ()
    ;; (highlight-parentheses-mode t)))

;; Classic Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("orange" "yellow" "greenyellow" "green" "springgreen" "cyan" "slateblue" "magenta" "purple"))))
;; Eighties Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("#f2777a" "#f99157" "#ffcc66" "#99cc99" "#009999" "#99cccc" "#cc99cc"))))
;; Night Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("#cc6666" "#de935f" "#f0c674" "#b5bd68" "#8abeb7" "#81a2be" "#b294bb"))))
;; Bright Rainbow


;; (add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

;; cider (was nrepl)

(defvar clojure--prettify-symbols-alist nil)

(unless (package-installed-p 'clojure-mode)
  (package-refresh-contents)
  (package-install 'clojure-mode))

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
;; (add-to-list 'load-path "~/.emacs.d/checkouts/emacs-color-theme-solarized")
;; (require 'color-theme-solarized)
;; (setq solarized-termcolors 256)
;(color-theme-solarized-dark)
;; (color-theme-solarized-light)

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


;; (set-face-attribute 'default nil :height 120)
;; (set-cursor-color 'white)

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

;; Monroe (clojure repl)
;; (add-to-list 'load-path "~/.emacs.d/checkouts/monroe")
(require 'monroe)
(add-hook 'clojure-mode-hook 'clojure-enable-monroe)

(add-hook 'monroe-mode-hook 'smartparens-strict-mode)

(defun monroe-7888 ()
  (interactive)
  (setq monroe-default-host "localhost:7888")
  (monroe "localhost:7888"))

(defun monroe-7889 ()
  (interactive)
  (setq monroe-default-host "localhost:7889")
  (monroe "localhost:7889"))

(defun air-7889 ()
  (interactive)
  (setq monroe-default-host "h:7889")
  (monroe "h:7889"))

(defun monroe-debug-stacktrace ()
  (interactive)
  (monroe-input-sender
   (get-buffer-process monroe-repl-buffer)
   "(clojure.stacktrace/print-stack-trace *e)"))

(defun monroe-run-tests ()
  (interactive)
  (monroe-input-sender
   (get-buffer-process monroe-repl-buffer)
   "(run-tests)"))

(defun figwheel-cljs-repl ()
  (interactive)
  (monroe-input-sender
   (get-buffer-process monroe-repl-buffer)
   "(do (use 'figwheel-sidecar.repl-api) (cljs-repl))"))

; SQLi

(setq sql-connection-alist
      '((pool-a
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "wei")
         (sql-database "crt"))
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
;; (define-key global-map [f2] 'simplenote2-browse)
(define-key global-map (kbd "<f2> b") 'simplenote2-browse)
(define-key global-map (kbd "<f2> n") 'simplenote2-create-note-from-buffer)
(define-key global-map (kbd "<f2> s") 'simplenote2-sync-notes)
(define-key global-map [f3] 'connect-pool-a)
(define-key global-map [f4] 'monroe)
;(define-key global-map [f5] 'monroe-7888)
;(define-key global-map [f6] 'monroe-7889)
(define-key global-map [f5] 'monroe-7888)
(define-key global-map [f6] 'monroe-7889)
(define-key global-map [f7] 'figwheel-cljs-repl)
(define-key global-map [f8] 'monroe-debug-stacktrace)
(define-key global-map [f12] (lambda () (interactive) (find-file user-init-file)))

(global-set-key (kbd "C-c C-t") 'monroe-run-tests)

;(define-key global-map [f3] 'cider-repl-set-ns)
;(define-key global-map [f4] 'cider-connect)
;(define-key global-map [f5] 'cider-load-current-buffer)
;(define-key global-map [f6] 'find-tag)
;(define-key global-map [f7] 'cider-set-ns)
;(define-key global-map [f8] 'slamhound)
(define-key global-map (kbd "<f9> l") 'visual-line-mode)

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

(setq monroe-default-host "localhost:7888")
(setq monroe-detail-stacktraces t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; indents

(setq js-indent-level 2)
(setq css-indent-offset 2)
(put 'upcase-region 'disabled nil)

(require 'simplenote2)
(setq simplenote2-email "yayitswei@gmail.com")
(setq simplenote2-password nil)
(simplenote2-setup)

(require 'web-mode)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(require 'jsx-mode)
(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . jsx-mode))

;; (require 'jsx-mode)
;; (defun my-jsx-mode-hook ()
  ;; "Hooks for jsx mode."
  ;; (setq jsx-mode-markup-indent-offset 2)
  ;; (setq jsx-mode-css-indent-offset 2)
  ;; (setq jsx-mode-code-indent-offset 2))
;; (add-hook 'jsx-mode-hook  'my-jsx-mode-hook)


;; (setq web-mode-content-types-alist
  ;; '(("jsx" . "\\.js[x]?\\'")))
