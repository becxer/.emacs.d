;;
;;   becxer's emacs configuration
;;
;;   @ author becxer
;;   @ email becxer87@gmail.com
;;

;; TODO : pull out setting package
;; TODO : enable when package are supported OS

;;PACKAGE-ARCHIVES
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;;BETTER-DEFAULTS
(add-to-list 'load-path "~/.emacs.d/plugins/better-defaults")
(require 'better-defaults)

;;KEY-BINDDING
(setq x-alt-keysym 'meta)

;;FONT
(set-default-font "Hack 9")

;;DISABLE AUTO-BACKUP
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;;HELM (LIKE SUBLIME COMMAND PALLETE)
(require 'helm)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
  helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
(setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
  helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
  helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
  helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
  helm-ff-file-name-history-use-recentf t)

(require 'helm-config)
(helm-mode t)

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
(setq column-number-mode t)

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

;;SHELL-POP
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(shell-pop-default-directory "~/")
'(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
'(shell-pop-term-shell "/bin/bash")
'(shell-pop-universal-key "C-t")
'(shell-pop-window-size 30)
'(shell-pop-full-span t)
'(shell-pop-window-position "bottom"))

;;MULTIPLE-CURSOR(LIKE SUBLIME ALT-G)
(require 'multiple-cursors)
(global-set-key (kbd "M-d") 'mc/mark-next-like-this)
(global-set-key (kbd "M-e") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-a") 'mc/mark-all-like-this)

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

;;SR-SPEEDBAR
(add-to-list 'load-path "~/.emacs.d/plugins/sr-speedbar")
(require 'sr-speedbar)
(global-set-key (kbd "C-b") 'sr-speedbar-toggle)

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

(smartrep-define-key                                                                                                                                                                                                                                                            
 global-map "C-c"                                                                                                                                                                                                                                                               
'(("{" . buf-move-left)                                                                                                                                                                                                                                                         
  ("}" . buf-move-right)                                                                                                                                                                                                                                                        
  ("-" . buf-move-down)                                                                                                                                                                                                                                                         
  ("+" . buf-move-up))) 

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

;;FLYSPELL-MODE
(setq ispell-program-name "/usr/local/bin/ispell")
(setq ispell-dictionary "english")
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;;CUSTOM THEME
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(require 'color-theme)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'monokai t)

;;Abbrev-file
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

;;RAINBOW-DELIMITERS
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;DATE AND TIME
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;;FIXMEE-MODE
(require 'fixmee)
(fixmee-mode 1)
(global-fixmee-mode 1)

;;AUTO-REVERT-MODE
(global-auto-revert-mode t)

