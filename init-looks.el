;; appearance-related init

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t)

;; Site where you can preview themes:
;;   https://pawelbx.github.io/emacs-theme-gallery/

;; colour and theme initialization
(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp/color-theme"))
;(require 'color-theme)
;(require 'zenburn)
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-initialize)
;     (color-theme-midnight)
;     ;(color-theme-zenburn)
;))

;; NOTE: this should be only for Windows.
;; Requires download of font pack from:
;;   http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=17879
;; Idea from:
;;  http://oscarbonilla.com/2008/01/beautiful-emacs-windows-edition/
;(set-default-font
; "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")

(load-theme 'twilight-bright t)
