;;; core-programming-clojure.el --- Configuration for Clojure -*- lexical-binding: t; -*-

;;; Commentary:
;;; Sets up a modern Clojure environment with CIDER-like features.

;;; Code:

;; --- Clojure Tree-sitter Mode ---
(require 'clojure-ts-mode)
(add-to-list 'major-mode-remap-alist '(clojure-mode . clojure-ts-mode))


;; --- Auto-formatting on Save ---
(defun my-clojure-format-buffer-on-save ()
  "Automatically indent and format the buffer before saving."
  (interactive)
  (indent-region (point-min) (point-max)))


;; --- Custom Clojure Commands ---
(defun my-clojure-jack-in (aliases)
  "Start a Clojure REPL process with user-selected aliases."
  (interactive
   (list (read-string "Aliases (e.g., :socket:dev:rebel :portal): "
                      nil nil ":socket:dev:rebel")))
  (let* ((project-root (locate-dominating-file default-directory "deps.edn"))
         (default-directory (or project-root default-directory))
         (command (format "clojure -M%s" aliases)))
    (inf-clojure command)))

(defun my-clojure-create-project (name template)
  "Create a new Clojure project using the 'deps-new' tool."
  (interactive
   (list (read-string "Project name (e.g., my-group/my-project): ")
         (read-string "Template to use (e.g., app, lib): " nil nil "app")))
  (let* ((command (format "clojure -Tnew create :name %s :template %s"
                          (shell-quote-argument name)
                          (shell-quote-argument template)))
         (buffer-name (format "*create-project: %s*" name)))
    (message "Running: %s" command)
    (compile command buffer-name)))

(defun my-clojure-lint-with-eastwood ()
  "Run the Eastwood linter on the current project."
  (interactive)
  (let* ((project-root (locate-dominating-file default-directory "deps.edn"))
         (default-directory (or project-root default-directory))
         (command "clojure -M:eastwood"))
    (compile command "*clojure-lint*")))

(defun my-clojure-disconnect-repl ()
  "Disconnect from the REPL by killing its buffer and process."
  (interactive)
  (when-let ((repl-buf (get-buffer "*inf-clojure*")))
    (kill-buffer repl-buf)
    (message "Disconnected from inf-clojure REPL.")))

(defun my-clojure-clear-repl ()
  "Clear the contents of the REPL buffer."
  (interactive)
  (when-let ((repl-win (get-buffer-window "*inf-clojure*")))
    (with-current-buffer (window-buffer repl-win)
      (comint-clear-buffer)
      (message "inf-clojure REPL cleared."))))

(defun my-clojure-eval-buffer ()
  "Evaluate the entire current buffer in the REPL."
  (interactive)
  (inf-clojure-eval-region (point-min) (point-max)))

(defun my-clojure-eval-to-point ()
  "Evaluate the buffer from the beginning to the current point."
  (interactive)
  (inf-clojure-eval-region (point-min) (point)))

(defun my-clojure-macroexpand-1 ()
  "Macroexpand the expression at point once."
  (interactive)
  (inf-clojure-eval-form-in-repl (format "(macroexpand-1 '%s)" (thing-at-point 'sexp))))

(defun my-clojure-macroexpand-all ()
  "Recursively macroexpand the expression at point."
  (interactive)
  (inf-clojure-eval-form-in-repl (format "(macroexpand '%s)" (thing-at-point 'sexp))))

(defun my-clojure-pretty-print-last-sexp ()
  "Pretty-print the last S-expression in the REPL."
  (interactive)
  (inf-clojure-eval-form-in-repl (format "(clojure.pprint/pprint %s)" (thing-at-point 'sexp))))

(defun my-clojure-test-run-all ()
  "Run all tests in the project."
  (interactive)
  (let* ((project-root (locate-dominating-file default-directory "deps.edn"))
         (default-directory (or project-root default-directory))
         (command "clojure -X:test:runner"))
    (compile command "*clojure-tests*")))

(defun my-clojure-test-run-current-ns ()
  "Run tests for the current namespace."
  (interactive)
  (let* ((project-root (locate-dominating-file default-directory "deps.edn"))
         (default-directory (or project-root default-directory))
         (ns (clojure-ts-mode--current-ns))
         (command (format "clojure -X:test:runner :nses '[%s]" ns)))
    (compile command "*clojure-tests*")))

(defun my-clojure-test-run-current-test ()
  "Run the specific test var at point."
  (interactive)
  (let* ((project-root (locate-dominating-file default-directory "deps.edn"))
         (default-directory (or project-root default-directory))
         (test-var (thing-at-point 'symbol))
         (command (format "clojure -X:test:runner :vars '[%s]" test-var)))
    (compile command "*clojure-tests*")))

(defun my-clojure-smart-eval-defun ()
  "Evaluate sexp at point if inside a comment, else eval top-level form."
  (interactive)
  (if (treesit-inside-comment-p)
      (inf-clojure-eval-last-sexp)
    (inf-clojure-eval-defun)))


;; --- Keybindings Setup ---
(defun my-clojure-mode-keys ()
  "Set up keybindings for `clojure-ts-mode`."
  (define-key clojure-ts-mode-map (kbd "C-c h") #'my-show-clojure-cheatsheet)
  (define-key clojure-ts-mode-map (kbd "M-.") #'xref-find-definitions)
  (define-key clojure-ts-mode-map (kbd "M-,") #'xref-pop-marker-stack)
  (define-key clojure-ts-mode-map (kbd "C-c p n") #'my-clojure-create-project)
  (define-key clojure-ts-mode-map (kbd "C-c C-j") #'my-clojure-jack-in)
  (define-key clojure-ts-mode-map (kbd "C-c l") #'my-clojure-lint-with-eastwood)
  (define-key clojure-ts-mode-map (kbd "C-c t a") #'my-clojure-test-run-all)
  (define-key clojure-ts-mode-map (kbd "C-c t n") #'my-clojure-test-run-current-ns)
  (define-key clojure-ts-mode-map (kbd "C-c t t") #'my-clojure-test-run-current-test)
  (with-eval-after-load 'inf-clojure
    (progn
      (define-key clojure-ts-mode-map (kbd "C-c C-d") #'my-clojure-disconnect-repl)
      (define-key clojure-ts-mode-map (kbd "C-c C-l") #'my-clojure-clear-repl)
      (define-key clojure-ts-mode-map (kbd "C-c C-b") #'my-clojure-eval-buffer)
      (define-key clojure-ts-mode-map (kbd "C-c C-p") #'my-clojure-eval-to-point)
      (define-key clojure-ts-mode-map (kbd "C-c C-v") #'inf-clojure-eval-last-sexp-in-repl)
      (define-key clojure-ts-mode-map (kbd "C-c p p") #'my-clojure-pretty-print-last-sexp)
      (define-key clojure-ts-mode-map (kbd "C-c m 1") #'my-clojure-macroexpand-1)
      (define-key clojure-ts-mode-map (kbd "C-c m a") #'my-clojure-macroexpand-all)
      (define-key clojure-ts-mode-map (kbd "C-c C-z") #'inf-clojure-switch-to-repl)
      (define-key clojure-ts-mode-map (kbd "C-c C-e") #'my-clojure-smart-eval-defun)
      (define-key clojure-ts-mode-map (kbd "C-c C-r") #'inf-clojure-eval-region)
      (define-key clojure-ts-mode-map (kbd "C-c C-c") #'inf-clojure-eval-last-sexp))))

;; --- Hook Setups ---

;; This function is run only AFTER Eglot has successfully started.
(defun my-clojure-eglot-hook ()
  "Set up integrations that depend on Eglot being active."
  ;; Now that Eglot is running, we can safely add its eldoc function.
  (add-hook 'eldoc-documentation-functions #'eglot-eldoc-documentation-function nil 'local))

;;(add-hook 'eglot-managed-mode-hook #'my-clojure-eglot-hook)

(setq project-vc-extra-root-markers '(".gitignore" "deps.edn"))
(setq eldoc-echo-area-use-multiline-p nil)


;; This is the main hook for Clojure buffers.
(add-hook 'clojure-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'my-clojure-format-buffer-on-save nil 'local)
            (eldoc-mode 1)
            (eglot-ensure)
            (my-clojure-mode-keys)))


(provide 'core-programming-clojure)
;;; core-programming-clojure.el ends here
