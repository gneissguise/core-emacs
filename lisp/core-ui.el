;;; core-ui.el --- User interface refinements -*- lexical-binding: t; -*-

;;; Commentary:
;;; Tweaks to make the Emacs UI cleaner and more functional. This includes
;;; font, theme, and other visual settings.

;;; Code:

;; --- Font Configuration ---
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 120)

(set-face-attribute 'variable-pitch nil
                    :family "Noto Sans"
                    :height 0.85)


;; --- Modus Themes Customizations ---
;; These variables MUST be set BEFORE the theme is loaded.
;; NOTE: `modus-themes-prompts' and `modus-themes-completions' are obsolete
;; since modus-themes 5.3.0. Bold prompts/completions are now controlled
;; entirely by `modus-themes-bold-constructs'.
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-variable-pitch-ui t)

;; NOTE: the old `modus-themes-color-overrides' saturation-percentage syntax
;; (a "(PERCENTAGE . COLORS)" spec) no longer exists in modus-themes 5.x and
;; is not expressible via `modus-themes-common-palette-overrides', which only
;; accepts "(KEY VALUE)" palette-key overrides. That saturation boost has been
;; dropped rather than emulated.
(setq modus-themes-common-palette-overrides
      '(;; Core Colors
        (bg-main "#0f0f0e")
        (fg-main "#dfdfdf")
        (bg-dim "#0f0f0e")

        ;; Mode Line Colors
        (border-mode-line-active "#321e2a")
        (bg-mode-line-active "#24161e")
        (fg-mode-line-active "#ffffff")

        (comment "#45ba58")
        (fill-column-indicator "#151514")))


;; --- Theme Loading ---
(load-theme 'modus-vivendi t)


;; --- General Visual Tweaks ---
(setq initial-scratch-message nil)
(blink-cursor-mode 1)
(setq visible-bell t)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
;; Right-click contextual menu, including the built-in "Send to..." item.
(context-menu-mode 1)
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq search-highlight t
      query-replace-highlight t)

(provide 'core-ui)
;;; core-ui.el ends here
