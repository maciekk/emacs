;; Source: https://bitbucket.org/phromo/w32-fullscreen/src/tip/w32-fullscreen.el
;; THIS NO LONGER WORKS? THERE MIGHT BE BETTER OPTIONS IN 2018.

;; (add-to-list 'load-path "~/emacs/site-lisp")
;; (require 'w32-fullscreen)
;; (global-set-key "\C-cf" 'w32-fullscreen)

;; (setq w32-fullscreen-toggletitle-cmd "~/emacs/site-lisp/w32toggletitle.exe")

;; On Windows, Org Mode scrolls really slowly; this fixes it. (excessive garbage collection)
;; Source of fix:
;;   https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/d8cmm7v/
(setq gc-cons-threshold (* 511 1024 1024))
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 5 t #'garbage-collect)
(setq garbage-collection-messages t)
