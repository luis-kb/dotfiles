(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;;; Removing all the noise from the frame
;; Disable GUI chrome
(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))    ; menu bar
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))    ; tool bar
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; scroll bars

;; Optional: remove fringes (left/right padding)
(setq-default left-fringe-width 0)
(setq-default right-fringe-width 0)
;; If using display-buffer or GUI that still shows internal scrollbars, also:
(set-fringe-mode 0)

;; Remove splash screen and startup message
(setq inhibit-startup-screen t
      inhibit-startup-message t
      initial-scratch-message nil)

;; Remove tooltip popups (optional)
(when (fboundp 'tooltip-mode) (tooltip-mode -1))

;; For GUI frames created later (e.g., via emacsclient), also set default frame parameters:
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(left-fringe    . 0))
(add-to-list 'default-frame-alist '(right-fringe   . 0))

;;; Themes
;;; We want to keep this simple, no need to get all fancy
(load-theme 'wombat t)
