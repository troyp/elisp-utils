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


(defun elu-copy-md-sig-and-doc ()
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


(provide 'elisp-utils)

;;; elisp-utils ends here
