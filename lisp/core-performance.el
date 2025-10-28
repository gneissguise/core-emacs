;;; core-performance.el --- Performance-related settings -*- lexical-binding: t; -*-

;;; Commentary:
;;; General performance improvements for a responsive Emacs experience.

;;; Code:

;; By default, Emacs tries to be clever about detecting file types (like
;; gpg-encrypted or compressed files) on every file operation. This adds
; a small overhead. Disabling it makes file operations faster. You can
;; still open these files explicitly. This is a significant, often
;; overlooked, performance boost for file-heavy operations.
(setq file-name-handler-alist nil)

;; When running async processes, don't wait for too much output.
(setq read-process-output-max (* 1024 1024)) ;; 1 MB

(provide 'core-performance)
;;; core-performance.el ends here

