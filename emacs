(desktop-save-mode t)
(global-linum-mode t)
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(blink-cursor-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
;;(toggle-frame-fullscreen)
(when window-system (set-frame-size (selected-frame) 84 48))
(require 'cl-lib)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (cl-letf (((symbol-function #'process-list) (lambda ())))
    ad-do-it))


(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#32302F" "#FB4934" "#B8BB26" "#FABD2F" "#83A598" "#D3869B" "#17CCD5" "#EBDBB2"])
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a4d03266add9a1c8f12b5309612cbbf96e1291773c7bc4fb685bfdaf83b721c6" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(package-selected-packages
   (quote
    (smart-mode-line darktooth-theme proof-site ## dracula-theme helm evil)))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(eval-when-compile
    (require 'use-package))

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
;;(load-theme 'dracula t)
;;(load-theme 'darktooth t)
(load-theme 'wombat t)
(sml/setup)

(use-package proof-site
    :defer t
    :mode ("\\.v\\'" . coq-mode)
    :load-path
    "~/.emacs.d/lisp/PG/generic")
(setq coq-mode-abbrev-table '())    ; bad interaction with evil
(eval-after-load "proof-script" '(progn
 (define-key proof-mode-map [(f2)] 
                            'proof-undo-last-successful-command)
 (define-key proof-mode-map [(f3)] 
                            'proof-assert-next-command-interactive)
 (define-key proof-mode-map [(f4)] 
                            'proof-goto-point)
 ))
	
;(maths-menu-mode t)
(global-set-key [?\s-l] 'maths-menu-insert-lambda)
(global-set-key [?\s-l] 'maths-menu-insert-lambda)
(global-set-key [?\s-l] 'maths-menu-insert-lambda)
(global-set-key [?\s-L] 'maths-menu-insert-Lambda)
(global-set-key [?\s-D] 'maths-menu-insert-Delta)
(global-set-key [?\s-a] 'maths-menu-insert-for-all)
(global-set-key [?\s-e] 'maths-menu-insert-there-exists)
(global-set-key [?\s-t] 'maths-menu-insert-down-tack)
(global-set-key [?\s-b] 'maths-menu-insert-up-tack)
(global-set-key [?\s-\#] 'maths-menu-insert-music-sharp-sign)
(global-set-key [?\s-\.] 'maths-menu-insert-horizontal-ellipsis)
(global-set-key [?\s-3] 'proof-three-window-toggle)

