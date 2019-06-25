;; Use hippie-expand instead of default dabbrev-expand.
;; Potentially useful config options to try:
;;   http://trey-jackson.blogspot.com/2007/12/emacs-tip-5-hippie-expand.html
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-complete-file-name-partially try-complete-file-name
					 try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
					 try-expand-all-abbrevs try-expand-list try-expand-line
					 try-complete-lisp-symbol-partially try-complete-lisp-symbol))

;; Configuration for 'ido'
;;
;; Interesting intro to IDO:
;;  http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;;
;; DISABLED because using helm.
;; (ido-mode 1)
;; (ido-grid-mode)
;; (setq ido-everywhere t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-filename-at-point 'guess)
;; (setq ido-create-new-buffer 'always)

;; NOTE: flex matching algo has some undesirable traits; see following
;; link for more info, and improved algo:
;;  http://scottfrazersblog.blogspot.com/2009/12/emacs-better-ido-flex-matching.html

;; Config for 'smex'; like 'ido', but for M-x commands.
;; (require 'smex)
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Config for 'ivy'
;; 
;; (require 'ivy)
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")
;; ;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key "\C-s" 'swiper)

;; Config for 'helm'
;; 
(require 'helm-config)
(require 'helm-smex)
(helm-mode)
(global-set-key [remap execute-extended-command] #'helm-smex)
(global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
;(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
;(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;(global-set-key (kbd "M-B") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)

(setq
 ; do not display invisible candidates
 ;helm-quick-update                     t
 ; open helm buffer inside current window, not occupy whole other window
 ;helm-split-window-in-side-p           t
 ; fuzzy matching buffer names when non--nil
 helm-buffers-fuzzy-matching           t
 ; move to end or beginning of source when reaching top or bottom of source.
 ;helm-move-to-line-cycle-in-source     t
 ; search for library in `require' and `declare-function' sexp.
 ;helm-ff-search-library-in-sexp        t
 ; scroll 8 lines other window using M-<next>/M-<prior>
 helm-scroll-amount                    8
 helm-ff-file-name-history-use-recentf t
 helm-candidate-number-limit 200)
