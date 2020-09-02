;;; monroe-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "monroe" "monroe.el" (0 0 0 0))
;;; Generated autoloads from monroe.el

(autoload 'monroe-interaction-mode "monroe" "\
Minor mode for Monroe interaction from a Clojure buffer.

The following keys are available in `monroe-interaction-mode`:

  \\{monroe-interaction-mode}

\(fn &optional ARG)" t nil)

(autoload 'monroe "monroe" "\
Load monroe by setting up appropriate mode, asking user for
connection endpoint.

\(fn HOST-AND-PORT)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "monroe" '("clojure-enable-monroe" "monroe-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; monroe-autoloads.el ends here
