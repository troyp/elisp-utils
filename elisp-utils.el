
(defun copy-md-sig-and-doc ()
  "Extract signature and documentation for a function/macro in markdown format."
  (interactive)
  (let* ((def (sexp-at-point))
         (name (cadr def))
         (sig  (caddr def))
         (docstr (cadddr def))
         (fragment-id (replace-regexp-in-string "[&()]" ""
                                                (replace-regexp-in-string " " "-"
                                                                          (format "%S" sig))))
         (md-sig (format "* [%S](#%s) `%S`" name fragment-id sig))
         (md-def-raw (format "### %S `%S`\n\n%s" name sig docstr))
         (md-def (replace-regexp-in-string "`\\([^']+\\)'" "`\\1`" md-def-raw))
         )
    (kill-new md-def)
    (kill-new md-sig)))
