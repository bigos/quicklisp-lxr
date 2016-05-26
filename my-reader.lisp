(defun my-read-file (path)
  (with-open-file (s path)
    (loop for zzz = (read s nil :eof)
       until (eq zzz :eof)
       collect zzz
       ;; do (format t "~%~s~%" zzz)
         )))

;; example use
;; (format t "~%~s~%" (nth 4 (my-read-file "~/Programming/quicklisp-xref/htmlizer.lisp")))
