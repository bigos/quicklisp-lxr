(in-package :quicklisp-xref)

(defun home-page ()
  (default-layout  (home-page-view)))

(defun dists ()
  (default-layout (dists-view)))

(defun dist ()
  (setf hunchentoot:*catch-errors-p* nil) ; go to debugger on error
  (let* ((params (hunchentoot:get-parameters hunchentoot:*request*))
         (dist-obj (car (ql-dist:all-dists))) ; no other dist selection atm so we use car
         (systems (ql-dist:provided-systems dist-obj )))
    (default-layout (dist-view dist-obj systems))))

(defun system ()
  (let* ((params (hunchentoot:get-parameters hunchentoot:*request*))
         (system
          (loop for s in (ql:system-list) when (equalp (cdar params) (ql-dist:name s)) return s )))
  (default-layout (system-view system))))
