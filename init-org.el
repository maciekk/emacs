(use-package org
  :mode ("\\.org\\'" . org-mode)
  :config
  (progn

;;; Primary key bindings
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-cr" 'org-capture) ; repeated; which is better?
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cb" 'org-switchb)
    (global-set-key "\C-cl" 'org-store-link)

;;; Paths
    (setq org-directory "~/Google Drive/org/"
	  org-archive-location "archives/%s_archive::"
	  org-default-notes-file (concat org-directory "capture.org"))

;;; Startup
    (setq org-startup-folded 'content
	  org-startup-indented t)

;;; Visuals
    (setq org-src-fontify-natively t
	  org-ellipsis "→"
	  org-hide-emphasis-markers t)
    ;; Could set (globally?) the keyword faces like so...
    ;; (setq org-todo-keyword-faces
    ;;       '(("TODO" :foreground "red" :weight bold)
    ;;         ("DOING" :foreground "magenta" :weight bold)
    ;;         ("DONE" :foreground "green" :weight bold)))

    ;; Allow multiple line Org emphasis markup
    ;; http://emacs.stackexchange.com/a/13828/115
    (setcar (nthcdr 4 org-emphasis-regexp-components) 5) ; up to 5 lines, default is just 1
    ;; Below is needed to apply the modified `org-emphasis-regexp-components'
    ;; settings from above.
    (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

;;; Key behaviour
    (setq org-special-ctrl-a t
	  org-special-ctrl-e t
	  org-special-ctrl-k nil
	  org-use-speed-commands t
	  org-return-follows-link t)
;;; Own bindings
    (add-hook 'org-load-hook
	      (lambda ()
		(define-key org-mode-map "\C-cg" 'mk/org-resort-todos)))

;;; Misc
    (setq org-cycle-separator-lines 1
	  org-blank-before-new-entry '((heading . auto) (plain-list-item . auto)))

;;; Agenda
    (setq org-agenda-span 3
	  org-agenda-start-on-weekday 0
	  org-agenda-sorting-strategy '(time-up todo-state-down priority-down))
    (setq org-agenda-files
	  (mapcar (lambda (p) (concat org-directory p))
		  '("gtd.org"
		    "someday.org"
		    "self-dev.org"
		    "read.org"
		    "watch.org"
		    "think.org"
		    "zettel.org"
		    "refs.org"
		    "emacs.org"
		    "emacs-org.org"
		    "fun.org")))
    ;; Originally from:
    ;;  http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/
    (setq org-agenda-custom-commands
	  '(("d" todo "DELEGATED" nil)
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
	      (org-agenda-overriding-header "Unscheduled TODO entries: ")))))
;;; Refiling
    (setq org-refile-use-outline-path 'file)
    (setq org-outline-path-complete-in-steps nil)
    (setq org-completion-use-ido t)
    (setq org-refile-targets
	  '((nil :maxlevel . 2)
	    (org-agenda-files :maxlevel . 1)))

    ;; Patterned on:
    ;;  http://doc.norang.ca/org-mode.html
    (setq org-todo-keywords
	  (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(z)" "|" "DONE(d!/!)" "CANCELLED(c@/!)"))))
    (setq org-tag-alist
	  '(("desk" . ?d)
	    ("work" . ?w)
	    ("garden" . ?g)
	    ("errands" . ?e)
	    ("basement" . ?b)
	    ("kitchen" . ?k)
	    ("Net" . ?n)
	    ("leisure" . ?l)
	    ))
    (setq org-global-properties
	  '(("Effort_ALL" .
	     "0 0:15 0:30 1:00 2:00 3:00 4:00 5:00 6:00 8:00")))
    (setq org-capture-templates
	  `(("t" "Todo" entry (file+headline ,(concat org-directory "capture.org") "Tasks")
	     "* TODO %?\n  %i")
	    ("T" "Todo w/context" entry (file+headline ,(concat org-directory "capture.org") "Tasks")
	     "* TODO %?\n  %i\n  %a")
            ("j" "Journal" entry (file+headline ,(concat org-directory "journal.org") "Journal")
	     "* %T\n%?" :prepend t)))))

;;; Helper functions
(defun mk/org-get-todo-keyword-value ()
  "Return 'sorting value' for TODO keyword of headline under point."
  (if (looking-at org-complex-heading-regexp)
      (- 9999 (length (member (match-string 2)
			      org-todo-keywords-1)))))

(defun mk/org-next-open-task ()
  "Advance point to next taks that is 'not done'."
  (interactive)
  (while (not (looking-at org-not-done-heading-regexp))
    (org-next-visible-heading 1)))

(defun mk/org-resort-todos ()
  "Sort the tasks in subtree under point; order:
  - first, by TODO keyword (e.g., DONE > STARTED > NEXT > TODO)
  - second, by PRIORITY"
  (interactive)
  (outline-up-heading 10)
  (org-sort-entries t ?p)
  (org-sort-entries t ?F 'mk/org-get-todo-keyword-value)
  (org-overview)
  (org-cycle)
  (mk/org-next-open-task))


;;; Additional packages
(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1))))


