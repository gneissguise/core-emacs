;;; core-enhancements.el --- General UI and editing enhancements -*- lexical-binding: t; -*-

;;; Commentary:
;;; A collection of useful, general-purpose packages.

;;; Code:

;; --- Ispell Configuration ---
;; Tell Emacs's built-in spell checker to use the modern 'hunspell' engine.
;; This fixes errors with completion backends like 'ispell-completion-at-point'.
(when (executable-find "hunspell")
  (setq ispell-program-name "hunspell"))

;; --- Goggles: Visualize Changes ---
(goggles-mode 1)
(setq goggles-pulse t)


;; --- Jinx: On-the-fly Spell Checking ---
(add-hook 'text-mode-hook #'jinx-mode)


;; --- Recursion Indicator ---
(recursion-indicator-mode 1)


;; --- Ace Window: Fast Window Switching ---
(with-eval-after-load 'ace-window
  (global-set-key (kbd "M-p") #'ace-window))


;; --- Avy: Fast Cursor Jumping ---
(with-eval-after-load 'avy
  (global-set-key (kbd "C-'") #'avy-goto-char-timer))


;; --- Which Key: Discover Keybindings ---
(which-key-mode)

;; --- Rainbow Delimiters: Colorized Brackets ---
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;; --- Git Gutter: Version Control Info ---
(with-eval-after-load 'git-gutter
  (add-hook 'prog-mode-hook #'git-gutter-mode))


(provide 'core-enhancements)
;;; core-enhancements.el ends here
