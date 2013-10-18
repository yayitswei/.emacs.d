(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))

(global-auto-revert-mode 1)

;; Fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Package.el customization
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/checkouts/custom")

;; PLUGINS

;; Line numbers
;; (global-linum-mode t)

;; Vim-mode (Evil-mode)
(require 'evil)
;; (require 'evil-paredit)
(evil-mode 1)
(setq evil-default-cursor t)
;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key (kbd "C-u") 'scroll-down-command)

;; Textmate mode
(require 'textmate)
(textmate-mode)

;; Highlight-parentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

;; Classic Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("orange" "yellow" "greenyellow" "green" "springgreen" "cyan" "slateblue" "magenta" "purple"))))
;; Eighties Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("#f2777a" "#f99157" "#ffcc66" "#99cc99" "#009999" "#99cccc" "#cc99cc"))))
;; Night Rainbow
;; (custom-set-variables '(hl-paren-colors (quote ("#cc6666" "#de935f" "#f0c674" "#b5bd68" "#8abeb7" "#81a2be" "#b294bb"))))
;; Bright Rainbow
(custom-set-variables
 '(hl-paren-colors
   (quote
    ("#d54e53" "#e78c45" "#e7c547" "#b9ca4a" "#70c0b1" "#7aa6da" "#c397d8"))))

(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

;; Nrepl
(setenv "PATH" (concat (getenv "HOME") "/bin:" (getenv "PATH")))
(setq exec-path (cons "~/bin" exec-path))
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")

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
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; (color-theme-sanityinc-tomorrow-night)
     ;; (color-theme-sanityinc-tomorrow-bright)
     ;; (color-theme-sanityinc-tomorrow-blue)
     ;; (color-theme-sanityinc-tomorrow-eighties)
     ))

(setq color-theme-is-global t)
(add-to-list 'load-path "~/.emacs.d/checkouts/emacs-color-theme-solarized")
(require 'color-theme-solarized)
(setq solarized-termcolors 256)
(color-theme-solarized-dark)

(set-face-attribute 'default nil :height 120)
(set-cursor-color 'white)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; Set parentheses color
(defface esk-paren-face
   '((((class color) (background dark))
      (:foreground "grey40"))
     (((class color) (background light))
      (:foreground "grey55")))
   "Face used to dim parentheses."
   :group 'starter-kit-faces)

(font-lock-add-keywords 'clojure-mode
                        '(("(\\|)" . 'esk-paren-face)))

;; WHITESPACES
(require 'whitespace)
(add-hook 'after-save-hook 'whitespace-cleanup)
;;(setq whitespace-line-column 90)
;; highlight trainling spaces, empty lines and etc
;;(setq whitespace-style '(face empty tabs lines-tail trailing))
;;(global-whitespace-mode t)

;; UNDO TREE
(require 'undo-tree)
(global-undo-tree-mode)
(define-key global-map [(super shift z)] 'undo-tree-redo)

;; INDENT
(defun prev-line-new ()
  (interactive)
  (previous-line)
  (textmate-next-line))

(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map [(super return)] 'textmate-next-line)
(define-key global-map [(super shift return)] 'prev-line-new)

;; window navigation
;; use Apple+arrow_keys to move cursor around split panes
;(windmove-default-keybindings 'super)
(global-set-key (kbd "<C-S-s-left>")  'windmove-left)
(global-set-key (kbd "<C-S-s-right>") 'windmove-right)
(global-set-key (kbd "<C-S-s-up>")    'windmove-up)
(global-set-key (kbd "<C-S-s-down>")  'windmove-down)

;; Navigation
(global-set-key (kbd "<s-left>") 'move-beginning-of-line)
(global-set-key (kbd "<s-right>") 'move-end-of-line)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)

;; SMARTPARENS (paredit replacement)
(require 'smartparens-custom-config)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'nrepl-mode-hook 'smartparens-strict-mode)

;; Clojure nrepl customization
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(add-to-list 'same-window-buffer-names "*nrepl*")

; TODO: add to nrepl-interaction-mode-map
(define-key global-map [f5] 'nrepl-load-current-buffer)
(define-key global-map [f6] 'nrepl)
(define-key global-map [f7] 'nrepl-set-ns)

; Switch to prev buffer
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)
