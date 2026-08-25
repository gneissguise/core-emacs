;;; core-modeline.el --- Customizations for the modeline -*- lexical-binding: t; -*-

;;; Commentary:
;;; Configures a modern, icon-rich modeline similar to Doom/Spaceline.

;;; Code:

;; Add icons to Dired (file listing) mode.
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; --- Minor Mode Lighters ---
;; Collapse minor-mode lighters into a single button instead of listing them
;; all out, replacing the old per-mode `diminish' package/calls.
(setopt mode-line-collapse-minor-modes t)

;; Simple Mode-Line
(require 'simple-modeline)
(with-eval-after-load 'simple-modeline
  ;; Use a more minimal format.
  (setq simple-modeline-format
        '(:buffer-name
          (:git simple-modeline-git-branch)
          (:read-only simple-modeline-read-only)
          "  " ;; Some extra spacing
          :eglot
          :major-mode
          " "
          :perc))

  ;; Use a subtle, blended background color instead of a solid block.
  (setq simple-modeline-bg-blending t)

  ;; Enable the mode.
  (simple-modeline-mode 1))

(provide 'core-modeline)
;;; core-modeline.el ends here
