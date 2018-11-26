;; --- my (GNU) Emacs config ---

;; used for timing

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar *emacs-load-start* (current-time))

(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp"))

;; set the command key for MacBook Pro
;; TODO: should we gate this with a check for OS X?
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; load various initializations
(load-file "~/emacs/init-looks.el")
(load-file "~/emacs/init-settings.el")
(load-file "~/emacs/init-ido.el")
(load-file "~/emacs/init-org.el")
;; TODO: look into fixing the following load:
;(load-file "~/emacs/init-smex.el")
(load-file "~/emacs/init-misc.el")

;; various fixes for broken features
(load-file "~/emacs/init-fixes.el")

;; things I no longer use
;(load-file "~/emacs/init-icicles.el")

;; personal key bindings
(global-set-key "\C-c\C-b" 'bury-buffer)
(global-set-key "\C-c\C-\M-b" 'bury-buffer)


;; keep customizations separate
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file 'noerror)

;; Ask for confirmation before quitting Emacs
(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p "Do you really want to exit Emacs? "))
          'append)

;; allows 'emacsclient' to connect to already running Emacs
(server-start)

;; This should be last thing in file.
;; TODO: fix below
;(message "init.el loaded in %.1fs"
;	 (destructuring-bind (hi lo ms) (current-time)
;	   (- (+ hi lo) (+ (first *emacs-load-start*)
;			   (second *emacs-load-start*)))))
(put 'narrow-to-region 'disabled nil)

;; TODO: only for OSX though?
(global-set-key (kbd "M-`") `other-frame)
