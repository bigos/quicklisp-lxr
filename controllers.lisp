(in-package :quicklisp-xref)

(defun home-page ()
  (default-layout  (home-page-view)))

(defun dists ()
  (default-layout (dists-view)))

(defun dist ()
  (setf hunchentoot:*catch-errors-p* nil) ; go to debugger on error
  (let* ((params (hunchentoot:get-parameters hunchentoot:*request*))
         (dist-obj (car (ql-dist:all-dists)))) ; no other dist selection atm
    (default-layout (dist-view dist-obj))))
