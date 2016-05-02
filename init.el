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
(define-globalized-minor-mode
   global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(setq fci-rule-column 80)

;;Begin-End-of line
(global-set-key (kbd "C-M-f") 'end-of-line)
(global-set-key (kbd "C-M-b") 'beginning-of-line)

;;TOGGLE-DECO
(setq toggle-deco-value -1)
(defun toggle-deco ()
  (message "Toggle deco : %d" toggle-deco-value)
  (interactive)
  (linum-mode toggle-deco-value)
  (fci-mode toggle-deco-value)
  (indent-guide-global-mode toggle-deco-value)
  (setq toggle-deco-value (* -1 toggle-deco-value)))
(global-set-key (kbd "C-n") 'toggle-deco)

;;TOGGLE-ELECTRIC-INDENT
(setq toggle-electric-indent -1)
(defun toggle-electric ()
  (message "Toggle electric-indent : %d" toggle-electric-indent)
  (interactive)
  (electric-indent-mode toggle-electric-indent)
  (setq toggle-electric-indent (* -1 toggle-electric-indent)))
(global-set-key (kbd "C-p") 'toggle-electric)

;;AUTO-COMPLETE
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;;JEDI SETTING
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

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

;;SMART-REP
(add-to-list 'load-path "~/.emacs.d/plugins/smartrep")
(require 'smartrep)
(smartrep-define-key
 global-map "C-x"
'(("{" . shrink-window-horizontally)
  ("}" . enlarge-window-horizontally)
  ("-" . shrink-window)
  ("+" . enlarge-window)))

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
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
)
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

;;SMOOTH-SCROLL
(add-to-list 'load-path "~/.emacs.d/plugins/smooth-scroll")
(require 'smooth-scroll)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

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

;;EDIT-SERVER
(add-to-list 'load-path "~/.emacs.d/plugins/edit-server")
(require 'edit-server)
(edit-server-start)

;;SMART-COMPILE
(add-to-list 'load-path "~/.emacs.d/plugins/smart-compile")
(require 'smart-compile)
(require 'cl)  ; for lexical-let
(defun do-execute (exe)
  (with-current-buffer "*eshell*"
    (goto-char (point-max))
    (insert exe)
    (eshell-send-input))
  (switch-to-buffer-other-window "*eshell*"))

(defun save-compile-execute ()
  (interactive)
  (lexical-let ((exe (smart-compile-string "./%n"))
                finish-callback)
    ;; when compilation is done, execute the program
    ;; and remove the callback from
    ;; compilation-finish-functions
    (setq finish-callback
          (lambda (buf msg)
            (do-execute exe)
            (setq compilation-finish-functions
                  (delq finish-callback compilation-finish-functions))))
    (push finish-callback compilation-finish-functions))
  (smart-compile 1))

(global-set-key (kbd "C-c *") 'save-compile-execute)

;;CUSTOM THEME
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-hober)
;;     (color-theme-lethe)))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'monokai t)

(mapc
(lambda (face)
   (set-face-attribute face nil :weight 'bold))
 (face-list))

;;Abbrev-file
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

;;FONT
(set-default-font "hack 9")
