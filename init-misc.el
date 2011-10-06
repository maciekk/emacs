;; init for miscellaneous libraries

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome.exe")
(require 'google-chrome)

(autoload 'pomodoro "pomodoro.el")

;; better "same name" buffer disambiguation
;; (i.e., instead of "foobar<2>", "foobar<3>"
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(require 'darkroom-mode)
(setq darkroom-mode-face-foreground "gray50")