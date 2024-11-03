
:tanat

"29.4"

#s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data ("straight" ("2024-11-02 18:23:21" ("emacs") (:type git :host github :repo "radian-software/straight.el" :files ("straight*.el") :branch "master" :package "straight" :local-repo "straight.el")) "org-elpa" ("2024-11-02 18:23:20" nil (:local-repo nil :package "org-elpa" :type git)) "melpa" ("2024-11-02 18:23:21" nil (:type git :host github :repo "melpa/melpa" :build nil :package "melpa" :local-repo "melpa")) "gnu-elpa-mirror" ("2024-11-02 18:23:21" nil (:type git :host github :repo "emacs-straight/gnu-elpa-mirror" :build nil :package "gnu-elpa-mirror" :local-repo "gnu-elpa-mirror")) "nongnu-elpa" ("2024-11-02 18:23:21" nil (:type git :repo "https://git.savannah.gnu.org/git/emacs/nongnu.git" :depth (full single-branch) :local-repo "nongnu-elpa" :build nil :package "nongnu-elpa")) "el-get" ("2024-11-02 18:23:21" nil (:type git :host github :repo "dimitri/el-get" :build nil :files (:defaults "methods" ("recipes" "recipes/el-get.rcp") "el-get-pkg.el") :flavor melpa :package "el-get" :local-repo "el-get")) "emacsmirror-mirror" ("2024-11-02 18:23:21" nil (:type git :host github :repo "emacs-straight/emacsmirror-mirror" :build nil :package "emacsmirror-mirror" :local-repo "emacsmirror-mirror")) "helm" ("2024-11-02 18:23:21" ("helm-core" "wfnames") (:type git :flavor melpa :files (:defaults "emacs-helm.sh" (:exclude "helm-lib.el" "helm-source.el" "helm-multi-match.el" "helm-core.el") "helm-pkg.el") :host github :repo "emacs-helm/helm" :package "helm" :local-repo "helm")) "helm-core" ("2024-11-02 18:23:21" ("emacs" "async") (:flavor melpa :files ("helm-core.el" "helm-lib.el" "helm-source.el" "helm-multi-match.el" "helm-core-pkg.el") :package "helm-core" :local-repo "helm" :type git :repo "emacs-helm/helm" :host github)) "async" ("2024-11-02 18:23:21" ("emacs") (:type git :flavor melpa :host github :repo "jwiegley/emacs-async" :package "async" :local-repo "emacs-async")) "wfnames" ("2024-11-02 18:23:21" ("emacs") (:type git :flavor melpa :host github :repo "thierryvolpiatto/wfnames" :package "wfnames" :local-repo "wfnames")) "helm-ls-git" ("2024-11-02 18:23:21" ("helm" "emacs") (:type git :host github :repo "emacs-helm/helm-ls-git" :flavor melpa :package "helm-ls-git" :local-repo "helm-ls-git")) "gptel" ("2024-11-02 18:23:21" ("emacs" "transient" "compat") (:type git :flavor melpa :host github :repo "karthink/gptel" :package "gptel" :local-repo "gptel")) "transient" ("2024-11-02 18:23:21" ("emacs" "compat" "seq") (:type git :flavor melpa :host github :repo "magit/transient" :package "transient" :local-repo "transient")) "compat" ("2024-11-02 18:23:21" ("emacs" "seq") (:type git :host github :repo "emacs-straight/compat" :files ("*" (:exclude ".git")) :package "compat" :local-repo "compat")) "seq" ("2024-11-02 18:23:21" nil (:type git :host github :repo "emacs-straight/seq" :files ("*" (:exclude ".git")) :package "seq" :local-repo "seq")) "monroe" ("2024-11-02 18:23:22" nil (:type git :host github :repo "sanel/monroe" :commit "508f5ed0f88b0b5e01a37d456186ea437f44d93c" :flavor melpa :package "monroe" :local-repo "monroe")) "clojure-mode" ("2024-11-02 18:23:21" ("emacs") (:type git :host github :repo "clojure-emacs/clojure-mode" :files ("clojure-mode.el" "clojure-mode-pkg.el") :flavor melpa :package "clojure-mode" :local-repo "clojure-mode")) "rail" ("2024-10-31 19:45:49" nil (:type git :host github :repo "Sasanidas/Rail" :package "rail" :local-repo "Rail"))))

#s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data ("straight" ((straight-x straight-autoloads straight straight-ert-print-hack) (autoload 'straight-remove-unused-repos "straight" "Remove unused repositories from the repos and build directories.
A repo is considered \"unused\" if it was not explicitly requested via
`straight-use-package' during the current Emacs session.
If FORCE is non-nil do not prompt before deleting repos.

(fn &optional FORCE)" t) (autoload 'straight-get-recipe "straight" "Interactively select a recipe from one of the recipe repositories.
All recipe repositories in `straight-recipe-repositories' will
first be cloned. After the recipe is selected, it will be copied
to the kill ring. With a prefix argument, first prompt for a
recipe repository to search. Only that repository will be
cloned.

From Lisp code, SOURCES should be a subset of the symbols in
`straight-recipe-repositories'. Only those recipe repositories
are cloned and searched. If it is nil or omitted, then the value
of `straight-recipe-repositories' is used. If SOURCES is the
symbol `interactive', then the user is prompted to select a
recipe repository, and a list containing that recipe repository
is used for the value of SOURCES. ACTION may be `copy' (copy
recipe to the kill ring), `insert' (insert at point), or nil (no
action, just return it).

Optional arg FILTER must be a unary function.
It takes a package name as its sole argument.
If it returns nil the candidate is excluded.

(fn &optional SOURCES ACTION FILTER)" t) (autoload 'straight-visit-package-website "straight" "Visit the package RECIPE's website.

(fn RECIPE)" t) (autoload 'straight-visit-package "straight" "Open PACKAGE's local repository directory.
When BUILD is non-nil visit PACKAGE's build directory.

(fn PACKAGE &optional BUILD)" t) (autoload 'straight-use-package "straight" "Register, clone, build, and activate a package and its dependencies.
This is the main entry point to the functionality of straight.el.

MELPA-STYLE-RECIPE is either a symbol naming a package, or a list
whose car is a symbol naming a package and whose cdr is a
property list containing e.g. `:type', `:local-repo', `:files',
and VC backend specific keywords.

First, the package recipe is registered with straight.el. If
NO-CLONE is a function, then it is called with two arguments: the
package name as a string, and a boolean value indicating whether
the local repository for the package is available. In that case,
the return value of the function is used as the value of NO-CLONE
instead. In any case, if NO-CLONE is non-nil, then processing
stops here.

Otherwise, the repository is cloned, if it is missing. If
NO-BUILD is a function, then it is called with one argument: the
package name as a string. In that case, the return value of the
function is used as the value of NO-BUILD instead. In any case,
if NO-BUILD is non-nil, then processing halts here. Otherwise,
the package is built and activated. Note that if the package
recipe has a nil `:build' entry, then NO-BUILD is ignored
and processing always stops before building and activation
occurs.

CAUSE is a string explaining the reason why
`straight-use-package' has been called. It is for internal use
only, and is used to construct progress messages. INTERACTIVE is
non-nil if the function has been called interactively. It is for
internal use only, and is used to determine whether to show a
hint about how to install the package permanently.

Return non-nil when package is initially installed, nil otherwise.

(fn MELPA-STYLE-RECIPE &optional NO-CLONE NO-BUILD CAUSE INTERACTIVE)" t) (autoload 'straight-register-package "straight" "Register a package without cloning, building, or activating it.
This function is equivalent to calling `straight-use-package'
with a non-nil argument for NO-CLONE. It is provided for
convenience. MELPA-STYLE-RECIPE is as for
`straight-use-package'.

(fn MELPA-STYLE-RECIPE)") (autoload 'straight-use-package-no-build "straight" "Register and clone a package without building it.
This function is equivalent to calling `straight-use-package'
with nil for NO-CLONE but a non-nil argument for NO-BUILD. It is
provided for convenience. MELPA-STYLE-RECIPE is as for
`straight-use-package'.

(fn MELPA-STYLE-RECIPE)") (autoload 'straight-use-package-lazy "straight" "Register, build, and activate a package if it is already cloned.
This function is equivalent to calling `straight-use-package'
with symbol `lazy' for NO-CLONE. It is provided for convenience.
MELPA-STYLE-RECIPE is as for `straight-use-package'.

(fn MELPA-STYLE-RECIPE)") (autoload 'straight-use-recipes "straight" "Register a recipe repository using MELPA-STYLE-RECIPE.
This registers the recipe and builds it if it is already cloned.
Note that you probably want the recipe for a recipe repository to
include a nil `:build' property, to unconditionally
inhibit the build phase.

This function also adds the recipe repository to
`straight-recipe-repositories', at the end of the list.

(fn MELPA-STYLE-RECIPE)") (autoload 'straight-override-recipe "straight" "Register MELPA-STYLE-RECIPE as a recipe override.
This puts it in `straight-recipe-overrides', depending on the
value of `straight-current-profile'.

(fn MELPA-STYLE-RECIPE)") (autoload 'straight-check-package "straight" "Rebuild a PACKAGE if it has been modified.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. See also `straight-rebuild-package' and
`straight-check-all'.

(fn PACKAGE)" t) (autoload 'straight-check-all "straight" "Rebuild any packages that have been modified.
See also `straight-rebuild-all' and `straight-check-package'.
This function should not be called during init." t) (autoload 'straight-rebuild-package "straight" "Rebuild a PACKAGE.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument RECURSIVE, rebuild
all dependencies as well. See also `straight-check-package' and
`straight-rebuild-all'.

(fn PACKAGE &optional RECURSIVE)" t) (autoload 'straight-rebuild-all "straight" "Rebuild all packages.
See also `straight-check-all' and `straight-rebuild-package'." t) (autoload 'straight-prune-build-cache "straight" "Prune the build cache.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build mtime information and any cached
autoloads discarded.") (autoload 'straight-prune-build-directory "straight" "Prune the build directory.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build directories deleted.") (autoload 'straight-prune-build "straight" "Prune the build cache and build directory.
This means that only packages that were built in the last init
run and subsequent interactive session will remain; other
packages will have their build mtime information discarded and
their build directories deleted." t) (autoload 'straight-normalize-package "straight" "Normalize a PACKAGE's local repository to its recipe's configuration.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'.

