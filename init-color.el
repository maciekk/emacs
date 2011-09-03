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