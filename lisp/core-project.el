;;; core-project.el --- Workflow and project management -*- lexical-binding: t; -*-

;;; Commentary:
;;; Contains settings to streamline common workflows and project management.

;;; Code:

;; We must require the built-in libraries before using their functions.
(require 'project)
(require 'window)

;; --- Smarter Window Management ---
;; We are removing the (setq display-buffer-alist ...) configuration
;; to avoid calling the missing 'display-buffer-other-window' function.
;; Org-mode will now use its default behavior to show capture buffers.


;; --- Custom Project Commands ---
(defun crafted-consult-project-find ()
  "Find a file in the current project."
  (interactive)
  (let ((project-root (project-root (project-current))))
    (when project-root
      (let ((default-directory project-root))
        (consult-find)))))

(defun crafted-project-switch-and-open-file ()
  "Switch to a project and immediately find a file in it."
  (interactive)
  (let ((project (project-read-project-name (project-known-project-roots))))
    (project-switch-project project)
    (crafted-consult-project-find)))

(defun crafted-project-open-readme ()
  "Find and open the README file for the current project."
  (interactive)
  (let* ((project-root (project-root (project-current)))
         (readme-files '("README.md" "README.org" "README.txt" "README")))
    (when project-root
      (let ((default-directory project-root))
        (find-file (cl-find-if #'file-exists-p readme-files))))))


;; --- Keybindings ---
(global-set-key (kbd "C-c p p") #'crafted-project-switch-and-open-file)
(global-set-key (kbd "C-c p f") #'crafted-consult-project-find)
(global-set-key (kbd "C-c p r") #'crafted-project-open-readme)


(provide 'core-project)
;;; core-project.el ends here
