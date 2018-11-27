;; general & miscellaneous settings
;; This is a catch-all bin for (setq ...)s.

;; TODO: generalize this to be usable across home/work
;(setq default-directory "c:/Users/Maciek/")

;; ideas from http://www.youtube.com/watch?v=a-jRN_ba41w
(fset 'yes-or-no-p 'y-or-n-p)
(setq line-number-mode t)
(setq column-number-mode t)
(show-paren-mode t)

(setq backup-directory-alist
      `((".*" . "~/bak")))
(setq auto-save-file-name-transforms
      `((".*" "~/bak/\\1" t)))

(setq calendar-week-start-day 1)

;;(desktop-save-mode 1)
