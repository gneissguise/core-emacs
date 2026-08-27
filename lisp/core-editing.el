;;; core-editing.el --- Text editing enhancements -*- lexical-binding: t; -*-

;;; Commentary:
;;; Settings for a modern, VS Code-like editing experience.

;;; Code:

;; --- Forward Declarations (suppress native compiler warnings) ---
(declare-function move-text-up "move-text")
(declare-function move-text-down "move-text")
(declare-function mc/edit-lines "multiple-cursors")
(declare-function mc/mark-next-like-this "multiple-cursors")
(declare-function mc/mark-previous-like-this "multiple-cursors")
(declare-function mc/mark-all-like-this "multiple-cursors")

;; --- Visual Enhancements ---
;; Highlight the current line to improve focus, except in terminal-emulation
;; buffers where the extra highlight is more distracting than useful.
(global-hl-line-mode 1)
;; Display a subtle vertical line at the fill-column.
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)


(defun my-duplicate-line ()
  "Duplicate the current line or active region."
  (interactive)
  (let (p1 p2)
    (if (use-region-p)
        (setq p1 (region-beginning) p2 (region-end))
      (setq p1 (line-beginning-position) p2 (line-end-position)))
    (let ((text (buffer-substring-no-properties p1 p2)))
      (goto-char p2)
      (when (not (bolp)) (insert "\n"))
      (insert text))))

(global-set-key (kbd "C-c d") #'my-duplicate-line)


;; --- Move Text (VS Code "drag line") ---
(with-eval-after-load 'move-text
  (global-set-key (kbd "M-<up>") #'move-text-up)
  (global-set-key (kbd "M-<down>") #'move-text-down))


;; --- Multiple Cursors ---
(with-eval-after-load 'multiple-cursors
  (global-set-key (kbd "C-S-c C-S-c") #'mc/edit-lines)
  (global-set-key (kbd "C-S-c C-S-n") #'mc/mark-next-like-this)
  (global-set-key (kbd "C-S-c C-S-p") #'mc/mark-previous-like-this)
  (global-set-key (kbd "C-S-c C-S-a") #'mc/mark-all-like-this))


;; --- Other Editing Enhancements ---
(electric-pair-mode 1)
(show-paren-mode 1)
(setopt show-paren-not-in-comments-or-strings 'all)
(delete-selection-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default fill-column 86)
(setq-default show-trailing-whitespace t)

(provide 'core-editing)
;;; core-editing.el ends here
