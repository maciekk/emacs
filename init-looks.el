;; appearance-related init

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t)

;; colour and theme initialization
(require 'color-theme)
(require 'zenburn)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-zenburn)
))

;; other themes that I like:
;;  (color-theme-midnight)