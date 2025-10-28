;;; core-modeline.el --- Customizations for the modeline -*- lexical-binding: t; -*-

;;; Commentary:
;;; Configures a modern, icon-rich modeline similar to Doom/Spaceline.

;;; Code:

;; --- Mode Icons ---
;; This must be run after the 'all-the-icons' package is installed for the first time.
;; M-x all-the-icons-install-fonts
;(require 'major-mode-icons)
;(mode-icons-mode 1)


;; Add icons to Dired (file listing) mode.
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; Add icons to the Corfu completion pop-up.
;; This function decorates the completion candidates.
(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; --- Diminish: Clean up Minor Modes ---
;; Hide unnecessary or distracting minor mode indicators from the modeline.
(require 'diminish)

(diminish 'recursion-indicator-mode)
(diminish 'flycheck-mode)
(diminish 'inf-clojure-mode " REPL")
(diminish 'global-flycheck-mode)
(diminish 'flymake-mode)
(diminish 'eldoc-mode)
(diminish 'eglot-mode)
(diminish 'completion-list-mode)
(diminish 'which-key-mode)
(diminish 'recursion-indicator-mode)
(diminish 'aggressive-indent-mode)
(diminish 'goggles-mode)

;; Simple Mode-Line
(require 'simple-modeline)
;;(simple-modeline-mode)
(with-eval-after-load 'simple-modeline
  (progn
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
    (simple-modeline-mode 1)))

(provide 'core-modeline)
;;; core-modeline.el ends here
