;; My tweaks for various themes, and fast theme swapping.
;; Methodology stolen from the fantastic post:
;;   https://www.greghendershott.com/2017/02/emacs-themes.html

;; Aside: useful site where you can preview themes:
;;   https://pawelbx.github.io/emacs-theme-gallery/

(defun mk/disable-all-themes ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defvar mk/theme-hooks nil
  "((theme-id . function) ...)")

(defun mk/add-theme-hook (theme-id hook-func)
  (add-to-list 'mk/theme-hooks (cons theme-id hook-func)))

(defun mk/load-theme-advice (f theme-id &optional no-confirm no-enable &rest args)
  "Enhances `load-theme' in two ways:
1. Disables enabled themes for a clean slate.
2. Calls functions registered using `mk/add-theme-hook'."
  (unless no-enable
    (mk/disable-all-themes))
  (prog1
      (apply f theme-id no-confirm no-enable args)
    (unless no-enable
      (pcase (assq theme-id mk/theme-hooks)
        (`(,_ . ,f) (funcall f))))))

(advice-add 'load-theme
            :around
            #'mk/load-theme-advice)

(use-package rebecca
  :ensure rebecca-theme
  :defer t
  :init
  (defun mk/rebecca-theme-hook ()
    (set-face-attribute 'org-todo nil :weight 'normal
			:foreground "#FF8080" :background "#552525")
    (set-face-attribute 'org-done nil :weight 'normal
			:foreground "#77DD77" :background "#335533")
    (set-face-attribute 'org-level-2 nil :weight 'normal :height 1.1)
    (set-face-attribute 'org-level-2 nil :weight 'normal :height 1.0))
  (mk/add-theme-hook 'rebecca #'mk/rebecca-theme-hook))


(use-package monokai-alt
  :ensure monokai-alt-theme
  :defer t
  :init
  (defun mk/monokai-alt-theme-hook ()
    (set-face-attribute 'org-todo nil :box nil)
    (set-face-attribute 'org-done nil :box nil))
  (mk/add-theme-hook 'monokai-alt #'mk/monokai-alt-theme-hook))

(use-package base16-ashes
  :ensure base16-theme
  :defer t
  :init
  (defun mk/ashes-theme-hook ()
    (set-face-attribute 'org-todo nil :weight 'normal
			:foreground "#CC4848" :background "#441515")
    (set-face-attribute 'org-done nil :weight 'normal
			:foreground "#48BB48" :background "#154415"))
  (mk/add-theme-hook 'base16-ashes #'mk/ashes-theme-hook))

(use-package busybee
  :ensure busybee-theme
  :defer t
  :init
  (defun mk/busybee-theme-hook ()
    (set-face-attribute 'helm-selection nil :background "#003300"))
  (mk/add-theme-hook 'busybee #'mk/busybee-theme-hook))

(use-package hydandata-light
  :ensure hydandata-light-theme
  :defer t
  :init
  (defun mk/hydandata-theme-hook ()
    (set-face-attribute 'helm-selection nil :background "#BBFFBB"))
  (mk/add-theme-hook 'hydandata-light #'mk/hydandata-theme-hook))

(use-package twilight
  :ensure twilight-bright-theme
  :defer t
  :init
  (defun mk/twilight-theme-hook ()
    (set-face-attribute 'helm-selection nil :background "#BBFFBB"))
  (mk/add-theme-hook 'twilight-bright #'mk/twilight-theme-hook))

(use-package leuven
  :ensure leuven-theme
  :defer t
  :init
  (defun mk/leuven-theme-hook ()
    (set-face-attribute 'helm-selection nil :background "#BBFFBB"))
  (mk/add-theme-hook 'leuven #'mk/leuven-theme-hook))

(use-package hydra
  :ensure t
  :config
  (setq hydra-lv nil) ;use echo area
)

(defhydra mk/themes-hydra (:hint nil :color pink)
  "
Light: _i_odine     _l_euven       _p_oet       _t_wilight    ca_v_e-light  h_y_dandata
Dark:  sub_a_tomic  _b_usybee      _c_reamsody  _d_arktooth   _e_mbers      _f_latland
       _g_ruvbox    _G_reenscreen  as_h_es      d_j_ango      _m_onokai-alt _M_ustang
       _r_ebecca    bad_w_olf
"
  ("a" (load-theme 'subatomic       t))
  ("b" (load-theme 'busybee         t))
  ("c" (load-theme 'creamsody       t))
  ("d" (load-theme 'darktooth       t))
  ("e" (load-theme 'base16-embers   t))
  ("f" (load-theme 'flatland        t))
  ("g" (load-theme 'gruvbox         t))
  ("G" (load-theme 'base16-greenscreen t))
  ("h" (load-theme 'base16-ashes    t))
  ("i" (load-theme 'iodine          t))
  ("j" (load-theme 'django          t))
  ("l" (load-theme 'leuven          t))
  ("m" (load-theme 'monokai-alt     t))
  ("M" (load-theme 'mustang         t))
  ("p" (load-theme 'poet            t))
  ("r" (load-theme 'rebecca         t))
  ("t" (load-theme 'twilight-bright t))
  ("v" (load-theme 'base16-atelier-cave-light t))
  ("y" (load-theme 'hydandata-light t))
  ("w" (load-theme 'badwolf         t))
  ("DEL" (mk/disable-all-themes))
  ("RET" nil "done" :color blue))

(bind-keys ("C-c w t"  . mk/themes-hydra/body))

;; Load default preferred theme.
(load-theme 'twilight-bright)
