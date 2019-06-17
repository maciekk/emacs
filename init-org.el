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
    (setq org-directory "~/org/GTD/"  ; used for capture, agenda
	  org-archive-location "archives/%s_archive::"
	  org-default-notes-file (concat org-directory "inbox.org"))

;;; Startup
    (setq org-startup-folded 'showall
	  org-startup-indented t)

;;; Visuals
    (setq org-src-fontify-natively t
	  org-fontify-whole-heading-line t
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

    ;; Make Agenda screen use larger fonts
    (add-hook 'org-agenda-mode-hook 'my-org-agenda-mode-hook)
    (defun my-org-agenda-mode-hook () (text-scale-set 3))
    
;;; Key behaviour
    (setq org-special-ctrl-a nil
	  org-special-ctrl-e nil
	  org-special-ctrl-k t
	  org-use-speed-commands t
	  org-return-follows-link t)

;;; Misc
    (setq org-cycle-separator-lines 2
	  org-blank-before-new-entry '((heading . auto) (plain-list-item . auto)))

;;; Agenda
    (setq org-agenda-span 3
	  org-agenda-start-on-weekday 1
	  org-agenda-window-setup 'only-window
	  org-agenda-tags-column 'auto
	  org-agenda-sorting-strategy '(time-up todo-state-down priority-down))
    (setq org-agenda-files (list org-directory))
    ;; Originally from:
    ;;  http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/
    (setq org-agenda-custom-commands
	  '(("d" todo "DELEGATED" nil)
	    ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	    ("w" todo "WAITING" nil)
	    ("W" agenda "" ((org-agenda-ndays 21)))
	    ("n" "NOW view"
	     ((tags "now/!-DONE-CANCELLED"
		    ((org-agenda-overriding-header "  --== NOW! ==--")))
	      (agenda "" ((org-agenda-span 7)
			  (org-agenda-start-on-weekday nil)))))
	    ("h" "Hotlist" tags "hot"
	     ((org-agenda-overriding-header "  === HOTLIST ===")))
	    (" " "Agenda"
             ((agenda "" nil)
              (tags "REFILE"
                    ((org-agenda-overriding-header "Tasks to Refile")
                     (org-tags-match-list-sublevels 'indented)))))
	    ("A" agenda ""
	     ((org-agenda-skip-function
	       (lambda nilp
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
	  '((nil :maxlevel . 1)
	    (org-agenda-files :maxlevel . 2)))

    ;; Patterned on:
    ;;  http://doc.norang.ca/org-mode.html
    (setq org-todo-keywords
	  (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(z)" "|" "DONE(d!/!)" "CANCELLED(c@/!)"))))
    ;; Do not use fast tag selection if want to default to helm for this.
    ;; See: https://github.com/emacs-helm/helm/issues/1890
    ;; (setq org-tag-alist
    ;; 	  '(("desk" . ?d)
    ;; 	    ("work" . ?w)
    ;; 	    ("garden" . ?g)
    ;; 	    ("errands" . ?e)
    ;; 	    ("basement" . ?b)
    ;; 	    ("kitchen" . ?k)
    ;; 	    ("Net" . ?n)
    ;; 	    ("leisure" . ?l)
    ;; 	    ))
    (setq org-global-properties
	  '(("Effort_ALL" .
	     "0 0:15 0:30 1:00 2:00 3:00 4:00 5:00 6:00 8:00")))
    (setq org-capture-templates
	  `(("t" "Todo" entry (file+headline ,(concat org-directory "inbox.org") "Tasks")
	     "* TODO %?\n  %i")
	    ("T" "Todo w/context" entry (file+headline ,(concat org-directory "inbox.org") "Tasks")
	     "* TODO %?\n  %i\n  %a")
            ("j" "Journal" entry (file+datetree ,(concat org-directory "journal.org"))
             "* %?\n%c\nEntered on %U\n")))))

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

;; From:
;;   https://stackoverflow.com/questions/6997387/how-to-archive-all-the-done-tasks-using-a-single-command/27043756#27043756
(defun mk/org-archive-done ()
  "Archive all DONE items in subtree under point."
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "+TODO=\"DONE\"|+TODO=\"CANCELLED\"" 'tree))

;;; Own bindings
(add-hook 'org-load-hook
	  (lambda ()
	    (define-key org-mode-map "\C-cg" 'mk/org-resort-todos)
	    (define-key org-mode-map "\C-cv" 'mk/org-archive-done)
	    ))

;;; Additional packages
(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1))))

;; Org rifle mode
(require 'helm-org-rifle)
