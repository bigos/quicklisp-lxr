(in-package #:quicklisp-xref)

(defun dist-html-path (dist)
  (cl-fad:merge-pathnames-as-file quicklisp:*quicklisp-home*
                                  (make-pathname :name (ql-dist:name dist)
                                                 :type "html")))

(defun htmlizer ()
  (format t "starting htmlizer")
  (let ((zero 0))
    (loop for dist in (ql-dist:all-dists)
       for html-path = (dist-html-path dist)
       do
         (format T "~&creating ~A~%" dist)
         (with-open-file (s html-path :direction :output :if-exists :supersede)
           (format s "example output 2")
           )
         (format t "~&created ~a~%" html-path))))
