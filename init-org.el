(require 'org-install)

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Patterned on:
;;  http://doc.norang.ca/org-mode.html
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)"))))

(setq org-tag-alist
      '(
	("desk" . ?d)
	("work" . ?w)
	("garden" . ?g)
	("errands" . ?e)
	("basement" . ?b)
	("kitchen" . ?k)
	))

(custom-set-variables
 '(org-agenda-files (quote ("~/org/gtd.org"))))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;(global-set-key "\C-cb" 'org-iswitchb)

(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-use-speed-commands t)
(setq org-completion-use-ido t)
(setq org-return-follows-link t)
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))
(setq org-startup-folded 'content)
(setq org-special-ctrl-a t)
(setq org-special-ctrl-e t)
(setq org-special-ctrl-k t)
(setq org-agenda-span 3)
(setq org-agenda-start-on-weekday nil)

(setq org-refile-targets (quote (("gtd.org" :maxlevel . 1) ("someday.org" :level . 2))))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
	 "* TODO %?\n  %i")
	("T" "Todo w/context" entry (file+headline "~/org/notes.org" "Tasks")
	 "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %?\nEntered on %U\n  %i")))

;(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cr" 'org-capture)

