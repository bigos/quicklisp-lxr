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
    (with-open-file (stream (cl-fad:merge-pathnames-as-file *application-directory*
                                                            (make-pathname :name "style"
                                                                           :type "css")))
      (setf data (make-string (file-length stream) :initial-element #\space))
      (read-sequence data stream))
    data))

(defun dist-html-path (dist)
  (cl-fad:merge-pathnames-as-file quicklisp:*quicklisp-home*
                                  (make-pathname :name (ql-dist:name dist)
                                                 :type "html")))

(defun system-index (dist)
  (let ((systems (ql-dist:provided-systems dist)))
    (who:with-html-output-to-string (out)
      (loop for s in systems
         for sn = (ql-dist:name s)
         for sh = (format nil "~a~A" "#" (hunchentoot:url-encode sn))
         for sc = (if (ql:where-is-system sn) "installed" "absent")
         do
           (who:htm
            (:a :href sh :class sc (who:fmt "~A" sn))
            (who:fmt ", "))))))

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
               (:div
                (who:fmt "~a" (system-index dist)))
               (:h2 "detailed system info")
               (:footer (who:fmt "~a" (creation-date-time)))
               ))))
         (format t "~&created ~a~%" html-path))))
