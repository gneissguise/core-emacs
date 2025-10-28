;;; core-programming.el --- Base configuration for programming modes -*- lexical-binding: t; -*-

;;; Commentary:
;;; Sets up tree-sitter and other general programming enhancements.

;;; Code:

;; --- Tree-sitter Configuration ---
;; Tree-sitter provides faster and more accurate syntax highlighting.
;; We enable the highlighting mode for all programming modes.
(require 'treesit)

;; --- Tree-sitter Path Configuration ---
;; Tell Emacs where to find the system-installed tree-sitter grammars.
;; On Arch-based systems, pacman installs them to '/usr/lib/tree-sitter/'.
(add-to-list 'treesit-extra-load-path "/usr/lib/tree-sitter/")


;; --- Combobulate: Tree-sitter Powered Editing ---
(require 'combobulate)
(let ((combobulate-enabled-modes
       '(emacs-lisp-mode lisp-mode clojure-mode sh-mode js-mode typescript-mode html-mode
         css-mode java-mode csharp-mode json-mode xml-mode yaml-mode sql-mode)))
  (dolist (mode-hook combobulate-enabled-modes)
    (add-hook (intern (format "%s-hook" mode-hook)) #'combobulate-mode)))

;; --- Aggressive Indent ---
;; Automatically keep code indented correctly as you type.
(with-eval-after-load 'aggressive-indent
  (add-hook 'prog-mode-hook #'aggressive-indent-mode))

;; --- Improved Compile Command ---
;; Make the compilation buffer quieter and add syntax highlighting.
(setq compilation-scroll-output t)
(add-hook 'compilation-mode-hook #'compilation-hl-mode)

;; --- Magit Configuration ---
(with-eval-after-load 'magit
  (progn
    ;; Automatically save file-visiting buffers before running magit commands.
    (setq magit-save-repository-buffers 'dontask)
    ;; Enable magit-todos-mode to show a list of TODOs in the status buffer.
    (magit-todos-mode)))

(with-eval-after-load 'magit-delta
  ;; Enable delta for Magit diffs.
  (magit-delta-mode 1)
  ;; Use Delta's side-by-side view by default.
  (setq magit-delta-default-options '("-s")))

(provide 'core-programming)
;;; core-programming.el ends here
