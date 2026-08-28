;;; init.el --- The main entry point for Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;;; This file serves as the main configuration entry point. It loads
;;; essential UI and package settings synchronously, and defers all
;;; other modules to run after startup for speed and reliability.

;;; Code:

;; --- General User Preferences ---
(setq user-full-name "Justin Greisiger Frost"
      user-mail-address "justinfrost@duck.com"
      use-short-answers t
      case-fold-search t
      sentence-end-double-space nil
      kill-whole-line t
      recentf-max-menu-items 25
      recentf-max-saved-items 100
      require-final-newline t
      mouse-yank-at-point t
      scroll-margin 3
      scroll-step 1
      fill-column 90
      inhibit-startup-message t
      bidi-display-reordering nil)
(recentf-mode 1)
(save-place-mode 1)
;; Emacs 31: these two must be set via `setopt', not `setq', and only exist
;; once their libraries are loaded (hence after the mode calls above).
(setopt recentf-autosave-interval 300
        save-place-autosave-interval 300)


;; --- Customization File ---
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


;; --- Load Path Setup ---
;; Third-party packages without an ELPA/MELPA release (e.g. combobulate) live
;; in site-lisp/, which we add explicitly. Emacs 31+ auto-discovers user-lisp/
;; but NOT site-lisp/.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; combobulate.el lives inside site-lisp/combobulate/ (git submodule), not flat under site-lisp/
(add-to-list 'load-path (expand-file-name "site-lisp/combobulate" user-emacs-directory))


;; --- Load ESSENTIAL Configurations ---
;; These are loaded immediately for package management and UI.
(require 'core-packages)
(require 'core-environment)
(require 'core-ui)


;; --- Deferred Configuration ---
;; All other modules are loaded after Emacs is fully initialized.
;; This is the definitive fix for all our load-order errors.
(defun my-load-deferred-configurations ()
  "Load modular configuration files after startup."
  (require 'core-modeline)
  (require 'core-help)
  (require 'core-project)
  (require 'core-completion)
  (require 'core-editing)
  (require 'core-enhancements)
  (require 'core-programming)
  (require 'core-programming-clojure)
  (require 'core-org)
  (require 'core-latex)
  (require 'core-backups)
  (require 'core-cheatsheet))

(add-hook 'emacs-startup-hook #'my-load-deferred-configurations)


;; --- Final Garbage Collection Tuning ---
;; This runs after everything is loaded.
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist my--file-name-handler-alist)
            (setq gc-cons-threshold (* 2 1024 1024))
            (run-with-idle-timer 5 t (lambda () (setq gc-cons-threshold (* 8 1024 1024))))))

(provide 'init)
;;; init.el ends here
