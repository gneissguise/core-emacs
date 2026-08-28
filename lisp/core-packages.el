;;; core-packages.el --- Declarative package management -*- lexical-binding: t; -*-

;;; Commentary:
;;; This file sets up package.el and ensures that all required
;;; packages are installed.

;;; Code:

;; Initialize the package system. This must be done before using
;; any package commands.
(require 'package)

;; Define the package archives. We include GNU ELPA (the default)
;; and MELPA, which has a much larger collection of packages.
(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Initialize the package system with our new archives.
(package-initialize)

;; It is slow to refresh the package contents on every startup.
;; This check ensures we only do it once, when Emacs starts and
;; the package contents haven't been fetched yet.
(unless package-archive-contents
  (package-refresh-contents))

;; --- Declare Desired Packages ---
;; This is the declarative part. We define a list of all the packages
;; we want to have available
(defconst my-packages
  '(;; Core Theme:
    modus-themes

    ;; UI and Navigation Enhancements (which-key is third-party; avy is lightweight alternative)
    ace-window
    avy
    git-gutter
    recursion-indicator

    ;; Completion System (Vertico/Consult/Marginalia/Tempel/Cape)
    cape
    consult
    consult-flycheck
    marginalia
    tempel
    vertico

    ;; Syncs the shell environment with Emacs (may still be useful for non-standard shells)
    exec-path-from-shell

    ;; Modeline enhancements
    nerd-icons
    nerd-icons-dired
    nerd-icons-corfu
    simple-modeline

    ;; Programming libs (eglot is built-in since Emacs 26.1; inf-clojure for REPL)
    inf-clojure

    ;; Version Control
    goggles
    magit
    magit-todos
    magit-delta

    ;; Org mode enhancements
    org-modern

    ;; VS Code-like editing features
    move-text
    multiple-cursors)
  "A list of packages to ensure are installed.")

;; --- Installation Logic ---
;; Loop through the list of packages. If a package is not installed,
;; install it.
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(provide 'core-packages)
;;; core-packages.el ends here
