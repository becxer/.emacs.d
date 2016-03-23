;;
;;   becxer's emacs configuration
;;
;;   @ author becxer
;;   @ email becxer87@gmail.com
;;

;;PACKAGE-ARCHIVES
(when (>= emacs-major-version 24)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize))

;;BETTER-DEFAULTS
(add-to-list 'load-path "~/.emacs.d/plugins/better-defaults")
(require 'better-defaults)

;;HIGHLIGHT LINE NUMBER
(add-to-list 'load-path "~/.emacs.d/plugins/hlinum")
(require 'hlinum)
(hlinum-activate)

;;FILL-COLUMN-INDICATOR
(add-to-list 'load-path "~/.emacs.d/plugins/fill-column-indicator")
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-color "red")
(define-globalized-minor-mode
   global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

;;AUTO-COMPLETE
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;;AUTO-PAIR
(add-to-list 'load-path "~/.emacs.d/plugins/autopair")
(require 'autopair)
(autopair-global-mode)

;;NEO-TREE
(add-to-list 'load-path "~/.emacs.d/plugins/neotree")
(require 'neotree)
(global-set-key (kbd "C-e") 'neotree-toggle)

;;WHICH-KEY
(add-to-list 'load-path "~/.emacs.d/plugins/which-key")
(require 'which-key)
(which-key-mode)

;;INDENT-GUIDE
(add-to-list 'load-path "~/.emacs.d/plugins/indent-guide")
(require 'indent-guide)
(indent-guide-global-mode)

;;ANZU (Advanced REGEX)
(add-to-list 'load-path "~/.emacs.d/plugins/anzu")
(require 'anzu)
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :background "yellow" :weight 'bold)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;;ELSCREEN
(add-to-list 'load-path "~/.emacs.d/plugins/elscreen")
(require 'elscreen)
(elscreen-start)

;;SWITCH-WINDOW
(add-to-list 'load-path "~/.emacs.d/plugins/switch-window")
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;;PYTHON-MODE
(add-to-list 'load-path "~/.emacs.d/plugins/python-mode")
(require 'python-mode)
; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
; (setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

;;CUSTOM THEME
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)
     (color-theme-lethe)))

