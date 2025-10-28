;;; core-environment.el --- Configure Emacs's interaction with the system -*- lexical-binding: t; -*-

;;; Commentary:
;;; Ensures the Emacs environment matches the user's shell environment.

;;; Code:

;; This is necessary for GUI instances of Emacs to inherit the
;; PATH and other environment variables from your shell. It fixes
;; issues where Emacs can't find command-line tools like 'latexmk'.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(provide 'core-environment)
;;; core-environment.el ends here
