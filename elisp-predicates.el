
(defun elu--context-at-pos (&optional pos)
  (syntax-ppss-context (syntax-ppss (or pos (point)))))
(defun elu-in-string-p (&optional pos)
  (eq (elu--context-at-pos pos) 'string))
(defun elu-in-comment-p (&optional pos)
  (eq (elu--context-at-pos pos) 'comment))
