;;; My awesome emacs setup, just plop this shit in your home directory 
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this lin

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)
;; xclip-mode 1

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
                                        ; Always show line numbers
(dolist (hook '(emacs-lisp-mode-hook
		ruby-mode-hook
		js-mode-hook
    js2-mode-hook
                cperl-mode-hook
                shell-mode-hook
                text-mode-hook
                change-log-mode-hook
                makefile-mode-hook
                message-mode-hook
                texinfo-mode-hook
                c-mode-common-hook
                python-mode-hook
                prog-mode-hook
                scala-mode-hook))
  (add-hook hook
            '(lambda () (linum-mode))))
;; (global-linum-mode t)

;terminal
;(global-set-key "\C-t" 'multi-term)

; Ido mode
(use-package ido
	     :ensure ido)
(ido-mode t)

(use-package color-theme
  :ensure color-theme)

                                        ; Solarized
 (use-package color-theme-solarized
  :ensure color-theme-solarized)
(load-theme 'solarized t)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
              (set-frame-parameter frame 'background-mode mode)
              (set-terminal-parameter frame 'background-mode mode))
            (enable-theme 'solarized)))
(load-theme 'solarized t)
                                        ; window resizer

(use-package windsize
	     :ensure windsize)
(global-set-key (kbd "C-c <left>")  'windsize-left)
(global-set-key (kbd "C-c <right>") 'windsize-right)
(global-set-key (kbd "C-c <up>")    'windsize-up)
(global-set-key (kbd "C-c <down>")  'windsize-down)

; magit status
(global-set-key (kbd "C-c s") 'magit-status)
(setq magit-last-seen-setup-instructions "1.4.0")

                                        ; Rainbow Delimiters
(use-package rainbow-delimiters
	     :ensure rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; Auto Complete
;; (require 'auto-complete-config)
;; (ac-config-default)

; Zencoding
(use-package zencoding-mode
	     :ensure zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)

; Flycheck
(use-package flycheck
	     :ensure flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

                                        ; Find file in
(use-package find-file-in-project
  :ensure find-file-in-project)
(global-set-key (kbd "C-x o") 'find-file-in-project)

; Use colors to highlight commands, etc.
(global-font-lock-mode t)

; Disable the welcom message
(setq inhibit-startup-message t)

; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

; Display time
(display-time)

; Always end a file with a new line
(setq require-final-newline t)

; Stop emacs from arbitrarily adding lines to the end of a file when the
; cursor is moved past the end of it
(setq next-line-add-newlines nil)

; Flash instead of that annoying bell
(setq visible-bell t)

; Use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)

; Lines
(setq scroll-step 1)
(line-number-mode 1)
(column-number-mode 1)

; Backup
(setq make-backup-files nil)
;(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

; Helpful key bindings
(global-set-key "\C-^" 'enlarge-window)

;terminal
;(require 'multi-term)
;(setq multi-term-program "/bin/bash")

; Tab 2
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq css-indent-offset 2)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;set copy and paste
(setq x-select-enable-clipboard t)
;; this line causes cut/paste errors under windows (emacs 24)
(if (eq system-type 'gnu-linux) (setq interprogram-paste-function 'x-cut-buffer-or-selection-value) )
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; this alternative causes errors under linux (emacs 24)
(if (eq system-type 'windows-nt) (setq interprogram-paste-function 'x-selection-value) )
;;(setq interprogram-paste-function 'x-selection-value)

;;speedbar
;(require 'sr-speedbar)
;(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;;move by paragraph
(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-p" 'backward-paragraph)


;; highlight all characters past 80
(use-package column-marker
	     :ensure column-marker)
(dolist (hook '(emacs-lisp-mode-hook
		ruby-mode-hook
		js-mode-hook
    js2-mode-hook
                cperl-mode-hook
                shell-mode-hook
                text-mode-hook
                change-log-mode-hook
                makefile-mode-hook
                message-mode-hook
                texinfo-mode-hook
                c-mode-common-hook
                python-mode-hook
                prog-mode-hook))
  (add-hook hook
            '(lambda () (column-marker-3 80))))

; Row marker
;(require 'highlight-current-line)
;(highlight-current-line-on t)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#000000")
(set-face-foreground 'highlight nil)
;; To customize the background color
;(set-face-background 'highlight-current-line-face "#000000")

; Js2 mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;tramp
(setq tramp-default-method "ssh")



(use-package ergoemacs-mode
	     :ensure ergoemacs-mode)
(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "us")

(ergoemacs-ignore-prev-global) ; Do Not Honor Previously Defined
                                        ; Global Keys.
(ergoemacs-mode 1)

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;;(use-package bind-keyCO
  ;;:ensure bind-key)

(bind-key* "\M-o" 'forward-word)
(global-set-key "\M-o" 'forward-word)
(bind-key* "\M-h" 'end-of-line)
(global-set-key "\M-h" 'end-of-line)
(bind-key* "\M-\S-h" 'beginning-of-line)
(global-set-key "\M-\S-h" 'beginning-of-line)
(bind-key* "\M-s" 'other-window)
(global-set-key "\M-s" 'other-window)
(bind-key* "\M-$" 'split-window-right)
(global-set-key "\M-$" 'split-window-right)
(bind-key*  "\M-v" 'yank)
(global-set-key  "\M-v" 'yank)
(bind-key* (kbd "C-x 3") 'split-window-horizontally)
(global-set-key(kbd "C-x 2") 'split-window-vertically)

(use-package magit
  :ensure magit)

(use-package scala-mode
  :ensure scala-mode)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(define-key my-keys-minor-mode-map (kbd "M-D") 'kill-other-buffers)
;; (define-key my-keys-minor-mode-map "\M-g" 'goto-line)
(define-key my-keys-minor-mode-map "\M-;" 'evilnc-comment-or-uncomment-lines)

;; Neotree file browser
(use-package neotree
  :ensure neotree)
(define-key my-keys-minor-mode-map "\M-]" 'neotree-toggle)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (progn
          (neotree-dir project-dir)
          (neotree-find file-name))
      (message "Could not find git project root."))))

  (define-key my-keys-minor-mode-map (kbd "C-c C-p") 'neotree-project-dir)

(use-package git-gutter
  :ensure git-gutter)
(global-git-gutter-mode +1)
(git-gutter:linum-setup)

;; smex
(use-package smex
  :ensure smex)

; Multiple cursors
(use-package multiple-cursors
	     :ensure multiple-cursors)
(define-key my-keys-minor-mode-map "\C-d" 'mc/mark-next-like-this)
(define-key my-keys-minor-mode-map "\M-d" 'mc/mark-all-like-this)

(define-key my-keys-minor-mode-map (kbd "M-g") 'kill-line)
(global-set-key (kbd "M-g") 'kill-line)

;;(use-package bind-key
  ;;:ensure bind-key)
;;(bind-key* "\M-g" 'kill-line)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

;; Poor attempt to enable mouse selection in osx
;; Enable mouse support
;;(unless window-system
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'mouse)                                 ;;
;; (require 'xt-mouse)                              ;;
;;   (xterm-mouse-mode t)                           ;;
;;   (global-set-key [mouse-4] '(lambda ()          ;;
;;                                (interactive)     ;;
;;                                (scroll-down 1))) ;;
;;   (global-set-key [mouse-5] '(lambda ()          ;;
;;                                (interactive)     ;;
;;                                (scroll-up 1)))   ;;
;;   (defun track-mouse (e))                        ;;
;;   (setq mouse-sel-mode t)                        ;;
;;   ;;)                                            ;;
;;                                                  ;;
;; (iswitchb-mode 1)                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Code search
(use-package helm-ag
  :ensure helm-ag)
(define-key my-keys-minor-mode-map "\M-F" 'helm-ag-project-root)

;; Always show 4 lines around cursor for scrolling
(setq scroll-margin 4)

;; Scrolling stuff
(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

;; Always scroll by half screens because it's neater
(define-key my-keys-minor-mode-map "\M-K" 'scroll-up-half)
(define-key my-keys-minor-mode-map "\M-I" 'scroll-down-half)


(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(use-package powerline
  :ensure powerline)

;; (defface powerline-active1 '((t (:background "#268bd2" :inherit-mode-line)))
;;   "powerline face 1."
;;   :group 'powerline)
;; (defface powerline-inactive1 '((t (:background "#002b36" :inherit-mode-line)))
;;   "powerline face 1."
;;   :group 'powerline)

(powerline-center-theme)

;;(set-face-attribute 'mode-line-inactive nil :background "#002b36" :foreground "#002b36")
;; (set-face-attribute 'mode-line nil
;;                     :foreground "#fdf6e3"
;;                     :background "#2aa198"
;;                     :box nil)

;; (set-face-attribute 'powerline-inactive1 nil :background "#002b36" :foreground "#002b36")
;; (set-face-attribute 'powerline-inactive2 nil :background "#002b36" :foreground "#002b36")
;; ;;(set-face-attribute 'powerline-active1 nil :background "#002b36" :foreground "#fdf6e3")

;; (custom-set-faces (if (not window-system) '(default ((t (:background "nil"))))))

;;(set-face-attribute 'powerline-active2 nil :background "#268bd2" :foreground "#268bd2")

;;; End emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(ansi-term-color-vector
   [unspecified "#282a2e" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#e0e0e0"] t)
 '(case-fold-search nil)
 '(custom-enabled-themes (quote (base16-default)))
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(debug-on-error t)
 '(ecb-layout-name "directories")
 '(ecb-layout-window-sizes
   (quote
    (("directories"
      (ecb-directories-buffer-name 0.2624113475177305 . 0.9459459459459459)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote (("/" "/"))))
 '(ergoemacs-mode t)
 '(fci-rule-color "#393939")
 '(js2-basic-offset 2)
 '(org-CUA-compatible nil)
 '(org-replace-disputed-keys nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))

(defun my-backspace ()
  (interactive)
  (let* ((end (save-excursion
                (end-of-line)
                (point)))
         (beginning (save-excursion
                      (beginning-of-line)
                      (point))))
    (if (string-match "^[ \t]*$" (buffer-substring beginning end))
        (progn
          (beginning-of-line)
          (kill-line)
          (previous-line)
          (indent-for-tab-command)
          (end-of-line))
      (delete-backward-char 1))))
 (define-key my-keys-minor-mode-map (kbd "DEL") 'my-backspace)
;;; end .emacs
