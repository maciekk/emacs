;; Set the Command key for my MacBook Pros.
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Correct for us stealing Cmd key from Cmd-~.
(global-set-key (kbd "M-`") `other-frame)

;; Fix a nuissance error.
;; context: https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))
