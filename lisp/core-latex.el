;;; core-latex.el --- Configuration for LaTeX and Org exporting -*- lexical-binding: t; -*-

;;; Commentary:
;;; Configures Org Mode's LaTeX exporter for high-quality PDF generation.

;;; Code:

;; Defer all configuration until after Org's LaTeX exporter ('ox-latex') is loaded.
;; This ensures all the necessary LaTeX-specific variables are available.
(with-eval-after-load 'ox-latex
  (progn
    ;; Add the 'moderncv' class to Org's list of known LaTeX classes.
    ;; This is the key fix. We tell Org that 'moderncv' exists and that it
    ;; should treat Org headlines like it does for a standard article.
    (add-to-list 'org-latex-classes
                 '("moderncv"
                   "\\documentclass{moderncv}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")))

    ;; Tell Org that it's okay to execute LaTeX source blocks.
    (add-to-list 'org-src-lang-modes '("latex" . latex))

    ;; Now that Org knows about the class, we can use the simple, direct
    ;; command for PDF processing.
    (setq org-latex-pdf-process
          '("latexmk -shell-escape -pdf -f %f"))

    ;; Set the default LaTeX compiler. 'pdflatex' is a safe and common choice.
    (setq org-latex-compiler "pdflatex")

    ;; This allows Org to properly handle advanced LaTeX features.
    (setq org-latex-listings 'listings)))

(provide 'core-latex)
;;; core-latex.el ends here
