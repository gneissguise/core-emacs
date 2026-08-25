;;; early-init.el --- The earliest possible customizations for Emacs -*- lexical-binding: t; -*-

;;
;; Author:      Justin Greisiger Frost <justinfrost@duck.com>
;; Maintainer:  Justin Greisiger Frost <justinfrost@duck.com>
;; Created:     August 12, 2025
;;
;;; Commentary:
;;
;; This file contains settings that must be applied before package
;; initialization. Its primary purpose is to speed up Emacs startup
;; by deferring garbage collection and disabling UI elements we do not need.
;;

;;; Code:

;; Defer garbage collection to significantly speed up startup.
;; The default is 800 kilobytes. We're setting it to 100 megabytes.
(setq gc-cons-threshold (* 100 1024 1024))

;; We'll set this again later in init.el, but setting it here
;; ensures that even the startup process itself is faster.
(setq read-process-output-max (* 1024 1024))

;; Temporarily disable the file-name-handler-alist during startup to speed
;; up file operations (this is what actually matters for startup time,
;; since it runs before any file is loaded). It is restored once startup
;; completes in init.el; leaving it disabled permanently breaks TRAMP,
;; encrypted (.gpg) files, and compressed-file auto-decompression.
(defvar my--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Inhibit the splash screen for a faster, cleaner entry.
(setq inhibit-startup-screen t)

;; Disable UI elements before they are even drawn.
;; This is more efficient than disabling them later in init.el.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(provide 'early-init)
;;; early-init.el ends here
