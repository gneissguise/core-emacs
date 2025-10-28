;;; core-completion.el --- Configuration for modern completion -*- lexical-binding: t; -*-

;;; Commentary:
;;; This file configures the Vertico/Corfu/Consult/etc. suite of packages
;;; for a fast and effective completion and search experience.

;;; Code:
(require 'prescient)

;; --- Prescient: Smart Sorting and Filtering ---
;; Tell Emacs to use Prescient's advanced filtering and sorting.
(setq completion-styles '(prescient))
;; Save the usage history to a file so it persists across Emacs sessions.
(prescient-persist-mode 1)

;; --- Vertico: The Core Vertical Completion UI ---
;; Replaces the default minibuffer UI with a cleaner, faster vertical display.
(vertico-mode 1)
;; Use the prescient sorter for Vertico.
(setq vertico-prescient-enable t)

;; --- Corfu: In-Buffer Completion ---
;; Provides a pop-up completion UI for text being written in the buffer.
(global-corfu-mode 1)
;; Use prescient for sorting Corfu completion candidates.
(setq corfu-sorter 'prescient)
;; A little bit of configuration for a smoother experience.
(setq corfu-auto t                 ;; Enable auto-completion
      corfu-auto-delay 0.2)        ;; Show completion popup after 0.2s of inactivity


;; --- Marginalia: Rich Annotations ---
;; Adds helpful annotations to minibuffer completions, explaining what each
;; candidate is (e.g., "Command", "File", "Variable").
(marginalia-mode 1)

(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


;; --- Consult: Enhanced Search and Navigate Commands ---
;; Provides powerful alternatives to common commands like find-file and switch-to-buffer.
;; We can bind some of these to their standard keys.
;; We defer the keybindings until after the 'consult' package is loaded.
;; This prevents errors on startup if the commands are not yet defined.
(with-eval-after-load 'consult
  (progn
    ;; Bind powerful alternatives to their standard keys.
    (global-set-key (kbd "C-x b") #'consult-buffer)      ;; Replaces 'switch-to-buffer'
    (global-set-key (kbd "M-x") #'consult-M-x)          ;; Replaces 'execute-extended-command'
    (global-set-key (kbd "C-x C-f") #'consult-find)      ;; Replaces 'find-file'
    (global-set-key (kbd "C-s") #'consult-line)         ;; Replaces 'isearch-forward'

    ;; Add a dedicated command for switching projects with Consult.
    (defun my/consult-project-switch ()
      "Switch to another project using Consult."
      (interactive)
      (consult-project-root (project-known-project-roots)))
    (global-set-key (kbd "C-x p s") #'my/consult-project-switch)))

;; --- Cape and Tempel: Completion Sources and Snippets ---
;; Cape provides additional "completion at point" sources.
;; Tempel provides simple, template-based snippet expansion.
(require 'tempel) ;; Ensure tempel functions are loaded

;; Add more completion sources for Corfu to use.
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'tempel-expand)

(provide 'core-completion)
;;; core-completion.el ends here
