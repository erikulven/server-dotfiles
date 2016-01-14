;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8
    magit
    evil
    evil-jumper
    helm
    column-marker
    request-deferred
    json-reformat
    restclient
    neotree))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(elpy-use-ipython)
(setq elpy-rpc-backend "jedi")

;; set 80 col marker
(require 'column-marker)
(add-hook 'elpy-mode-hook (lambda () (interactive) (column-marker-1 80)))


;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable request
(require 'request)

;; enable request
(require 'restclient)


;; enable autopep8 formatting on save
(require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'neotree)
(global-set-key [f5] 'neotree-toggle)


(add-hook 'neotree-mode-hook
  (lambda ()
    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (previous-line)
  (end-of-line)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))


(setq evil-want-C-u-scroll t)
;; enable shortcut for magit-status
(global-set-key (kbd "C-x g") 'magit-status)

;; helm
(global-set-key (kbd "M-x") 'helm-M-x)

;; Load evil-leader to get leader key in evil mode.
;; needs to be loaded before evil
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

(require 'evil)
(evil-mode 1)

(require 'evil-jumper)
(evil-jumper-mode 1)

;; vim navigation Ctrl+hjkl
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;This is so I can spam the [ESC]
;;key and eventually exit whatever
;;state Emacs has put me in
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key evil-normal-state-map (kbd ";") #'evil-ex)
(evil-leader/set-key ";" #'execute-extended-command)
(evil-leader/set-key "G" #'magit-status)
(evil-leader/set-key "s" #'toggle-scratch)
(evil-leader/set-key "<SPC>g" #'find-tag)
(evil-leader/set-key-for-mode 'python-mode "f" 'elpy-find-file)
(evil-leader/set-key-for-mode 'python-mode "g" 'elpy-goto-definition)
(evil-leader/set-key-for-mode 'python-mode "r" 'elpy-refactor)
(evil-leader/set-key-for-mode 'python-mode "e" 'elpy-multiedit)
(evil-leader/set-key-for-mode 'python-mode "SPC" 'elpy-company-backend)
(evil-leader/set-key-for-mode 'python-mode "b" 'python-add-breakpoint)

(evil-ex-define-cmd "k" #'kill-buffer)
(evil-ex-define-cmd "ko" #'kill-other-buffers)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


(setq evil-echo-state t)

;; don't use evil mode in git integration windows. it breaks stuff.
(evil-set-initial-state 'magit-popup-mode 'emacs)
(evil-set-initial-state 'magit-blame-mode 'emacs)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
