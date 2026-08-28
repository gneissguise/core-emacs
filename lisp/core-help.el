;;; core-help.el --- Configuration for the help system -*- lexical-binding: t; -*-

;;; Commentary:
;;; Replaces the default help system with the more powerful 'helpful' package.

;;; Code:

;; Emacs 31.1+ has helpful built-in, so we can use it directly
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)

(provide 'core-help)
;;; core-help.el ends here
