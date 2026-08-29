;;; core-programming.el --- Base configuration for programming modes -*- lexical-binding: t; -*-

;;; Commentary:
;;; Sets up tree-sitter and other general programming enhancements.

;;; Code:

;; --- Tree-sitter Configuration ---
;; Tree-sitter provides faster and more accurate syntax highlighting.
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
;; Automatically keep code indented correctly as you type in traditional Emacs modes.
;; Tree-sitter-based programming modes (Clojure, TypeScript/JS, Shell) have their own
;; native indentation engines and should NOT use aggressive-indent — it conflicts with them.
(add-hook 'prog-mode-hook
          (lambda ()
            ;; Only enable for non-tree-sitter modes that lack native indentation.
            (unless (derived-mode-p 'treesit-mode)
              (aggressive-indent-mode 1))))

;; --- Improved Compile Command ---
;; Make the compilation buffer quieter and add syntax highlighting.
(setq compilation-scroll-output t)

;; --- Magit Configuration ---
(with-eval-after-load 'magit
  ;; Automatically save file-visiting buffers before running magit commands.
  (setq magit-save-repository-buffers 'dontask)
  ;; Enable magit-todos-mode to show a list of TODOs in the status buffer.
  (magit-todos-mode))

(with-eval-after-load 'magit-delta
  ;; Enable delta for Magit diffs.
  (magit-delta-mode 1)
  ;; Use Delta's side-by-side view by default.
  (setq magit-delta-default-options '("-s")))

(provide 'core-programming)
;;; core-programming.el ends here