(fn PACKAGE)" t) (autoload 'straight-normalize-all "straight" "Normalize all packages. See `straight-normalize-package'.
Return a list of recipes for packages that were not successfully
normalized. If multiple packages come from the same local
repository, only one is normalized.

PREDICATE, if provided, filters the packages that are normalized.
It is called with the package name as a string, and should return
non-nil if the package should actually be normalized.

(fn &optional PREDICATE)" t) (autoload 'straight-fetch-package "straight" "Try to fetch a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
fetch not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-fetch-package-and-deps "straight" "Try to fetch a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are fetched
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
fetch not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-fetch-all "straight" "Try to fetch all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, fetch not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
fetched. If multiple packages come from the same local
repository, only one is fetched.

PREDICATE, if provided, filters the packages that are fetched. It
is called with the package name as a string, and should return
non-nil if the package should actually be fetched.

(fn &optional FROM-UPSTREAM PREDICATE)" t) (autoload 'straight-merge-package "straight" "Try to merge a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
merge not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-merge-package-and-deps "straight" "Try to merge a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are merged
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
merge not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-merge-all "straight" "Try to merge all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, merge not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
merged. If multiple packages come from the same local
repository, only one is merged.

PREDICATE, if provided, filters the packages that are merged. It
is called with the package name as a string, and should return
non-nil if the package should actually be merged.

(fn &optional FROM-UPSTREAM PREDICATE)" t) (autoload 'straight-pull-package "straight" "Try to pull a PACKAGE from the primary remote.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM, pull
not just from primary remote but also from upstream (for forked
packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-pull-package-and-deps "straight" "Try to pull a PACKAGE and its (transitive) dependencies.
PACKAGE, its dependencies, their dependencies, etc. are pulled
from their primary remotes.

PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'. With prefix argument FROM-UPSTREAM,
pull not just from primary remote but also from upstream (for
forked packages).

(fn PACKAGE &optional FROM-UPSTREAM)" t) (autoload 'straight-pull-all "straight" "Try to pull all packages from their primary remotes.
With prefix argument FROM-UPSTREAM, pull not just from primary
remotes but also from upstreams (for forked packages).

Return a list of recipes for packages that were not successfully
pulled. If multiple packages come from the same local repository,
only one is pulled.

PREDICATE, if provided, filters the packages that are pulled. It
is called with the package name as a string, and should return
non-nil if the package should actually be pulled.

(fn &optional FROM-UPSTREAM PREDICATE)" t) (autoload 'straight-push-package "straight" "Push a PACKAGE to its primary remote, if necessary.
PACKAGE is a string naming a package. Interactively, select
PACKAGE from the known packages in the current Emacs session
using `completing-read'.

(fn PACKAGE)" t) (autoload 'straight-push-all "straight" "Try to push all packages to their primary remotes.

Return a list of recipes for packages that were not successfully
pushed. If multiple packages come from the same local repository,
only one is pushed.

PREDICATE, if provided, filters the packages that are normalized.
It is called with the package name as a string, and should return
non-nil if the package should actually be normalized.

(fn &optional PREDICATE)" t) (autoload 'straight-freeze-versions "straight" "Write version lockfiles for currently activated packages.
This implies first pushing all packages that have unpushed local
changes. If the package management system has been used since the
last time the init-file was reloaded, offer to fix the situation
by reloading the init-file again. If FORCE is
non-nil (interactively, if a prefix argument is provided), skip
all checks and write the lockfile anyway.

Currently, writing version lockfiles requires cloning all lazily
installed packages. Hopefully, this inconvenient requirement will
be removed in the future.

Multiple lockfiles may be written (one for each profile),
according to the value of `straight-profiles'.

(fn &optional FORCE)" t) (autoload 'straight-thaw-versions "straight" "Read version lockfiles and restore package versions to those listed." t) (autoload 'straight-bug-report "straight" "Test straight.el in a clean environment.
ARGS may be any of the following keywords and their respective values:
  - :pre-bootstrap (Form)...
      Forms evaluated before bootstrapping straight.el
      e.g. (setq straight-repository-branch \"develop\")
      Note this example is already in the default bootstrapping code.

  - :post-bootstrap (Form)...
      Forms evaluated in the testing environment after boostrapping.
      e.g. (straight-use-package \\='(example :type git :host github))

  - :interactive Boolean
      If nil, the subprocess will immediately exit after the test.
      Output will be printed to `straight-bug-report--process-buffer'
      Otherwise, the subprocess will be interactive.

  - :preserve Boolean
      If non-nil, the test directory is left in the directory stored in the
      variable `temporary-file-directory'. Otherwise, it is
      immediately removed after the test is run.

  - :executable String
      Indicate the Emacs executable to launch.
      Defaults to the path of the current Emacs executable.

  - :raw Boolean
      If non-nil, the raw process output is sent to
      `straight-bug-report--process-buffer'. Otherwise, it is
      formatted as markdown for submitting as an issue.

  - :user-dir String
      If non-nil, the test is run with `user-emacs-directory' set to STRING.
      Otherwise, a temporary directory is created and used.
      Unless absolute, paths are expanded relative to the variable
      `temporary-file-directory'.

ARGS are accessible within the :pre/:post-bootsrap phases via the
locally bound plist, straight-bug-report-args.

(fn &rest ARGS)" nil t) (function-put 'straight-bug-report 'lisp-indent-function 0) (autoload 'straight-dependencies "straight" "Return a list of PACKAGE's dependencies.

(fn &optional PACKAGE)" t) (autoload 'straight-dependents "straight" "Return a list of PACKAGE's dependents.

