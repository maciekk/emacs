;; Configuration for ido.el
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)

;; NOTE: flex matching algo has some undesirable traits; see following
;; link for more info, and improved algo:
;;  http://scottfrazersblog.blogspot.com/2009/12/emacs-better-ido-flex-matching.html

;; Interesting intro to IDO:
;;  http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
