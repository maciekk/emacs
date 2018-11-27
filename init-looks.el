;;;; appearance-related init

;; lose the UI.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(width . 120))

(setq inhibit-startup-message t)
