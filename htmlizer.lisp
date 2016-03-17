(in-package #:quicklisp-xref)

(defun creation-date-time ()
  (multiple-value-bind
        (second minute hour date month year day-of-week dst-p tz)
      (get-decoded-time)
    (declare (ignorable tz dst-p day-of-week second))
    (format nil "generated on ~d:~2,'0d ~d/~2,'0d/~d"
            hour
            minute
            date
            month
            year)))

(defun style-file-content ()
  (let ((data))
    (with-open-file (stream "/etc/passwd")
      (setf data (make-string (file-length stream) :initial-element #\space))
      (read-sequence data stream))
    data))

(defun dist-html-path (dist)
  (cl-fad:merge-pathnames-as-file quicklisp:*quicklisp-home*
                                  (make-pathname :name (ql-dist:name dist)
                                                 :type "html")))

(defun htmlizer ()
  (let ((zero 0))
    (loop for dist in (ql-dist:all-dists)
       for html-path = (dist-html-path dist)
       do
         (format T "~&creating ~A cross reference~%" (ql-dist:name dist))
         (with-open-file (s html-path :direction :output :if-exists :supersede)
           (who:with-html-output (s)
             (:html
              (:head
               (:title (who:fmt (ql-dist:name dist)))
               (:style (who:fmt (style-file-content))))
              (:body
               (:h1 (who:fmt (ql-dist:name dist)))
               (:div
                (:p "distinfo goes here")
                )
               (:h2 "systems")
               (:footer (who:fmt "~a" (creation-date-time)))
               ))))
         (format t "~&created ~a~%" html-path))))
