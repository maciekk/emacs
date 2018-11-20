(require 'org-install)

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Patterned on:
;;  http://doc.norang.ca/org-mode.html
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(z)" "|" "DONE(d!/!)" "CANCELLED(c@/!)"))))

(setq org-tag-alist
      '(
	("desk" . ?d)
	("work" . ?w)
	("garden" . ?g)
	("errands" . ?e)
	("basement" . ?b)
	("kitchen" . ?k)
	("Net" . ?n)
	("leisure" . ?l)
	))

(custom-set-variables
 '(org-agenda-files (quote ("~/org/gtd.org"))))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;(global-set-key "\C-cb" 'org-iswitchb)

; TODO: why does Emacs complain about this now?
; (Symbol's function definition is void: org-remember-insinuate)
;(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-use-speed-commands t)
(setq org-completion-use-ido t)
(setq org-return-follows-link t)
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))
(setq org-startup-folded 'content)
(setq org-special-ctrl-a t)
(setq org-special-ctrl-e t)
(setq org-special-ctrl-k nil)
(setq org-agenda-span 3)
(setq org-agenda-start-on-weekday nil)

(setq org-refile-targets (quote (("gtd.org" :maxlevel . 1) ("someday.org" :level . 2))))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
	 "* TODO %?\n  %i")
	("T" "Todo w/context" entry (file+headline "~/org/notes.org" "Tasks")
	 "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+headline "~/org/journal.org" "Journal")
	 "* %T\n%?" :prepend t)))

;; From:
;;  http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/
(custom-set-variables
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
	   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	   ("w" todo "WAITING" nil)
	   ("W" agenda "" ((org-agenda-ndays 21)))
	   ("A" agenda ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
	     (org-agenda-ndays 1)
	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	   ("u" alltodo ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
					  (quote regexp) "\n]+>")))
	     (org-agenda-overriding-header "Unscheduled TODO entries: ")))))))

(setq org-global-properties
      '(("Effort_ALL" .
	 "0 0:15 0:30 1:00 2:00 3:00 4:00 5:00 6:00 8:00")))

(setq org-agenda-sorting-strategy '(time-up todo-state-down priority-down))

;(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cr" 'org-capture)

(defun mk/org-get-todo-keyword-value ()
  (if (looking-at org-complex-heading-regexp)
      (- 9999 (length (member (match-string 2)
			      org-todo-keywords-1)))))

(defun mk/org-resort-todos ()
  (interactive)
  (outline-up-heading 10)
  (org-sort-entries t ?p)
  (org-sort-entries t ?F 'mk/org-get-todo-keyword-value)
  (org-overview)
  (org-cycle))

(add-hook 'org-load-hook
	  (lambda ()
	    (define-key org-mode-map "\C-cg" 'mk/org-resort-todos)))

