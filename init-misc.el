;; init for miscellaneous libraries

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
(global-set-key [(control meta return)] `darkroom-mode)
