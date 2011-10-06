;; --- my (GNU) Emacs config ---

;; used for timing
(defvar *emacs-load-start* (current-time))

(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp"))

;; load various initializations
(load-file "~/emacs/init-looks.el")
(load-file "~/emacs/init-settings.el")
(load-file "~/emacs/init-ido.el")
(load-file "~/emacs/init-org.el")
(load-file "~/emacs/init-smex.el")
(load-file "~/emacs/init-w32.el")
(load-file "~/emacs/init-misc.el")

;; various fixes for broken features
(load-file "~/emacs/init-fixes.el")

;; things I no longer use
;(load-file "~/emacs/init-icicles.el")

;; personal key bindings
(global-set-key "\C-cb" 'bury-buffer)


;; keep customizations separate
(setq custom-file "~/.emacsd/customizations.el")
(load custom-file 'noerror)

;; Ask for confirmation before quitting Emacs
(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p "Do you really want to exit Emacs? "))
          'append)

;; allows 'emacsclient' to connect to already running Emacs
(server-start)

;; This should be last thing in file.
(message "init.el loaded in %.1fs"
	 (destructuring-bind (hi lo ms) (current-time)
	   (- (+ hi lo) (+ (first *emacs-load-start*)
			   (second *emacs-load-start*)))))
