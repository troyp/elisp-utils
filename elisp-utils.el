;;; elisp-utils.el ---

;; Copyright (C) 2017 Troy Pracy

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:


(defun elu-copy-md-sig-and-doc (&optional github)
  "Extract signature and documentation for a function/macro in markdown format.

If GITHUB is non-nil, format the signature as a link pointing to the documentation
below."
  (interactive)
  (let* ((def (sexp-at-point))
         (name (cadr def))
         (sig  (caddr def))
         (vars (seq-remove (lambda (var) (string-prefix-p "&" var))
                           (mapcar #'symbol-name sig)))
         (uppercase-vars (mapcar #'upcase vars))
         ;; TODO: handle \(fn ) macro signature at end of docstring
         (var-regexp (concat "\\(" (mapconcat #'identity uppercase-vars "\\|") "\\)"))
         (docstr (if (stringp (cadddr def)) (cadddr def) ""))
         (fragment-id (replace-regexp-in-string "[&()]" ""
                                                (replace-regexp-in-string " " "-"
                                                                          (format "%S-%S" name sig))))
         (md-sig (if github (format "* [%S](#%s) `%S`" name fragment-id sig)
                   (format "* %S `%S`" name sig)))
         (docstr-1 (with-temp-buffer
                     (insert docstr)
                     (goto-char 0)
                     (while (re-search-forward var-regexp nil t)
                       (replace-match (format "`%s`" (downcase (match-string 0)))
                                      t nil))
                     (buffer-string)))
         (md-def-raw (format "### %S `%S`\n\n%s" name sig docstr-1))
         (md-def (replace-regexp-in-string "`\\([^']+\\)'" "`\\1`" md-def-raw)))
    (kill-new md-def)
    (kill-new md-sig)))


(provide 'elisp-utils)

;;; elisp-utils ends here
