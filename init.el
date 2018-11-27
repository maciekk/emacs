;; --- my (GNU) Emacs config ---

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; We will measure startup time.
(defvar *emacs-load-start* (current-time))

;; Customizations are kept in separate file.
;; load first as they may contain dependencies (e.g., "safe themes" settings).
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file 'noerror)

;; TODO: only add this if path exists.
(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp"))

;; load various initializations
(load-file "~/emacs/init-settings.el")
(load-file "~/emacs/init-ido.el")
(load-file "~/emacs/init-org.el")
(load-file "~/emacs/init-smex.el")
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

;; things I no longer use
;(load-file "~/emacs/init-icicles.el")

;; personal key bindings
(global-set-key "\C-c\C-b" 'bury-buffer)
(global-set-key "\C-c\C-\M-b" 'bury-buffer)

;; Ask for confirmation before quitting Emacs
(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p "Do you really want to exit Emacs? "))
          'append)

;; allows 'emacsclient' to connect to already running Emacs
(server-start)

(put 'narrow-to-region 'disabled nil)

;; TODO: only for OSX though?
(global-set-key (kbd "M-`") `other-frame)

;; also OSX change
;; context: https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;; This should be last thing in file.
(require 'cl-macs)
(message "init.el loaded in %.1fs"
	 (cl-destructuring-bind (hi lo usec psec) (current-time)
;; also OSX change
;; context: https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))
	   (- (+ hi lo) (+ (nth 0 *emacs-load-start*)
			   (nth 1 *emacs-load-start*)))))
