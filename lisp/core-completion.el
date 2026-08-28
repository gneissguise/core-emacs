;;; core-completion.el --- Configuration for modern completion -*- lexical-binding: t; -*-

;;; Commentary:
;;; This file configures the Vertico/Corfu/Consult/etc. suite of packages
;;; for a fast and effective completion and search experience.

;;; Code:
;; --- Completion: Smart Sorting and Filtering ---
;; Emacs 31.1 has prescient sorting built-in by default. No configuration needed.

;; --- Vertico: The Core Vertical Completion UI ---
;; Replaces the default minibuffer UI with a cleaner, faster vertical display.
(vertico-mode 1)

;; --- Corfu: In-Buffer Completion ---
;; Provides a pop-up completion UI for text being written in the buffer.
(global-corfu-mode 1)
;; Use prescient for sorting Corfu completion candidates.
(setopt corfu-sorter 'prescient)
;; A little bit of configuration for a smoother experience.
(setopt corfu-auto t                 ;; Enable auto-completion
        corfu-auto-delay 0.2)        ;; Show completion popup after 0.2s of inactivity


;; --- Marginalia: Rich Annotations ---
;; Adds helpful annotations to minibuffer completions, explaining what each
;; candidate is (e.g., "Command", "File", "Variable").
(marginalia-mode 1)

;; Add nerd-icons formatter for corfu margins (corfu is built-in, use direct binding)
(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

;; Corfu navigation keybindings (direct binding since corfu is built-in)
(global-set-key (kbd "C-c C-o") #'corfu-next)
(global-set-key (kbd "C-c C-i") #'corfu-previous)


;; --- Consult: Enhanced Search and Navigate Commands ---
;; Provides powerful alternatives to common commands like find-file and switch-to-buffer.
;; We can bind some of these to their standard keys.
;; Ensure consult loads so keybindings are established
(require 'consult)

;; Bind powerful alternatives to their standard keys (direct binding since consult is built-in)
(global-set-key (kbd "C-x b") #'consult-buffer)      ;; Replaces 'switch-to-buffer'
(global-set-key (kbd "M-x") #'execute-extended-command)  ;; Standard Emacs command (consult has no equivalent)
(global-set-key (kbd "C-x C-f") #'consult-find)      ;; Replaces 'find-file'
(global-set-key (kbd "C-s") #'consult-line)         ;; Replaces 'isearch-forward'

;; Add a dedicated command for switching projects with Consult.
(defun my/consult-project-switch ()
  "Switch to another project using Consult."
  (interactive)
  (consult-project-buffer))
(global-set-key (kbd "C-x p s") #'my/consult-project-switch)

;; Bind consult-grep to C-c f for project-wide file content search
(global-set-key (kbd "C-c f") #'consult-grep)

;; --- Cape and Tempel: Completion Sources and Snippets ---
;; Cape provides additional "completion at point" sources.
;; Tempel provides simple, template-based snippet expansion.
(require 'tempel) ;; Ensure tempel functions are loaded

;; Bind Tempel snippet insertion to C-c t (direct binding since tempel is built-in)
(global-set-key (kbd "C-c t") #'tempel-insert)

;; Add more completion sources for Corfu to use.
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'tempel-expand)

;; Bind consult-flycheck to C-c ! for viewing Flycheck diagnostics
(require 'consult-flycheck) ;; Ensure consult-flycheck is loaded
(global-set-key (kbd "C-c !") #'consult-flycheck)

(provide 'core-completion)
;;; core-completion.el ends here
