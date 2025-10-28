;;; core-ui.el --- User interface refinements -*- lexical-binding: t; -*-

;;; Commentary:
;;; Tweaks to make the Emacs UI cleaner and more functional. This includes
;;; font, theme, and other visual settings.

;;; Code:

;; --- Font Configuration ---
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 115)

(set-face-attribute 'variable-pitch nil
                    :family "Noto Sans"
                    :height 1.025)


;; --- Modus Themes Customizations ---
;; These variables MUST be set BEFORE the theme is loaded.
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-variable-pitch-ui t
      modus-themes-prompts '(bold)
      modus-themes-completions '((matches . (extrabold underline))
                                (selection . (semibold underline text-also))))

(setq modus-themes-mode-line '((:style accented :height 1.15)))
(setq modus-themes-syntax '(yellow-operators green-strings))

;; Increase the saturation of accent colors for more vibrancy.
(let ((saturate-percentage 25))
  (setq modus-themes-color-overrides
        `((,saturate-percentage
           red-intense red-faint
           green-intense green-faint
           yellow-intense yellow-faint
           blue-intense blue-faint
           magenta-intense magenta-faint
           cyan-intense cyan-faint))))

;; Override the core color palette for deep customization.
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

;; Override specific faces for one-off tweaks.
;; (setq modus-themes-custom-faces
;;       '(;; Make the fill-column indicator line a subtle, static grey.
;;         (fill-column-indicator . (:foreground "#151514"))))


;; --- Theme Loading ---
(when (package-installed-p 'modus-themes)
  (load-theme 'modus-vivendi t))


;; --- General Visual Tweaks ---
(setq initial-scratch-message nil)
(blink-cursor-mode 1)
(setq visible-bell t)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq search-highlight t
      query-replace-highlight t)

(provide 'core-ui)
;;; core-ui.el ends here
