;;;; appearance-related init

;; lose the UI.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t)

;;;; colour and theme initialization

(load-theme 'leuven t)

;; (cond
;;  ((string-equal system-type "windows-nt") ; Microsoft Windows
;;   (progn
;;     ;; Requires download of font pack from:
;;     ;;   http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=17879
;;     ;; Idea from:
;;     ;;  http://oscarbonilla.com/2008/01/beautiful-emacs-windows-edition/
;;     (set-default-font
;;      "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1"))))
