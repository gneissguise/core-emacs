;;; core-org.el --- Customizations for Org Mode -*- lexical-binding: t; -*-

;;; Commentary:
;;; All settings related to Org Mode live here.

;;; Code:

(require 'org)
(require 'compile)

;; --- 1. Core File & Directory Setup ---
;; Define the home for all Org-related files.
(setq org-directory (expand-file-name "~/org"))

;; Set the files to be used by the Org Agenda.
(setq org-agenda-files (list (expand-file-name "inbox.org" org-directory)
                             (expand-file-name "tasks.org" org-directory)))

;; --- 2. GTD (Getting Things Done) Setup ---

;; Define our custom TODO keywords for the GTD workflow.
;; (t) = TODO, (n) = NEXT, (w) = WAITING
;; | (pipe) separates active states from done states.
;; (d) = DONE, (c) = CANCELLED
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;; Give our custom keywords some nice colors.
(setq org-todo-keyword-faces
      '(("NEXT" . (:foreground "sky blue" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("DONE" . (:foreground "green"))
        ("CANCELLED" . (:foreground "red"))))

;; Automatically add a timestamp when a task is marked as DONE.
(setq org-log-done 'time)

;; Configure Org Capture for fast, global note and task entry.
;; This is the "Inbox" for your GTD system.
(setq org-capture-templates
      '(("t" "Task" entry (file "inbox.org")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:"
         :headline-levels 1 :empty-lines-before 1)
        
        ("n" "Note" entry (file "notes.org")
         "* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n\n%i\n"
         :headline-levels 1 :empty-lines-before 1)))


;; --- 3. Org Modern (Visual Enhancements) ---

;; Enable org-modern for a cleaner, more modern look.
(add-hook 'org-mode-hook #'org-modern-mode)
;; Enable structure-based indentation.
(setq org-modern-indent t)


;; --- 4. General UI & Behavior ---

;; Use a nicer-looking ellipsis for folded headlines.
(setq org-ellipsis "…")

;; Start Org buffers with indentation enabled.
(setq org-startup-indented t)

;; Hide the emphasis markers (*bold*, /italic/) for a cleaner look.
(setq org-hide-emphasis-markers t)


;; --- 5. Agenda Configuration ---

;; Create a custom "GTD Dashboard" for your agenda.
(setq org-agenda-custom-commands
      '(("d" "GTD Dashboard"
         ((agenda "" ((org-agenda-span 'day)))
          (todo "NEXT" ((org-agenda-overriding-header "Next Actions")))
          (todo "WAITING" ((org-agenda-overriding-header "Waiting For")))
          (todo "TODO" ((org-agenda-overriding-header "Unprocessed Inbox")
                        (org-agenda-files (list (expand-file-name "inbox.org" org-directory)))))))))

;; --- 6. Global Keybindings ---

;; These are the standard, highly recommended keys for Org's core workflow.
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)

;; Automatically execute Emacs Lisp source blocks without confirmation.
;; This will still prompt for other languages like shell, python, etc.,
;; which is a good security practice.
(setq org-confirm-babel-evaluate (lambda (lang body) (not (string= lang "emacs-lisp"))))

(provide 'core-org)
;;; core-org.el ends here
