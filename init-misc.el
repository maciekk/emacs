;; init for miscellaneous libraries

;; magit fix; see:
;; https://emacs.stackexchange.com/questions/32055/not-inside-a-git-repository
(use-package exec-path-from-shell
   :if (memq window-system '(mac ns))
   :ensure t
   :config
   (exec-path-from-shell-initialize))


(autoload 'pomodoro "pomodoro.el")

;; better "same name" buffer disambiguation
;; (i.e., instead of "foobar<2>", "foobar<3>"
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(require 'darkroom)
(defun my-darkroom-mode ()
  (interactive)
  ;; TODO: I can't get these two to reliably work in tandem yet.
  ;;(toggle-frame-fullscreen)
  (darkroom-mode)	; switch to darkroom-tentative-mode
)
;(global-set-key [(control meta return)] `darkroom-mode)

;; newsticker config
(setq newsticker-url-list
      '(("irreal" "http://irreal.org/blog/?feed=rss2" nil 3600 nil)
	))

;; elfeed config
(setq shr-width 80) ; text width of content pane

;; for moving windows
(require 'buffer-move)

(require 'sublimity)
(require 'sublimity-scroll)
;;(require 'sublimity-map)  ; distracting
(require 'sublimity-attractive)

;; turn on Powerline-like modeline
(telephone-line-mode 1)
