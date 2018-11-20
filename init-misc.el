;; init for miscellaneous libraries

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome.exe")
;; TODO: fix
;(require 'google-chrome)

(autoload 'pomodoro "pomodoro.el")

;; better "same name" buffer disambiguation
;; (i.e., instead of "foobar<2>", "foobar<3>"
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; TODO: fix
;(require 'darkroom-mode)
;(setq darkroom-mode-face-foreground "gray50")

(require 'package)
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
