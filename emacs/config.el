(use-package eglot
  :ensure t
  :config
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure))
(use-package company
:after eglot
:hook (eglot-managed-mode . company-mode))

(use-package gptel
  :ensure t
  :config
  (setq gptel-default-api 'google)
  (setq gptel-default-model 'gemini-pro)
  (setq gptel-live-update t))

;; Create a directory for backups and auto-saves if it doesn't exist
(let ((backup-dir "~/.config/emacs/backups/"))
  (when (not (file-directory-p backup-dir))
    (make-directory backup-dir t))

  ;; Configure backup files to be stored in the centralized directory
  (setq backup-directory-alist `(("." . ,backup-dir)))

  ;; Configure auto-save files to be stored in the centralized directory
  (setq auto-save-file-name-transforms `((".*" ,(concat backup-dir "auto-save-") t)))
  (setq auto-save-list-file-prefix (concat backup-dir "auto-save-list")))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(load-theme 'leuven-dark)

;; Make sure we show line numbers
(display-line-numbers-mode)

;; Set the line numbers to relative
(setq display-line-numbers 'relative)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package org-tempo)

(add-hook 'org-mode-hook 'auto-fill-mode)

(use-package org-roam
  :ensure t
  :config
  (make-directory "~/.roam")
  (setq org-roam-directory (file-truename "~/.roam")))

(use-package vertico
  :ensure t)

(use-package tree-sitter
  :ensure t)
(use-package tree-sitter-langs
  :ensure t)

(setq treesit-language-source-alist
 '((bash "https://github.com/tree-sitter/tree-sitter-bash")
   (c "https://github.com/tree-sitter/tree-sitter-c")
   (cmake "https://github.com/uyha/tree-sitter-cmake")
   (common-lisp "https://github.com/tree-sitter-grammars/tree-sitter-commonlisp")
   (css "https://github.com/tree-sitter/tree-sitter-css")
   (elisp "https://github.com/Wilfred/tree-sitter-elisp")
   (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
   (erlang "https://github.com/WhatsApp/tree-sitter-erlang")
   (go "https://github.com/tree-sitter/tree-sitter-go")
   (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
   (html "https://github.com/tree-sitter/tree-sitter-html")
   (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
   (json "https://github.com/tree-sitter/tree-sitter-json")
   (make "https://github.com/alemuller/tree-sitter-make")
   (markdown "https://github.com/ikatyang/tree-sitter-markdown")
   (ocaml "https://github.com/tree-sitter/tree-sitter-ocaml")
   (python "https://github.com/tree-sitter/tree-sitter-python")
   (rust "https://github.com/tree-sitter/tree-sitter-rust")
   (toml "https://github.com/tree-sitter/tree-sitter-toml")
   (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
   (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
   (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-jsx-mode))

(use-package rust-mode
:ensure t
:init
(setq rust-mode-treesitter-derive t))

(use-package slime
  :ensure t)

(setq inferior-lisp-program "sbcl")

(add-to-list 'auto-mode-alist '("\\.cl\\'" . common-lisp-mode))
