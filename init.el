;; Lose the UI.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t)

(setq default-directory "c:/Users/Maciek/")
(setq backup-directory-alist
      `((".*" . "~/bak")))
(setq auto-save-file-name-transforms
      `((".*" "~/bak/\\1" t)))

;; key bindings
(global-set-key "\C-cb" 'bury-buffer)

(load-file "~/emacs/init-color.el")
(load-file "~/emacs/init-ido.el")
;(load-file "~/emacs/init-icicles.el")
(load-file "~/emacs/init-org.el")
(load-file "~/emacs/init-w32.el")

;; ideas from http://www.youtube.com/watch?v=a-jRN_ba41w
(fset 'yes-or-no-p 'y-or-n-p)
(setq line-number-mode t)
(setq column-number-mode t)
(show-paren-mode t)

(server-start)
