;; --- Maciek's (GNU) Emacs config ---

;; We will measure startup time.
(defvar *emacs-load-start* (current-time))

;; This must come before configurations of installed packages.
(require 'package)
(package-initialize)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and
  ;; MELPA Stable as desired
  (add-to-list 'package-archives
	       (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives
  ;;           (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives
		 (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

;; Customizations are kept in separate file.
;; load first as they may contain dependencies (e.g., "safe themes" settings).
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file 'noerror)

;; load various initializations
(load-file "~/emacs/init-settings.el")
(load-file "~/emacs/init-completion.el")
(load-file "~/emacs/init-org.el")
(load-file "~/emacs/init-misc.el")
(load-file "~/emacs/init-looks.el")
(load-file "~/emacs/init-themes.el")

;; OS-specific initializations
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (load-file "~/emacs/init-w32.el")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (load-file "~/emacs/init-osx.el"))))

;; various fixes for broken features
(load-file "~/emacs/init-fixes.el")

;; personal key bindings
(global-set-key "\C-c\C-b" 'bury-buffer)
(global-set-key "\C-c\C-\M-b" 'bury-buffer)
(global-set-key "\C-xg" 'magit-status)

;; Ask for confirmation before quitting Emacs.
(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p "Do you really want to exit Emacs? "))
          'append)

;; Allows 'emacsclient' to connect to already running Emacs.
(server-start)

;; This should be penultimate, just before the "disables".
(require 'cl-macs)
(message "init.el loaded in %.1fs"
	 (cl-destructuring-bind (hi lo usec psec) (current-time)
	   (- (+ hi lo) (+ (nth 0 *emacs-load-start*)
			   (nth 1 *emacs-load-start*)))))

;; These Emacs-added "disables" ideally should be last.
(put 'narrow-to-region 'disabled nil)

