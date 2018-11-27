;; Configuration for 'ido'
;;
;; Interesting intro to IDO:
;;  http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)

;; NOTE: flex matching algo has some undesirable traits; see following
;; link for more info, and improved algo:
;;  http://scottfrazersblog.blogspot.com/2009/12/emacs-better-ido-flex-matching.html

;; TODO: try out grid mode
;; https://github.com/larkery/ido-grid-mode.el

;; Config for 'smex'; like 'ido', but for M-x commands.
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Config for 'ivy'
;; 
;; (require 'ivy)
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; Config for 'helm'
;; 
;; (require 'helm-config)