(fn &optional PACKAGE)" t) (register-definition-prefixes "straight" '("straight-")) (register-definition-prefixes "straight-ert-print-hack" '("+without-print-limits")) (defvar straight-x-pinned-packages nil "List of pinned packages.") (register-definition-prefixes "straight-x" '("straight-x-")) (provide 'straight-autoloads)) "async" ((dired-async smtpmail-async async-package async async-bytecomp async-autoloads) (autoload 'async-start-process "async" "Start the executable PROGRAM asynchronously named NAME.  See `async-start'.
PROGRAM is passed PROGRAM-ARGS, calling FINISH-FUNC with the
process object when done.  If FINISH-FUNC is nil, the future
object will return the process object when the program is
finished.  Set DEFAULT-DIRECTORY to change PROGRAM's current
working directory.

(fn NAME PROGRAM FINISH-FUNC &rest PROGRAM-ARGS)") (autoload 'async-start "async" "Execute START-FUNC (often a lambda) in a subordinate Emacs process.
When done, the return value is passed to FINISH-FUNC.  Example:

    (async-start
       ;; What to do in the child process
       (lambda ()
         (message \"This is a test\")
         (sleep-for 3)
         222)

       ;; What to do when it finishes
       (lambda (result)
         (message \"Async process done, result should be 222: %s\"
                  result)))

If you call `async-send' from a child process, the message will
be also passed to the FINISH-FUNC.  You can test RESULT to see if
it is a message by using `async-message-p'.  If nil, it means
this is the final result.  Example of the FINISH-FUNC:

    (lambda (result)
      (if (async-message-p result)
          (message \"Received a message from child process: %s\" result)
        (message \"Async process done, result: %s\" result)))

If FINISH-FUNC is nil or missing, a future is returned that can
be inspected using `async-get', blocking until the value is
ready.  Example:

    (let ((proc (async-start
                   ;; What to do in the child process
                   (lambda ()
                     (message \"This is a test\")
                     (sleep-for 3)
                     222))))

        (message \"I'm going to do some work here\") ;; ....

        (message \"Waiting on async process, result should be 222: %s\"
                 (async-get proc)))

If you don't want to use a callback, and you don't care about any
return value from the child process, pass the `ignore' symbol as
the second argument (if you don't, and never call `async-get', it
will leave *emacs* process buffers hanging around):

    (async-start
     (lambda ()
       (delete-file \"a remote file on a slow link\" nil))
     \\='ignore)

Special case:
If the output of START-FUNC is a string with properties
e.g. (buffer-string) RESULT will be transformed in a list where the
car is the string itself (without props) and the cdr the rest of
properties, this allows using in FINISH-FUNC the string without
properties and then apply the properties in cdr to this string (if
needed).
Properties handling special objects like markers are returned as
list to allow restoring them later.
See <https://github.com/jwiegley/emacs-async/issues/145> for more infos.

Note: Even when FINISH-FUNC is present, a future is still
returned except that it yields no value (since the value is
passed to FINISH-FUNC).  Call `async-get' on such a future always
returns nil.  It can still be useful, however, as an argument to
`async-ready' or `async-wait'.

(fn START-FUNC &optional FINISH-FUNC)") (register-definition-prefixes "async" '("async-")) (autoload 'async-byte-recompile-directory "async-bytecomp" "Compile all *.el files in DIRECTORY asynchronously.
All *.elc files are systematically deleted before proceeding.

(fn DIRECTORY &optional QUIET)") (defvar async-bytecomp-package-mode nil "Non-nil if Async-Bytecomp-Package mode is enabled.
See the `async-bytecomp-package-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `async-bytecomp-package-mode'.") (custom-autoload 'async-bytecomp-package-mode "async-bytecomp" nil) (autoload 'async-bytecomp-package-mode "async-bytecomp" "Byte compile asynchronously packages installed with package.el.

Async compilation of packages can be controlled by
`async-bytecomp-allowed-packages'.

This is a global minor mode.  If called interactively, toggle the
`Async-Bytecomp-Package mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='async-bytecomp-package-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'async-byte-compile-file "async-bytecomp" "Byte compile Lisp code FILE asynchronously.

Same as `byte-compile-file' but asynchronous.

(fn FILE)" t) (register-definition-prefixes "async-bytecomp" '("async-")) (register-definition-prefixes "async-package" '("async-p")) (defvar dired-async-mode nil "Non-nil if Dired-Async mode is enabled.
See the `dired-async-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `dired-async-mode'.") (custom-autoload 'dired-async-mode "dired-async" nil) (autoload 'dired-async-mode "dired-async" "Do dired actions asynchronously.

This is a global minor mode.  If called interactively, toggle the
`Dired-Async mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='dired-async-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'dired-async-do-copy "dired-async" "Run ‘dired-do-copy’ asynchronously.

(fn &optional ARG)" t) (autoload 'dired-async-do-symlink "dired-async" "Run ‘dired-do-symlink’ asynchronously.

(fn &optional ARG)" t) (autoload 'dired-async-do-hardlink "dired-async" "Run ‘dired-do-hardlink’ asynchronously.

(fn &optional ARG)" t) (autoload 'dired-async-do-rename "dired-async" "Run ‘dired-do-rename’ asynchronously.

(fn &optional ARG)" t) (register-definition-prefixes "dired-async" '("dired-async-")) (register-definition-prefixes "smtpmail-async" '("async-smtpmail-")) (provide 'async-autoloads)) "helm-core" ((helm-core helm-lib helm-source helm-core-autoloads helm-multi-match) (autoload 'helm-define-multi-key "helm-core" "In KEYMAP, define key sequence KEY for function list FUNCTIONS.
Each function runs sequentially for each KEY press.
If DELAY is specified, switch back to initial function of FUNCTIONS list
after DELAY seconds.
The functions in FUNCTIONS list take no args.
E.g.
    (defun foo ()
      (interactive)
      (message \"Run foo\"))
    (defun bar ()
      (interactive)
      (message \"Run bar\"))
    (defun baz ()
      (interactive)
      (message \"Run baz\"))

(helm-define-multi-key global-map (kbd \"<f5> q\") \\='(foo bar baz) 2)

Each time \"<f5> q\" is pressed, the next function is executed.
Waiting more than 2 seconds between key presses switches back to
executing the first function on the next hit.

(fn KEYMAP KEY FUNCTIONS &optional DELAY)") (autoload 'helm-multi-key-defun "helm-core" "Define NAME as a multi-key command running FUNS.
After DELAY seconds, the FUNS list is reinitialized.
See `helm-define-multi-key'.

(fn NAME DOCSTRING FUNS &optional DELAY)" nil t) (function-put 'helm-multi-key-defun 'lisp-indent-function 2) (function-put 'helm-multi-key-defun 'doc-string-elt 2) (autoload 'helm-define-key-with-subkeys "helm-core" "Define in MAP a KEY and SUBKEY to COMMAND.

This allows typing KEY to call COMMAND the first time and
type only SUBKEY on subsequent calls.

Arg MAP is the keymap to use, SUBKEY is the initial short
key binding to call COMMAND.

Arg OTHER-SUBKEYS is an alist specifying other short key bindings
to use once started, e.g.:

    (helm-define-key-with-subkeys global-map
       (kbd \"C-x v n\") ?n \\='git-gutter:next-hunk
       \\='((?p . git-gutter:previous-hunk)))

In this example, `C-x v n' will run `git-gutter:next-hunk'
subsequent \"n\" will run this command again and subsequent \"p\"
will run `git-gutter:previous-hunk'.

If specified PROMPT can be displayed in minibuffer to describe
SUBKEY and OTHER-SUBKEYS.  Arg EXIT-FN specifies a function to run
on exit.

For any other key pressed, run their assigned command as defined
in MAP and then exit the loop running EXIT-FN, if specified.

If DELAY is specified the command expires after DELAY seconds.

NOTE: SUBKEY and OTHER-SUBKEYS bindings support only char syntax
and vectors, so don't use strings to define them.  While defining
or executing a kbd macro no SUBKEY or OTHER-SUBKEYS are provided,
i.e. the loop is not entered after running COMMAND.

(fn MAP KEY SUBKEY COMMAND &optional OTHER-SUBKEYS PROMPT EXIT-FN DELAY DOCSTRING)") (function-put 'helm-define-key-with-subkeys 'lisp-indent-function 1) (autoload 'helm-configuration "helm-core" "Customize Helm." t) (autoload 'helm-debug-open-last-log "helm-core" "Open Helm log file or buffer of last Helm session." t) (autoload 'helm "helm-core" "Main function to execute helm sources.

PLIST is a list like

(:key1 val1 :key2 val2 ...)

 or

(&optional sources input prompt resume preselect
            buffer keymap default history allow-nest).

** Keywords

Keywords supported:

- :sources
- :input
- :prompt
- :resume
- :preselect
- :buffer
- :keymap
- :default
- :history
- :allow-nest

Extra LOCAL-VARS keywords are supported, see the \"** Other
keywords\" section below.

Basic keywords are the following:

*** :sources

One of the following:

- List of sources
- Symbol whose value is a list of sources
- Alist representing a Helm source.
  - In this case the source has no name and is referenced in
    `helm-sources' as a whole alist.

*** :input

Initial input of minibuffer (temporary value of `helm-pattern')

*** :prompt

Minibuffer prompt. Default value is `helm--prompt'.

*** :resume

If t, allow resumption of the previous session of this Helm
command, skipping initialization.

If \\='noresume, this instance of `helm' cannot be resumed.

*** :preselect

Initially selected candidate (string or regexp).

*** :buffer

Buffer name for this Helm session. `helm-buffer' will take this value.

*** :keymap

[Obsolete]

Keymap used at the start of this Helm session.

It is overridden by keymaps specified in sources, and is kept
only for backward compatibility.

Keymaps should be specified in sources using the :keymap slot
instead. See `helm-source'.

This keymap is not restored by `helm-resume'.

*** :default

Default value inserted into the minibuffer with
\\<minibuffer-local-map>\\[next-history-element].

It can be a string or a list of strings, in this case
\\<minibuffer-local-map>\\[next-history-element] cycles through
the list items, starting with the first.

If nil, `thing-at-point' is used.

If `helm-maybe-use-default-as-input' is non-nil, display is
updated using this value if this value matches, otherwise it is
ignored. If :input is specified, it takes precedence on :default.

*** :history

Minibuffer input, by default, is pushed to `minibuffer-history'.

When an argument HISTORY is provided, input is pushed to
HISTORY. HISTORY should be a valid symbol.

*** :allow-nest

Allow running this Helm command in a running Helm session.

** Other keywords

Other keywords are interpreted as local variables of this Helm
session. The `helm-' prefix can be omitted. For example,

(helm :sources \\='helm-source-buffers-list
       :buffer \"*helm buffers*\"
       :candidate-number-limit 10)

Starts a Helm session with the variable
`helm-candidate-number-limit' set to 10.

** Backward compatibility

For backward compatibility, positional parameters are
supported:

(helm sources input prompt resume preselect
       buffer keymap default history allow-nest)

However, the use of non-keyword args is deprecated.

(fn &key SOURCES INPUT PROMPT RESUME PRESELECT BUFFER KEYMAP DEFAULT HISTORY ALLOW-NEST OTHER-LOCAL-VARS)") (autoload 'helm-cycle-resume "helm-core" "Cycle in `helm-buffers' list and resume when waiting more than 1.2s." t) (autoload 'helm-other-buffer "helm-core" "Simplified Helm interface with other `helm-buffer'.
Call `helm' only with SOURCES and BUFFER as args.

(fn SOURCES BUFFER)") (register-definition-prefixes "helm-core" '("helm-" "with-helm-")) (register-definition-prefixes "helm-lib" '("helm-" "with-helm-")) (register-definition-prefixes "helm-multi-match" '("helm-m")) (register-definition-prefixes "helm-source" '("helm-")) (provide 'helm-core-autoloads)) "wfnames" ((wfnames-autoloads wfnames) (autoload 'wfnames-setup-buffer "wfnames" "Initialize wfnames buffer with FILES and display it with DISPLAY-FN.

Arg DISPLAY-FN default to `switch-to-buffer' if unspecified.
When APPEND is specified, append FILES to existing `wfnames-buffer'.

(fn FILES &optional (DISPLAY-FN #\\='switch-to-buffer) APPEND)") (register-definition-prefixes "wfnames" '("wfnames-")) (provide 'wfnames-autoloads)) "helm" ((helm-grep helm-font helm-bookmark helm-adaptive helm-occur helm-easymenu helm-fd helm-eshell helm-buffers helm helm-tags helm-net helm-locate helm-utils helm-elisp helm-global-bindings helm-man helm-external helm-misc helm-ring helm-semantic helm-command helm-id-utils helm-x-files helm-autoloads helm-types helm-eval helm-help helm-epa helm-dabbrev helm-regexp helm-info helm-imenu helm-sys helm-packages helm-color helm-find helm-for-files helm-mode helm-files) (defvar helm-adaptive-mode nil "Non-nil if Helm-Adaptive mode is enabled.
See the `helm-adaptive-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-adaptive-mode'.") (custom-autoload 'helm-adaptive-mode "helm-adaptive" nil) (autoload 'helm-adaptive-mode "helm-adaptive" "Toggle adaptive sorting in all sources.

This is a global minor mode.  If called interactively, toggle the
`Helm-Adaptive mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-adaptive-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'helm-reset-adaptive-history "helm-adaptive" "Delete all `helm-adaptive-history' and his file.
Useful when you have a old or corrupted
`helm-adaptive-history-file'." t) (register-definition-prefixes "helm-adaptive" '("helm-adapt")) (autoload 'helm-bookmarks "helm-bookmark" "Preconfigured `helm' for bookmarks." t) (autoload 'helm-filtered-bookmarks "helm-bookmark" "Preconfigured `helm' for bookmarks (filtered by category).
Optional source `helm-source-bookmark-addressbook' is loaded only
if external addressbook-bookmark package is installed." t) (register-definition-prefixes "helm-bookmark" '("bmk" "bookmark" "helm-")) (autoload 'helm-buffers-quit-and-find-file-fn "helm-buffers" "

(fn SOURCE)") (autoload 'helm-buffers-list "helm-buffers" "Preconfigured `helm' to list buffers." t) (autoload 'helm-mini "helm-buffers" "Preconfigured `helm' displaying `helm-mini-default-sources'." t) (register-definition-prefixes "helm-buffers" '("helm-")) (autoload 'helm-colors "helm-color" "Preconfigured `helm' for color." t) (register-definition-prefixes "helm-color" '("helm-")) (autoload 'helm-M-x "helm-command" "Preconfigured `helm' for Emacs commands.
It is `helm' replacement of regular `M-x'
`execute-extended-command'.

Unlike regular `M-x' Emacs vanilla `execute-extended-command'
command, the prefix args if needed, can be passed AFTER starting
`helm-M-x'.  When a prefix arg is passed BEFORE starting
`helm-M-x', the first `C-u' while in `helm-M-x' session will
disable it.

You can get help on each command by persistent action.

(fn ARG)" t) (register-definition-prefixes "helm-command" '("helm-")) (autoload 'helm-dabbrev "helm-dabbrev" "Preconfigured helm for dynamic abbreviations." t) (register-definition-prefixes "helm-dabbrev" '("helm-dabbrev-")) (autoload 'helm-lisp-completion-at-point "helm-elisp" "Preconfigured Helm for Lisp symbol completion at point." t) (autoload 'helm-get-first-line-documentation "helm-elisp" "Return first line documentation of symbol SYM truncated at END-COLUMN.
If SYM is not documented, return \"Not documented\".
Argument NAME allows specifiying what function to use to display
documentation when SYM name is the same for function and variable.

(fn SYM &optional (NAME \"describe-function\") (END-COLUMN 72))") (autoload 'helm-complete-file-name-at-point "helm-elisp" "Preconfigured Helm to complete file name at point.

(fn &optional FORCE)" t) (autoload 'helm-lisp-indent "helm-elisp" nil t) (autoload 'helm-apropos "helm-elisp" "Preconfigured Helm to describe commands, functions, variables and faces.
In non interactives calls DEFAULT argument should be provided as
a string, i.e. the `symbol-name' of any existing symbol.

(fn DEFAULT)" t) (autoload 'helm-manage-advice "helm-elisp" "Preconfigured `helm' to disable/enable function advices." t) (autoload 'helm-locate-library "helm-elisp" "Preconfigured helm to locate elisp libraries.

When `completions-detailed' or `helm-completions-detailed' is non
nil, a description of libraries is provided. The libraries are
partially cached in the variables
`helm--locate-library-doc-cache' and
`helm--locate-library-cache'.  TIP: You can make these vars
persistent for faster start with the psession package, using M-x
psession-make-persistent-variable.  NOTE: The caches affect as
well `find-libray' and `locate-library' when `helm-mode' is
enabled and `completions-detailed' is non nil.  There is no need
to refresh the caches, they will be updated automatically if some
new libraries are found, however when a library update its
headers and the description change you can reset the caches with
a prefix arg.

(fn &optional ARG)" t) (autoload 'helm-timers "helm-elisp" "Preconfigured `helm' for timers." t) (autoload 'helm-complex-command-history "helm-elisp" "Preconfigured `helm' for complex command history." t) (register-definition-prefixes "helm-elisp" '("helm-" "with-helm-show-completion")) (defvar helm-epa-mode nil "Non-nil if Helm-Epa mode is enabled.
See the `helm-epa-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-epa-mode'.") (custom-autoload 'helm-epa-mode "helm-epa" nil) (autoload 'helm-epa-mode "helm-epa" "Enable helm completion on gpg keys in epa functions.

This is a global minor mode.  If called interactively, toggle the
`Helm-Epa mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-epa-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'helm-epa-list-keys "helm-epa" "List all gpg keys.
This is the helm interface for `epa-list-keys'." t) (register-definition-prefixes "helm-epa" '("helm-epa")) (autoload 'helm-esh-pcomplete "helm-eshell" "Preconfigured `helm' to provide Helm completion in Eshell." t) (autoload 'helm-eshell-history "helm-eshell" "Preconfigured Helm for Eshell history." t) (autoload 'helm-eshell-prompts "helm-eshell" "Pre-configured `helm' to browse the prompts of the current Eshell." t) (autoload 'helm-eshell-prompts-all "helm-eshell" "Pre-configured `helm' to browse the prompts of all Eshell sessions." t) (register-definition-prefixes "helm-eshell" '("helm-e")) (autoload 'helm-eval-expression "helm-eval" "Preconfigured `helm' for `helm-source-evaluation-result'.

(fn ARG)" t) (autoload 'helm-eval-expression-with-eldoc "helm-eval" "Preconfigured `helm' for `helm-source-evaluation-result' with `eldoc' support." t) (autoload 'helm-calcul-expression "helm-eval" "Preconfigured `helm' for `helm-source-calculation-result'." t) (register-definition-prefixes "helm-eval" '("helm-")) (autoload 'helm-run-external-command "helm-external" "Preconfigured `helm' to run External PROGRAM asyncronously from Emacs.
If program is already running try to run `helm-raise-command' if
defined otherwise exit with error. You can set your own list of
commands with `helm-external-commands-list'." t) (register-definition-prefixes "helm-external" '("helm-")) (register-definition-prefixes "helm-fd" '("helm-fd-")) (defvar helm-ff-icon-mode nil "Non-nil if Helm-Ff-Icon mode is enabled.
See the `helm-ff-icon-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-ff-icon-mode'.") (custom-autoload 'helm-ff-icon-mode "helm-files" nil) (autoload 'helm-ff-icon-mode "helm-files" "Display icons from `all-the-icons' package in HFF when enabled.

This is a global minor mode.  If called interactively, toggle the
`Helm-Ff-Icon mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-ff-icon-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'helm-ff-clear-image-dired-thumbnails-cache "helm-files" "Clear `helm-ff-image-dired-thumbnails-cache'.
You may want to do this after customizing
`image-dired-thumbnail-storage' which may change the place where
thumbnail files are stored." t) (autoload 'helm-ff-cleanup-image-dired-dir-and-cache "helm-files" "Cleanup `image-dired-dir' directory.
Delete all thumb files that are no more associated with an existing
image file in `helm-ff-image-dired-thumbnails-cache'." t) (autoload 'helm-projects-history "helm-files" "Jump to project already visisted with `helm-browse-project'.

(fn &optional ARG)" t) (autoload 'helm-browse-project "helm-files" "Preconfigured helm to browse projects.
Browse files and see status of project with its VCS.
Only HG and GIT are supported for now.
Fall back to `helm-browse-project-find-files' if current
directory is not under control of one of those VCS.
With a prefix ARG browse files recursively, with two prefix ARG
rebuild the cache.
If the current directory is found in the cache, start
`helm-browse-project-find-files' even with no prefix ARG.
NOTE: The prefix ARG have no effect on the VCS controlled
directories.

Needed dependencies for VCS:
<https://github.com/emacs-helm/helm-ls-git>
and
<https://github.com/emacs-helm/helm-ls-hg>.

(fn ARG)" t) (autoload 'helm-find-files "helm-files" "Preconfigured `helm' for helm implementation of `find-file'.
Called with a prefix arg show history if some.
Don't call it from programs, use `helm-find-files-1' instead.
This is the starting point for nearly all actions you can do on
files.

(fn ARG)" t) (register-definition-prefixes "helm-files" '("eshell-command-aliases-list" "helm-")) (autoload 'helm-find "helm-find" "Preconfigured `helm' for the find shell command.

Recursively find files whose names are matched by all specified
globbing PATTERNs under the current directory using the external
program specified in `find-program' (usually \"find\").  Every
input PATTERN is silently wrapped into two stars: *PATTERN*.

With prefix argument, prompt for a directory to search.

When user option `helm-findutils-search-full-path' is non-nil,
match against complete paths, otherwise, against file names
without directory part.

The (possibly empty) list of globbing PATTERNs can be followed by
the separator \"*\" plus any number of additional arguments that
are passed to \"find\" literally.

(fn ARG)" t) (register-definition-prefixes "helm-find" '("helm-")) (autoload 'helm-select-xfont "helm-font" "Preconfigured `helm' to select Xfont." t) (autoload 'helm-ucs "helm-font" "Preconfigured `helm' for `ucs-names'.

Called with a prefix arg force reloading cache.

(fn ARG)" t) (register-definition-prefixes "helm-font" '("helm-")) (autoload 'helm-for-files "helm-for-files" "Preconfigured `helm' for opening files.
Run all sources defined in `helm-for-files-preferred-list'." t) (autoload 'helm-multi-files "helm-for-files" "Preconfigured helm like `helm-for-files' but running locate only on demand.

Allow toggling back and forth from locate to others sources with
`helm-multi-files-toggle-locate-binding' key.
This avoids launching locate needlessly when what you are
searching for is already found." t) (autoload 'helm-recentf "helm-for-files" "Preconfigured `helm' for `recentf'." t) (register-definition-prefixes "helm-for-files" '("helm-")) (register-definition-prefixes "helm-global-bindings" '("helm-command-")) (autoload 'helm-goto-precedent-file "helm-grep" "Go to previous file in Helm grep/etags buffers." t) (autoload 'helm-goto-next-file "helm-grep" "Go to previous file in Helm grep/etags buffers." t) (autoload 'helm-revert-next-error-last-buffer "helm-grep" "Revert last `next-error' buffer from `current-buffer'.

Accept to revert only `helm-grep-mode' or `helm-occur-mode' buffers.
Use this when you want to revert the `next-error' buffer after
modifications in `current-buffer'." t) (autoload 'helm-do-grep-ag "helm-grep" "Preconfigured `helm' for grepping with AG in `default-directory'.
With prefix arg prompt for type if available with your AG
version.

(fn ARG)" t) (autoload 'helm-grep-do-git-grep "helm-grep" "Preconfigured `helm' for git-grepping `default-directory'.
With a prefix arg ARG git-grep the whole repository.

(fn ARG)" t) (register-definition-prefixes "helm-grep" '("helm-")) (autoload 'helm-documentation "helm-help" "Preconfigured `helm' for Helm documentation.
With a prefix arg refresh the documentation.

Find here the documentation of all documented sources." t) (defvar helm-comp-read-mode-line "\\<helm-comp-read-map>C/\\[helm-cr-empty-string]:Empty \\<helm-map>\\[helm-help]:Help \\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend \\[helm-customize-group]:Conf") (defvar helm-read-file-name-mode-line-string "\\<helm-read-file-map>\\[helm-help]:Help C/\\[helm-cr-empty-string]:Empty \\<helm-map>\\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend \\[helm-customize-group]:Conf" "String displayed in mode-line in `helm-source-find-files'.") (defvar helm-top-mode-line "\\<helm-top-map>\\[helm-help]:Help \\<helm-map>\\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend \\[helm-customize-group]:Conf") (register-definition-prefixes "helm-help" '("helm-")) (autoload 'helm-gid "helm-id-utils" "Preconfigured `helm' for `gid' command line of `ID-Utils'.
Need A database created with the command `mkid' above
`default-directory'.
Need id-utils as dependency which provide `mkid', `gid' etc..
See <https://www.gnu.org/software/idutils/>." t) (register-definition-prefixes "helm-id-utils" '("helm-gid-")) (autoload 'helm-imenu "helm-imenu" "Preconfigured `helm' for `imenu'." t) (autoload 'helm-imenu-in-all-buffers "helm-imenu" "Fetch Imenu entries in all buffers with similar mode as current.
A mode is similar as current if it is the same, it is derived
i.e. `derived-mode-p' or it have an association in
`helm-imenu-all-buffer-assoc'." t) (register-definition-prefixes "helm-imenu" '("helm-")) (autoload 'helm-info "helm-info" "Preconfigured `helm' for searching Info files' indices.

With a prefix argument \\[universal-argument], set REFRESH to
non-nil.

Optional parameter REFRESH, when non-nil, re-evaluates
`helm-default-info-index-list'.  If the variable has been
customized, set it to its saved value.  If not, set it to its
standard value. See `custom-reevaluate-setting' for more.

REFRESH is useful when new Info files are installed.  If
`helm-default-info-index-list' has not been customized, the new
Info files are made available.

(fn &optional REFRESH)" t) (autoload 'helm-info-at-point "helm-info" "Preconfigured `helm' for searching info at point." t) (register-definition-prefixes "helm-info" '("helm-")) (autoload 'helm-projects-find-files "helm-locate" "Find files with locate in `helm-locate-project-list'.
With a prefix arg refresh the database in each project.

(fn UPDATE)" t) (autoload 'helm-locate "helm-locate" "Preconfigured `helm' for Locate.
Note: you can add locate options after entering pattern.
See \\='man locate' for valid options and also `helm-locate-command'.

You can specify a local database with prefix argument ARG.
With two prefix arg, refresh the current local db or create it if
it doesn't exists.

To create a user specific db, use
\"updatedb -l 0 -o db_path -U directory\".
Where db_path is a filename matched by
`helm-locate-db-file-regexp'.

(fn ARG)" t) (register-definition-prefixes "helm-locate" '("helm-")) (autoload 'helm-man-woman "helm-man" "Preconfigured `helm' for Man and Woman pages.
With a prefix ARG reinitialize the cache.  To have a popup
showing a basic description of selected candidate, turn on
`helm-popup-tip-mode'.

(fn ARG)" t) (register-definition-prefixes "helm-man" '("helm-")) (defvar helm-minibuffer-history-mode nil "Non-nil if Helm-Minibuffer-History mode is enabled.
See the `helm-minibuffer-history-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-minibuffer-history-mode'.") (custom-autoload 'helm-minibuffer-history-mode "helm-misc" nil) (autoload 'helm-minibuffer-history-mode "helm-misc" "Bind `helm-minibuffer-history-key' in al minibuffer maps.

This mode is enabled by `helm-mode', so there is no need to enable it directly.

This is a global minor mode.  If called interactively, toggle the
`Helm-Minibuffer-History mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-minibuffer-history-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'helm-world-time "helm-misc" "Preconfigured `helm' to show world time.
Default action change TZ environment variable locally to emacs." t) (autoload 'helm-insert-latex-math "helm-misc" "Preconfigured helm for latex math symbols completion." t) (autoload 'helm-ratpoison-commands "helm-misc" "Preconfigured `helm' to execute ratpoison commands." t) (autoload 'helm-stumpwm-commands "helm-misc" "Preconfigured helm for stumpwm commands." t) (autoload 'helm-minibuffer-history "helm-misc" "Preconfigured `helm' for `minibuffer-history'." t) (autoload 'helm-outline "helm-misc" "Basic helm navigation tool for outline buffers." t) (register-definition-prefixes "helm-misc" '("helm-")) (autoload 'helm-comp-read "helm-mode" "Read a string in the minibuffer, with helm completion.

It is helm `completing-read' equivalent.

- PROMPT is the prompt name to use.

- COLLECTION can be a list, alist, vector, obarray or hash-table.
  For alists and hash-tables their car are use as real value of
  candidate unless ALISTP is non-nil.
  It can be also a function that receives three arguments:
  the values string, predicate and t. See `all-completions' for more details.

Keys description:

- TEST: A predicate called with one arg i.e candidate.

- INITIAL-INPUT: Same as input arg in `helm'.

- PRESELECT: See preselect arg of `helm'.

- DEFAULT: This option is used only for compatibility with regular
  Emacs `completing-read' (Same as DEFAULT arg of `completing-read').

- BUFFER: Name of helm-buffer.

- MUST-MATCH: Candidate selected must be one of COLLECTION.

- FUZZY: Enable fuzzy matching.

- REVERSE-HISTORY: When non--nil display history source after current
  source completion.

- REQUIRES-PATTERN: Same as helm attribute, default is 0.

- HISTORY: A symbol where each result will be saved.
  If not specified as a symbol an error will popup.
  When specified, all elements of HISTORY are displayed in
  a special source before or after COLLECTION according to REVERSE-HISTORY.
  The main difference with INPUT-HISTORY is that the result of the
  completion is saved whereas in INPUT-HISTORY it is the minibuffer
  contents which is saved when you exit.
  Don't use the same symbol for INPUT-HISTORY and HISTORY.
  NOTE: As mentionned above this has nothing to do with
  `minibuffer-history-variable', therefore if you want to save this
  history persistently, you will have to add this variable to the
  relevant variable of your favorite tool for persistent emacs session
  i.e. psession, desktop etc...

- RAW-HISTORY: When non-nil do not remove backslashs if some in
  HISTORY candidates.

- INPUT-HISTORY: A symbol. The minibuffer input history will be
  stored there, if nil or not provided, `minibuffer-history'
  will be used instead.  You can navigate in this history with
  `M-p' and `M-n'.
  Don't use the same symbol for INPUT-HISTORY and HISTORY.

- CASE-FOLD: Same as `helm-case-fold-search'.

- PERSISTENT-ACTION: A function called with one arg i.e candidate.

- PERSISTENT-HELP: A string to document PERSISTENT-ACTION.

- MODE-LINE: A string or list to display in mode line.
  Default is `helm-comp-read-mode-line'.

- KEYMAP: A keymap to use in this `helm-comp-read'.
  (the keymap will be shared with history source)

- NAME: The name related to this local source.

- HEADER-NAME: A function to alter NAME, see `helm'.

- EXEC-WHEN-ONLY-ONE: Bound `helm-execute-action-at-once-if-one'
  to non--nil. (possibles values are t or nil).

- VOLATILE: Use volatile attribute.

- SORT: A predicate to give to `sort' e.g `string-lessp'
  Use this only on small data as it is inefficient.
  If you want to sort faster add a sort function to
  FC-TRANSFORMER.
  Note that FUZZY when enabled is already providing a sort function.

- FC-TRANSFORMER: A `filtered-candidate-transformer' function
  or a list of functions.

- HIST-FC-TRANSFORMER: A `filtered-candidate-transformer'
  function for the history source.

- MARKED-CANDIDATES: If non-nil return candidate or marked candidates as a list.

- NOMARK: When non--nil don't allow marking candidates.

- ALISTP:
  When non-nil (default) pass the value of (DISPLAY . REAL)
  candidate in COLLECTION to action when COLLECTION is an alist or a
  hash-table, otherwise DISPLAY is always returned as result on exit,
  which is the default when using `completing-read'.
  See `helm-comp-read-get-candidates'.

- CANDIDATES-IN-BUFFER: when non--nil use a source build with
  `helm-source-in-buffer' which is much faster.
  Argument VOLATILE have no effect when CANDIDATES-IN-BUFFER is non--nil.

- GET-LINE: Specify the :get-line slot of `helm-source-in-buffer', has no effect
  when CANDIDATES-IN-BUFFER is nil.
 
- MATCH-PART: Allow matching only one part of candidate.
  See match-part documentation in `helm-source'.

- MATCH-DYNAMIC: See match-dynamic in `helm-source-sync'
  It has no effect when used with CANDIDATES-IN-BUFFER.

- ALLOW-NEST: Allow nesting this `helm-comp-read' in a helm session.
  See `helm'.

- MULTILINE: See multiline in `helm-source'.

- COERCE: See coerce in `helm-source'.

- RAW-CANDIDATE: Do not unquote the unknown candidate coming from helm-pattern
  when non nil. 

- GROUP: See group in `helm-source'.

Any prefix args passed during `helm-comp-read' invocation will be recorded
in `helm-current-prefix-arg', otherwise if prefix args were given before
`helm-comp-read' invocation, the value of `current-prefix-arg' will be used.
That means you can pass prefix args before or after calling a command
that use `helm-comp-read'.  See `helm-M-x' for example.

(fn PROMPT COLLECTION &key TEST INITIAL-INPUT DEFAULT PRESELECT (BUFFER \"*Helm Completions*\") MUST-MATCH FUZZY REVERSE-HISTORY (REQUIRES-PATTERN 0) (HISTORY nil SHISTORY) RAW-HISTORY INPUT-HISTORY (CASE-FOLD helm-comp-read-case-fold-search) (PERSISTENT-ACTION nil) (PERSISTENT-HELP \"DoNothing\") (MODE-LINE helm-comp-read-mode-line) HELP-MESSAGE (KEYMAP helm-comp-read-map) (NAME \"Helm Completions\") HEADER-NAME CANDIDATES-IN-BUFFER (GET-LINE #\\='buffer-substring) DIACRITICS MATCH-PART MATCH-DYNAMIC EXEC-WHEN-ONLY-ONE QUIT-WHEN-NO-CAND (VOLATILE t) SORT FC-TRANSFORMER HIST-FC-TRANSFORMER (MARKED-CANDIDATES helm-comp-read-use-marked) NOMARK (ALISTP t) (CANDIDATE-NUMBER-LIMIT helm-candidate-number-limit) MULTILINE ALLOW-NEST COERCE RAW-CANDIDATE (GROUP \\='helm) POPUP-INFO)") (autoload 'helm-read-file-name "helm-mode" "Read a file name with helm completion.

It is helm `read-file-name' emulation.

Argument PROMPT is the default prompt to use.

Keys description:

- NAME: Source name, default to \"Read File Name\".

- INITIAL-INPUT: Where to start reading file name,
                 default to `default-directory' or $HOME.

- BUFFER: `helm-buffer' name, defaults to \"*Helm Completions*\".

- TEST: A predicate called with one arg \\='candidate'.

- NORET: Allow disabling helm-ff-RET (have no effect if helm-ff-RET
                                      isn't bound to RET).

- CASE-FOLD: Same as `helm-case-fold-search'.

- PRESELECT: helm preselection.

- HISTORY: Display HISTORY in a special source.

- MUST-MATCH: Can be \\='confirm, nil, or t.

- FUZZY: Enable fuzzy matching when non-nil (Enabled by default).

- MARKED-CANDIDATES: When non--nil return a list of marked candidates
                     otherwise a single filename is returned.

- ALL-MARKED: Allow marking several dummy candidates.

- NOMARK: When non--nil don't allow marking candidates.

- ALISTP: Don't use `all-completions' in history
          (take effect only on history).

- PERSISTENT-ACTION-IF: a persistent if action function.

- PERSISTENT-HELP: persistent help message.

- MODE-LINE: A mode line message, default is
             `helm-read-file-name-mode-line-string'.

(fn PROMPT &key (NAME \"Read File Name\") INITIAL-INPUT (BUFFER \"*Helm file completions*\") TEST NORET (CASE-FOLD helm-file-name-case-fold-search) PRESELECT HISTORY MUST-MATCH (FUZZY t) DEFAULT MARKED-CANDIDATES ALL-MARKED (CANDIDATE-NUMBER-LIMIT helm-ff-candidate-number-limit) NOMARK (ALISTP t) (PERSISTENT-ACTION-IF \\='helm-find-files-persistent-action-if) (PERSISTENT-HELP \"Hit1 Expand Candidate, Hit2 or (C-u) Find file\") (MODE-LINE helm-read-file-name-mode-line-string))") (defvar helm-mode nil "Non-nil if Helm mode is enabled.
See the `helm-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-mode'.") (custom-autoload 'helm-mode "helm-mode" nil) (autoload 'helm-mode "helm-mode" "Toggle generic helm completion.

All functions in Emacs that use `completing-read',
`read-file-name', `completion-in-region' and friends will use helm
interface when this mode is turned on.

However you can modify this behavior for functions of your choice
with `helm-completing-read-handlers-alist'.

Called with a positive arg, turn on unconditionally, with a
negative arg turn off.
You can toggle it with M-x `helm-mode'.

About `ido-mode':
DO NOT enable `ido-everywhere' when using `helm-mode'.  Instead of
using `ido-mode', add the commands where you want to use ido to
`helm-completing-read-handlers-alist' with `ido' as value.

Note: This mode is incompatible with Emacs23.

(fn &optional ARG)" t) (register-definition-prefixes "helm-mode" '("helm-")) (autoload 'helm-browse-url-firefox "helm-net" "Same as `browse-url-firefox' but detach from Emacs.

So when you quit Emacs you can keep your Firefox session open and
not be prompted to kill the Firefox process.

NOTE: Probably not supported on some systems (e.g., Windows).

(fn URL &optional IGNORE)" t) (autoload 'helm-browse-url-opera "helm-net" "Browse URL with Opera browser and detach from Emacs.

So when you quit Emacs you can keep your Opera session open and
not be prompted to kill the Opera process.

NOTE: Probably not supported on some systems (e.g., Windows).

(fn URL &optional IGNORE)" t) (autoload 'helm-browse-url-chromium "helm-net" "Browse URL with Google Chrome browser.

(fn URL &optional IGNORE)" t) (autoload 'helm-browse-url-uzbl "helm-net" "Browse URL with uzbl browser.

(fn URL &optional IGNORE)" t) (autoload 'helm-browse-url-conkeror "helm-net" "Browse URL with conkeror browser.

(fn URL &optional IGNORE)" t) (autoload 'helm-browse-url-nyxt "helm-net" "Browse URL with nyxt browser.

(fn URL &optional IGNORE)" t) (autoload 'helm-surfraw "helm-net" "Preconfigured `helm' to search PATTERN with search ENGINE.

(fn PATTERN ENGINE)" t) (autoload 'helm-google-suggest "helm-net" "Preconfigured `helm' for Google search with Google suggest." t) (register-definition-prefixes "helm-net" '("helm-")) (autoload 'helm-occur "helm-occur" "Preconfigured helm for searching lines matching pattern in `current-buffer'.

When `helm-source-occur' is member of
`helm-sources-using-default-as-input' which is the default,
symbol at point is searched at startup.

When a region is marked search only in this region by narrowing.

To search in multiples buffers start from one of the commands listing
buffers (i.e. a helm command using `helm-source-buffers-list' like
`helm-mini') and use the multi occur buffers action.

This is the helm implementation that collect lines matching pattern
like vanilla Emacs `occur' but have nothing to do with it, the search
engine beeing completely different and also much faster." t) (autoload 'helm-occur-visible-buffers "helm-occur" "Run helm-occur on all visible buffers in frame." t) (autoload 'helm-occur-from-isearch "helm-occur" "Invoke `helm-occur' from isearch.

To use this bind it to a key in `isearch-mode-map'." t) (autoload 'helm-multi-occur-from-isearch "helm-occur" "Invoke `helm-multi-occur' from isearch.

With a prefix arg, reverse the behavior of
`helm-moccur-always-search-in-current'.
The prefix arg can be set before calling
`helm-multi-occur-from-isearch' or during the buffer selection.

To use this bind it to a key in `isearch-mode-map'." t) (register-definition-prefixes "helm-occur" '("helm-")) (autoload 'helm-packages "helm-packages" "Helm interface to manage packages.

With a prefix arg ARG refresh package list.

When installing or upgrading ensure to refresh the package list
to avoid errors with outdated packages no more availables.

(fn &optional ARG)" t) (autoload 'helm-finder "helm-packages" "Helm interface to find packages by keywords with `finder'.
To have more actions on packages, use `helm-packages'.

(fn &optional ARG)" t) (register-definition-prefixes "helm-packages" '("helm-")) (autoload 'helm-regexp "helm-regexp" "Preconfigured helm to build regexps.
`query-replace-regexp' can be run from there against found regexp." t) (register-definition-prefixes "helm-regexp" '("helm-")) (autoload 'helm-mark-ring "helm-ring" "Preconfigured `helm' for `helm-source-mark-ring'." t) (autoload 'helm-global-mark-ring "helm-ring" "Preconfigured `helm' for `helm-source-global-mark-ring'." t) (autoload 'helm-all-mark-rings "helm-ring" "Preconfigured `helm' for mark rings.
Source used are `helm-source-global-mark-ring' and
`helm-source-mark-ring'." t) (autoload 'helm-register "helm-ring" "Preconfigured `helm' for Emacs registers." t) (autoload 'helm-show-kill-ring "helm-ring" "Preconfigured `helm' for `kill-ring'.
It is drop-in replacement of `yank-pop'.

First call open the kill-ring browser, next calls move to next line." t) (autoload 'helm-execute-kmacro "helm-ring" "Preconfigured helm for keyboard macros.
Define your macros with `f3' and `f4'.
See (info \"(emacs) Keyboard Macros\") for detailed infos." t) (register-definition-prefixes "helm-ring" '("helm-")) (autoload 'helm-semantic "helm-semantic" "Preconfigured `helm' for `semantic'.
If ARG is supplied, pre-select symbol at point instead of current.

(fn ARG)" t) (autoload 'helm-semantic-or-imenu "helm-semantic" "Preconfigured helm for `semantic' or `imenu'.
If ARG is supplied, pre-select symbol at point instead of current
semantic tag in scope.

If `semantic-mode' is active in the current buffer, then use
semantic for generating tags, otherwise fall back to `imenu'.
Fill in the symbol at point by default.

(fn ARG)" t) (register-definition-prefixes "helm-semantic" '("helm-s")) (defvar helm-top-poll-mode nil "Non-nil if Helm-Top-Poll mode is enabled.
See the `helm-top-poll-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-top-poll-mode'.") (custom-autoload 'helm-top-poll-mode "helm-sys" nil) (autoload 'helm-top-poll-mode "helm-sys" "Refresh automatically helm top buffer once enabled.

This is a global minor mode.  If called interactively, toggle the
`Helm-Top-Poll mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-top-poll-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'helm-top "helm-sys" "Preconfigured `helm' for top command.
When prefix arg ARG is non nil toggle auto updating mode `helm-top-poll-mode'.

(fn &optional ARG)" t) (autoload 'helm-list-emacs-process "helm-sys" "Preconfigured `helm' for Emacs process." t) (autoload 'helm-xrandr-set "helm-sys" "Preconfigured helm for xrandr." t) (register-definition-prefixes "helm-sys" '("helm-")) (autoload 'helm-etags-select "helm-tags" "Preconfigured helm for etags.
If called with a prefix argument REINIT
or if any of the tag files have been modified, reinitialize cache.

This function aggregates three sources of tag files:

  1) An automatically located file in the parent directories,
     by `helm-etags-get-tag-file'.
  2) `tags-file-name', which is commonly set by `find-tag' command.
  3) `tags-table-list' which is commonly set by `visit-tags-table' command.

(fn REINIT)" t) (register-definition-prefixes "helm-tags" '("helm-")) (register-definition-prefixes "helm-types" '("helm-")) (defvar helm-popup-tip-mode nil "Non-nil if Helm-Popup-Tip mode is enabled.
See the `helm-popup-tip-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-popup-tip-mode'.") (custom-autoload 'helm-popup-tip-mode "helm-utils" nil) (autoload 'helm-popup-tip-mode "helm-utils" "Show additional informations in a popup tip at end of line.

When the mode is enabled, popup showup when the source
has a `popup-info' attribute which define a specific function for
this source to fetch infos on candidate.

This is a global minor mode.  If called interactively, toggle the
`Helm-Popup-Tip mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='helm-popup-tip-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (register-definition-prefixes "helm-utils" '("helm-" "with-helm-display-marked-candidates")) (register-definition-prefixes "helm-x-files" '("helm-")) (provide 'helm-autoloads)) "helm-ls-git" ((helm-ls-git-autoloads helm-ls-git) (add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG$" . helm-ls-git-commit-mode)) (add-to-list 'inhibit-local-variables-regexps "/COMMIT_EDITMSG$") (autoload 'helm-ls-git-commit-mode "helm-ls-git" "Mode to edit COMMIT_EDITMSG files.

Commands:
\\{helm-ls-git-commit-mode-map}

(fn)" t) (add-to-list 'auto-mode-alist '("/git-rebase-todo$" . helm-ls-git-rebase-todo-mode)) (add-to-list 'inhibit-local-variables-regexps "/git-rebase-todo$") (autoload 'helm-ls-git-rebase-todo-mode "helm-ls-git" "Major Mode to edit git-rebase-todo files when using git rebase -i.

Commands:
\\{helm-ls-git-rebase-todo-mode-map}

(fn)" t) (autoload 'helm-ls-git "helm-ls-git" "

(fn &optional ARG)" t) (register-definition-prefixes "helm-ls-git" '("helm-")) (provide 'helm-ls-git-autoloads)) "seq" ((seq-pkg seq-24 seq seq-25 seq-autoloads) (register-definition-prefixes "seq-24" '("seq")) (autoload 'seq-subseq "seq-25" "Return the sequence of elements of SEQUENCE from START to END.
END is exclusive.

If END is omitted, it defaults to the length of the sequence.  If
START or END is negative, it counts from the end.  Signal an
error if START or END are outside of the sequence (i.e too large
if positive or too small if negative).

(fn SEQUENCE START &optional END)") (autoload 'seq-take "seq-25" "Return the sequence made of the first N elements of SEQUENCE.
The result is a sequence of the same type as SEQUENCE.

If N is a negative integer or zero, an empty sequence is
returned.

(fn SEQUENCE N)") (autoload 'seq-sort-by "seq-25" "Sort SEQUENCE transformed by FUNCTION using PRED as the comparison function.
Elements of SEQUENCE are transformed by FUNCTION before being
sorted.  FUNCTION must be a function of one argument.

(fn FUNCTION PRED SEQUENCE)") (autoload 'seq-filter "seq-25" "Return a list of all the elements in SEQUENCE for which PRED returns non-nil.

(fn PRED SEQUENCE)") (autoload 'seq-remove "seq-25" "Return a list of all the elements in SEQUENCE for which PRED returns nil.

(fn PRED SEQUENCE)") (autoload 'seq-remove-at-position "seq-25" "Return a copy of SEQUENCE with the element at index N removed.

N is the (zero-based) index of the element that should not be in
the result.

The result is a sequence of the same type as SEQUENCE.

(fn SEQUENCE N)") (autoload 'seq-reduce "seq-25" "Reduce the function FUNCTION across SEQUENCE, starting with INITIAL-VALUE.

Return the result of calling FUNCTION with INITIAL-VALUE and the
first element of SEQUENCE, then calling FUNCTION with that result
and the second element of SEQUENCE, then with that result and the
third element of SEQUENCE, etc.  FUNCTION will be called with
INITIAL-VALUE (and then the accumulated value) as the first
argument, and the elements from SEQUENCE as the second argument.

If SEQUENCE is empty, return INITIAL-VALUE and FUNCTION is not called.

(fn FUNCTION SEQUENCE INITIAL-VALUE)") (autoload 'seq-every-p "seq-25" "Return non-nil if PRED returns non-nil for all the elements of SEQUENCE.

(fn PRED SEQUENCE)") (autoload 'seq-some "seq-25" "Return non-nil if PRED returns non-nil for at least one element of SEQUENCE.
If the value is non-nil, it is the first non-nil value returned by PRED.

(fn PRED SEQUENCE)") (autoload 'seq-find "seq-25" "Return the first element in SEQUENCE for which PRED returns non-nil.
If no such element is found, return DEFAULT.

Note that `seq-find' has an ambiguity if the found element is
identical to DEFAULT, as in that case it is impossible to know
whether an element was found or not.

(fn PRED SEQUENCE &optional DEFAULT)") (autoload 'seq-position "seq-25" "Return the (zero-based) index of the first element in SEQUENCE \"equal\" to ELT.
\"Equality\" is defined by the function TESTFN, which defaults to `equal'.

(fn SEQUENCE ELT &optional TESTFN)") (autoload 'seq-positions "seq-25" "Return list of indices of SEQUENCE elements for which TESTFN returns non-nil.

TESTFN is a two-argument function which is called with each element of
SEQUENCE as the first argument and ELT as the second.
TESTFN defaults to `equal'.

The result is a list of (zero-based) indices.

(fn SEQUENCE ELT &optional TESTFN)") (autoload 'seq-uniq "seq-25" "Return a list of the elements of SEQUENCE with duplicates removed.
TESTFN is used to compare elements, and defaults to `equal'.

(fn SEQUENCE &optional TESTFN)") (autoload 'seq-union "seq-25" "Return a list of all the elements that appear in either SEQUENCE1 or SEQUENCE2.
\"Equality\" of elements is defined by the function TESTFN, which
defaults to `equal'.

(fn SEQUENCE1 SEQUENCE2 &optional TESTFN)") (autoload 'seq-intersection "seq-25" "Return a list of all the elements that appear in both SEQUENCE1 and SEQUENCE2.
\"Equality\" of elements is defined by the function TESTFN, which
defaults to `equal'.

(fn SEQUENCE1 SEQUENCE2 &optional TESTFN)") (autoload 'seq-group-by "seq-25" "Apply FUNCTION to each element of SEQUENCE.
Separate the elements of SEQUENCE into an alist using the results as
keys.  Keys are compared using `equal'.

(fn FUNCTION SEQUENCE)") (autoload 'seq-max "seq-25" "Return the largest element of SEQUENCE.
SEQUENCE must be a sequence of numbers or markers.

(fn SEQUENCE)") (autoload 'seq-random-elt "seq-25" "Return a randomly chosen element from SEQUENCE.
Signal an error if SEQUENCE is empty.

(fn SEQUENCE)") (register-definition-prefixes "seq-25" '("seq-")) (provide 'seq-autoloads)) "compat" ((compat-27 compat-pkg compat-26 compat-29 compat-macs compat-28 compat compat-autoloads compat-25 compat-30) (register-definition-prefixes "compat" '("compat-")) (register-definition-prefixes "compat-macs" '("compat-")) (provide 'compat-autoloads)) "transient" ((transient transient-autoloads) (autoload 'transient-insert-suffix "transient" "Insert a SUFFIX into PREFIX before LOC.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
Remove a conflicting binding unless optional KEEP-OTHER is
  non-nil.
See info node `(transient)Modifying Existing Transients'.

(fn PREFIX LOC SUFFIX &optional KEEP-OTHER)") (function-put 'transient-insert-suffix 'lisp-indent-function 'defun) (autoload 'transient-append-suffix "transient" "Insert a SUFFIX into PREFIX after LOC.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
Remove a conflicting binding unless optional KEEP-OTHER is
  non-nil.
See info node `(transient)Modifying Existing Transients'.

(fn PREFIX LOC SUFFIX &optional KEEP-OTHER)") (function-put 'transient-append-suffix 'lisp-indent-function 'defun) (autoload 'transient-replace-suffix "transient" "Replace the suffix at LOC in PREFIX with SUFFIX.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

(fn PREFIX LOC SUFFIX)") (function-put 'transient-replace-suffix 'lisp-indent-function 'defun) (autoload 'transient-remove-suffix "transient" "Remove the suffix or group at LOC in PREFIX.
PREFIX is a prefix command, a symbol.
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

(fn PREFIX LOC)") (function-put 'transient-remove-suffix 'lisp-indent-function 'defun) (register-definition-prefixes "transient" '("find-function-advised-original" "transient")) (provide 'transient-autoloads)) "gptel" ((gptel-context gptel-openai gptel-ollama gptel-anthropic gptel-transient gptel-kagi gptel-rewrite gptel-privategpt gptel-curl gptel-autoloads gptel-gemini gptel gptel-org) (autoload 'gptel-mode "gptel" "Minor mode for interacting with LLMs.

This is a minor mode.  If called interactively, toggle the `GPTel
mode' mode.  If the prefix argument is positive, enable the mode,
and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `gptel-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'gptel-send "gptel" "Submit this prompt to the current LLM backend.

By default, the contents of the buffer up to the cursor position
are sent.  If the region is active, its contents are sent
instead.

The response from the LLM is inserted below the cursor position
at the time of sending.  To change this behavior or model
parameters, use prefix arg ARG activate a transient menu with
more options instead.

This command is asynchronous, you can continue to use Emacs while
waiting for the response.

(fn &optional ARG)" t) (autoload 'gptel "gptel" "Switch to or start a chat session with NAME.

Ask for API-KEY if `gptel-api-key' is unset.

If region is active, use it as the INITIAL prompt.  Returns the
buffer created or switched to.

INTERACTIVEP is t when gptel is called interactively.

(fn NAME &optional _ INITIAL INTERACTIVEP)" t) (register-definition-prefixes "gptel" '("gptel-")) (autoload 'gptel-make-anthropic "gptel-anthropic" "Register an Anthropic API-compatible backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST (optional) is the API host, \"api.anthropic.com\" by default.

MODELS is a list of available model names, as symbols.
Additionally, you can specify supported LLM capabilities like
vision or tool-use by appending a plist to the model with more
information, in the form

 (model-name . plist)

For a list of currently recognized plist keys, see
`gptel--anthropic-models'. An example of a model specification
including both kinds of specs:

:models
\\='(claude-3-haiku-20240307               ;Simple specs
  claude-3-opus-20240229
  (claude-3-5-sonnet-20240620           ;Full spec
   :description  \"Balance of intelligence and speed\"
   :capabilities (media tool json)
   :mime-types
   (\"image/jpeg\" \"image/png\" \"image/gif\" \"image/webp\")))

STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, https by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/v1/messages\".

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY is a variable whose value is the API key, or function that
returns the key.

(fn NAME &key CURL-ARGS STREAM KEY (HEADER (lambda nil (when-let (key (gptel--get-api-key)) \\=`((\"x-api-key\" \\=\\, key) (\"anthropic-version\" . \"2023-06-01\"))))) (MODELS gptel--anthropic-models) (HOST \"api.anthropic.com\") (PROTOCOL \"https\") (ENDPOINT \"/v1/messages\"))") (function-put 'gptel-make-anthropic 'lisp-indent-function 1) (register-definition-prefixes "gptel-anthropic" '("gptel--anthropic-")) (autoload 'gptel-add "gptel-context" "Add/remove regions or buffers from gptel's context." t) (autoload 'gptel-add-file "gptel-context" "Add files to gptel's context." t) (autoload 'gptel-context--wrap "gptel-context" "Wrap MESSAGE with context string.

(fn MESSAGE)") (autoload 'gptel-context--collect "gptel-context" "Get the list of all active context overlays.") (register-definition-prefixes "gptel-context" '("gptel-")) (autoload 'gptel-curl-get-response "gptel-curl" "Retrieve response to prompt in INFO.

INFO is a plist with the following keys:
- :data (the data being sent)
- :buffer (the gptel buffer)
- :position (marker at which to insert the response).

Call CALLBACK with the response and INFO afterwards.  If omitted
the response is inserted into the current buffer after point.

(fn INFO &optional CALLBACK)") (register-definition-prefixes "gptel-curl" '("gptel-")) (autoload 'gptel-make-gemini "gptel-gemini" "Register a Gemini backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST (optional) is the API host, defaults to
\"generativelanguage.googleapis.com\".

MODELS is a list of available model names, as symbols.
Additionally, you can specify supported LLM capabilities like
vision or tool-use by appending a plist to the model with more
information, in the form

 (model-name . plist)

For a list of currently recognized plist keys, see
`gptel--gemini-models'. An example of a model specification
including both kinds of specs:

:models
\\='(gemini-pro                            ;Simple specs
  gemini-1.5-flash
  (gemini-1.5-pro-latest                ;Full spec
   :description
   \"Complex reasoning tasks, problem solving and data extraction\"
   :capabilities (tool json)
   :mime-types
   (\"image/jpeg\" \"image/png\" \"image/webp\" \"image/heic\")))


STREAM is a boolean to enable streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, \"https\" by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/v1beta/models\".

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key.

(fn NAME &key CURL-ARGS HEADER KEY (STREAM nil) (HOST \"generativelanguage.googleapis.com\") (PROTOCOL \"https\") (MODELS gptel--gemini-models) (ENDPOINT \"/v1beta/models\"))") (function-put 'gptel-make-gemini 'lisp-indent-function 1) (register-definition-prefixes "gptel-gemini" '("gptel--gemini-")) (autoload 'gptel-make-kagi "gptel-kagi" "Register a Kagi FastGPT backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST is the Kagi host (with port), defaults to \"kagi.com\".

MODELS is a list of available Kagi models: only fastgpt is supported.

STREAM is a boolean to toggle streaming responses, defaults to
false.  Kagi does not support a streaming API yet.

PROTOCOL (optional) specifies the protocol, https by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/api/v0/fastgpt\".

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key.

Example:
-------

 (gptel-make-kagi \"Kagi\" :key my-kagi-key)

(fn NAME &key CURL-ARGS STREAM KEY (HOST \"kagi.com\") (HEADER (lambda nil \\=`((\"Authorization\" \\=\\, (concat \"Bot \" (gptel--get-api-key)))))) (MODELS \\='(fastgpt summarize:cecil summarize:agnes summarize:daphne summarize:muriel)) (PROTOCOL \"https\") (ENDPOINT \"/api/v0/\"))") (function-put 'gptel-make-kagi 'lisp-indent-function 1) (autoload 'gptel-make-ollama "gptel-ollama" "Register an Ollama backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST is where Ollama runs (with port), defaults to localhost:11434

MODELS is a list of available model names, as symbols.
Additionally, you can specify supported LLM capabilities like
vision or tool-use by appending a plist to the model with more
information, in the form

 (model-name . plist)

Currently recognized plist keys are :description, :capabilities
and :mime-types.  An example of a model specification including
both kinds of specs:

:models
\\='(mistral:latest                        ;Simple specs
  openhermes:latest
  (llava:13b                            ;Full spec
   :description
   \"Llava 1.6: Large Lanuage and Vision Assistant\"
   :capabilities (media)
   :mime-types (\"image/jpeg\" \"image/png\")))


STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, http by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/api/generate\".

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key.  This is typically not required
for local models like Ollama.

Example:
-------

 (gptel-make-ollama
   \"Ollama\"
   :host \"localhost:11434\"
   :models \\='(\"mistral:latest\")
   :stream t)

(fn NAME &key CURL-ARGS HEADER KEY MODELS STREAM (HOST \"localhost:11434\") (PROTOCOL \"http\") (ENDPOINT \"/api/chat\"))") (function-put 'gptel-make-ollama 'lisp-indent-function 1) (register-definition-prefixes "gptel-ollama" '("gptel--ollama-")) (autoload 'gptel-make-openai "gptel-openai" "Register an OpenAI API-compatible backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST (optional) is the API host, typically \"api.openai.com\".

MODELS is a list of available model names, as symbols.
Additionally, you can specify supported LLM capabilities like
vision or tool-use by appending a plist to the model with more
information, in the form

 (model-name . plist)

For a list of currently recognized plist keys, see
`gptel--openai-models'. An example of a model specification
including both kinds of specs:

:models
\\='(gpt-3.5-turbo                         ;Simple specs
  gpt-4-turbo
  (gpt-4o-mini                          ;Full spec
   :description
   \"Affordable and intelligent small model for lightweight tasks\"
   :capabilities (media tool json url)
   :mime-types
   (\"image/jpeg\" \"image/png\" \"image/gif\" \"image/webp\")))

STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, https by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/v1/chat/completions\".

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key.

(fn NAME &key CURL-ARGS MODELS STREAM KEY (HEADER (lambda nil (when-let (key (gptel--get-api-key)) \\=`((\"Authorization\" \\=\\, (concat \"Bearer \" key)))))) (HOST \"api.openai.com\") (PROTOCOL \"https\") (ENDPOINT \"/v1/chat/completions\"))") (function-put 'gptel-make-openai 'lisp-indent-function 1) (autoload 'gptel-make-azure "gptel-openai" "Register an Azure backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST is the API host.

MODELS is a list of available model names.

STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, https by default.

ENDPOINT is the API endpoint for completions.

HEADER (optional) is for additional headers to send with each
request.  It should be an alist or a function that retuns an
alist, like:
 ((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key.

Example:
-------

 (gptel-make-azure
  \"Azure-1\"
  :protocol \"https\"
  :host \"RESOURCE_NAME.openai.azure.com\"
  :endpoint
  \"/openai/deployments/DEPLOYMENT_NAME/completions?api-version=2023-05-15\"
  :stream t
  :models \\='(\"gpt-3.5-turbo\" \"gpt-4\"))

(fn NAME &key CURL-ARGS HOST (PROTOCOL \"https\") (HEADER (lambda nil \\=`((\"api-key\" \\=\\, (gptel--get-api-key))))) (KEY \\='gptel-api-key) MODELS STREAM ENDPOINT)") (function-put 'gptel-make-azure 'lisp-indent-function 1) (defalias 'gptel-make-gpt4all 'gptel-make-openai "Register a GPT4All backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST is where GPT4All runs (with port), typically localhost:8491

MODELS is a list of available model names.

STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL specifies the protocol, https by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/api/v1/completions\"

HEADER (optional) is for additional headers to send with each
request. It should be an alist or a function that retuns an
alist, like:
((\"Content-Type\" . \"application/json\"))

KEY (optional) is a variable whose value is the API key, or
function that returns the key. This is typically not required for
local models like GPT4All.

Example:
-------

(gptel-make-gpt4all
 \"GPT4All\"
 :protocol \"http\"
 :host \"localhost:4891\"
 :models \\='(\"mistral-7b-openorca.Q4_0.gguf\"))") (register-definition-prefixes "gptel-openai" '("gptel--")) (register-definition-prefixes "gptel-org" '("gptel-")) (autoload 'gptel-make-privategpt "gptel-privategpt" "Register an Privategpt API-compatible backend for gptel with NAME.

Keyword arguments:

CURL-ARGS (optional) is a list of additional Curl arguments.

HOST (optional) is the API host, \"api.privategpt.com\" by default.

MODELS is a list of available model names.

STREAM is a boolean to toggle streaming responses, defaults to
false.

PROTOCOL (optional) specifies the protocol, https by default.

ENDPOINT (optional) is the API endpoint for completions, defaults to
\"/v1/messages\".

HEADER (optional) is for additional headers to send with each
request. It should be an alist or a function that retuns an
alist, like:
((\"Content-Type\" . \"application/json\"))

KEY is a variable whose value is the API key, or function that
returns the key.

CONTEXT and SOURCES: if true (the default), use available context
and provide sources used by the model to generate the response.

(fn NAME &key CURL-ARGS STREAM KEY (HEADER (lambda nil (when-let (key (gptel--get-api-key)) \\=`((\"Authorization\" \\=\\, (concat \"Bearer \" key)))))) (HOST \"localhost:8001\") (PROTOCOL \"http\") (MODELS \\='(private-gpt)) (ENDPOINT \"/v1/chat/completions\") (CONTEXT t) (SOURCES t))") (function-put 'gptel-make-privategpt 'lisp-indent-function 1) (register-definition-prefixes "gptel-privategpt" '("gptel--privategpt-parse-sources")) (autoload 'gptel-rewrite-menu "gptel-rewrite" nil t) (register-definition-prefixes "gptel-rewrite" '("gptel-")) (autoload 'gptel-menu "gptel-transient" nil t) (autoload 'gptel-system-prompt "gptel-transient" nil t) (register-definition-prefixes "gptel-transient" '("gptel-")) (provide 'gptel-autoloads)) "monroe" ((monroe-autoloads monroe) (autoload 'monroe-interaction-mode "monroe" "Minor mode for Monroe interaction from a Clojure buffer.

The following keys are available in `monroe-interaction-mode`:

  \\{monroe-interaction-mode}

This is a minor mode.  If called interactively, toggle the
`Monroe-Interaction mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `monroe-interaction-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'monroe "monroe" "Load monroe by setting up appropriate mode, asking user for
connection endpoint.

(fn HOST-AND-PORT)" t) (register-definition-prefixes "monroe" '("clojure-enable-monroe" "monroe-")) (provide 'monroe-autoloads)) "clojure-mode" ((clojure-mode-autoloads clojure-mode) (autoload 'clojure-mode "clojure-mode" "Major mode for editing Clojure code.

\\{clojure-mode-map}

(fn)" t) (autoload 'clojure-unwind "clojure-mode" "Unwind thread at point or above point by N levels.
With universal argument \\[universal-argument], fully unwind thread.

(fn &optional N)" t) (autoload 'clojure-unwind-all "clojure-mode" "Fully unwind thread at point or above point." t) (autoload 'clojure-thread "clojure-mode" "Thread by one more level an existing threading macro." t) (autoload 'clojure-thread-first-all "clojure-mode" "Fully thread the form at point using ->.

When BUT-LAST is non-nil, the last expression is not threaded.
Default value is `clojure-thread-all-but-last'.

(fn BUT-LAST)" t) (autoload 'clojure-thread-last-all "clojure-mode" "Fully thread the form at point using ->>.

When BUT-LAST is non-nil, the last expression is not threaded.
Default value is `clojure-thread-all-but-last'.

(fn BUT-LAST)" t) (autoload 'clojure-cycle-privacy "clojure-mode" "Make public the current private def, or vice-versa.
See: https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-cycle-privacy" t) (autoload 'clojure-convert-collection-to-list "clojure-mode" "Convert collection at (point) to list." t) (autoload 'clojure-convert-collection-to-quoted-list "clojure-mode" "Convert collection at (point) to quoted list." t) (autoload 'clojure-convert-collection-to-map "clojure-mode" "Convert collection at (point) to map." t) (autoload 'clojure-convert-collection-to-vector "clojure-mode" "Convert collection at (point) to vector." t) (autoload 'clojure-convert-collection-to-set "clojure-mode" "Convert collection at (point) to set." t) (autoload 'clojure-cycle-if "clojure-mode" "Change a surrounding if to if-not, or vice-versa.

See: https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-cycle-if" t) (autoload 'clojure-cycle-when "clojure-mode" "Change a surrounding when to when-not, or vice-versa." t) (autoload 'clojure-let-backward-slurp-sexp "clojure-mode" "Slurp the s-expression before the let form into the let form.
With a numeric prefix argument slurp the previous N s-expressions
into the let form.

(fn &optional N)" t) (autoload 'clojure-let-forward-slurp-sexp "clojure-mode" "Slurp the next s-expression after the let form into the let form.
With a numeric prefix argument slurp the next N s-expressions
into the let form.

(fn &optional N)" t) (autoload 'clojure-introduce-let "clojure-mode" "Create a let form, binding the form at point.
With a numeric prefix argument the let is introduced N lists up.

(fn &optional N)" t) (autoload 'clojure-move-to-let "clojure-mode" "Move the form at point to a binding in the nearest let." t) (autoload 'clojure-rename-ns-alias "clojure-mode" "Rename a namespace alias.
If a region is active, only pick up and rename aliases within the region." t) (autoload 'clojure-add-arity "clojure-mode" "Add an arity to a function." t) (autoload 'clojurescript-mode "clojure-mode" "Major mode for editing ClojureScript code.

\\{clojurescript-mode-map}

(fn)" t) (autoload 'clojurec-mode "clojure-mode" "Major mode for editing ClojureC code.

\\{clojurec-mode-map}

(fn)" t) (add-to-list 'auto-mode-alist '("\\.\\(clj\\|cljd\\|dtm\\|edn\\|lpy\\)\\'" . clojure-mode)) (add-to-list 'auto-mode-alist '("\\.cljc\\'" . clojurec-mode)) (add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojurescript-mode)) (add-to-list 'auto-mode-alist '("\\(?:build\\|profile\\)\\.boot\\'" . clojure-mode)) (add-to-list 'interpreter-mode-alist '("bb" . clojure-mode)) (add-to-list 'interpreter-mode-alist '("nbb" . clojurescript-mode)) (register-definition-prefixes "clojure-mode" '(";;" "add-custom-clojure-indents" "clojure" "define-clojure-indent" "put-clojure-indent")) (provide 'clojure-mode-autoloads)) "rail" ((rail-autoloads rail-bencode rail) (autoload 'rail-interaction-mode "rail" "Minor mode for Rail interaction from a buffer.

The following keys are available in `rail-interaction-mode`:

  \\{rail-interaction-mode}

This is a minor mode.  If called interactively, toggle the
`Rail-Interaction mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `rail-interaction-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t) (autoload 'rail "rail" "Load rail by setting up appropriate mode, asking user for
connection endpoint(HOST-AND-PORT).

(fn HOST-AND-PORT)" t) (register-definition-prefixes "rail" '("rail-")) (register-definition-prefixes "rail-bencode" '("rail-bencode")) (provide 'rail-autoloads))))

#s(hash-table size 65 test eq rehash-size 1.5 rehash-threshold 0.8125 data (org-elpa #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 15 "melpa" nil "gnu-elpa-mirror" nil "nongnu-elpa" nil "el-get" nil "emacsmirror-mirror" nil "straight" nil "helm" nil "helm-core" nil "async" nil "wfnames" nil "helm-ls-git" nil "gptel" nil "transient" nil "compat" nil "seq" nil "monroe" nil "clojure-mode" nil "rail" nil)) melpa #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 2 "gnu-elpa-mirror" nil "nongnu-elpa" nil "el-get" (el-get :type git :flavor melpa :files (:defaults "methods" ("recipes" "recipes/el-get.rcp") "el-get-pkg.el") :host github :repo "dimitri/el-get") "emacsmirror-mirror" nil "straight" nil "helm" (helm :type git :flavor melpa :files (:defaults "emacs-helm.sh" (:exclude "helm-lib.el" "helm-source.el" "helm-multi-match.el" "helm-core.el") "helm-pkg.el") :host github :repo "emacs-helm/helm") "helm-core" (helm-core :type git :flavor melpa :files ("helm-core.el" "helm-lib.el" "helm-source.el" "helm-multi-match.el" "helm-core-pkg.el") :host github :repo "emacs-helm/helm") "async" (async :type git :flavor melpa :host github :repo "jwiegley/emacs-async") "wfnames" (wfnames :type git :flavor melpa :host github :repo "thierryvolpiatto/wfnames") "helm-ls-git" (helm-ls-git :type git :flavor melpa :host github :repo "emacs-helm/helm-ls-git") "gptel" (gptel :type git :flavor melpa :host github :repo "karthink/gptel") "transient" (transient :type git :flavor melpa :host github :repo "magit/transient") "compat" nil "seq" nil "monroe" (monroe :type git :flavor melpa :host github :repo "sanel/monroe") "clojure-mode" (clojure-mode :type git :flavor melpa :files ("clojure-mode.el" "clojure-mode-pkg.el") :host github :repo "clojure-emacs/clojure-mode") "rail" nil)) gnu-elpa-mirror #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 3 "nongnu-elpa" nil "emacsmirror-mirror" nil "straight" nil "compat" (compat :type git :host github :repo "emacs-straight/compat" :files ("*" (:exclude ".git"))) "seq" (seq :type git :host github :repo "emacs-straight/seq" :files ("*" (:exclude ".git"))) "rail" nil)) nongnu-elpa #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 4 "emacsmirror-mirror" nil "straight" nil "rail" nil)) el-get #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 2 "emacsmirror-mirror" nil "straight" nil "rail" nil)) emacsmirror-mirror #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8125 data (version 2 "straight" (straight :type git :host github :repo "emacsmirror/straight") "rail" nil))))

("monroe" "helm-ls-git" "seq" "compat" "transient" "gptel" "wfnames" "async" "helm-core" "helm" "clojure-mode" "emacs" "straight" "emacsmirror-mirror" "el-get" "nongnu-elpa" "gnu-elpa-mirror" "melpa" "org-elpa")

t
