;;;; appearance-related init

;; lose the UI.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(width . 120))

;; Show boundary where words will wrap.
(require 'fill-column-indicator)
(fci-mode)
(setq fill-column 80)
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (setq fill-column 78)
	    (fci-mode 1)
	    ))

(setq inhibit-startup-message t)
