(in-package #:quicklisp-xref)

;;; Instantiate VHOSTs
(defvar vhost1 (make-instance 'hunchentoot:easy-acceptor :port 5000))

;;; Start and Stop
(defun run ()
  (hunchentoot:start vhost1))

(defun stop ()
  (hunchentoot:stop vhost1))

;;; make parenscript work nicely with cl-who
(setf parenscript:*js-string-delimiter* #\")

;;; helpers
(defmacro escaped-string (string)
  `(who:fmt (who:escape-string (format nil "~A" ,string))))


(defun inspect-object (obj)
  (loop for the-slot in (mapcar #'sb-pcl:slot-definition-name (sb-pcl:class-slots (class-of obj)))
     collect (list the-slot  (if (slot-boundp obj the-slot)
                                 (slot-value obj the-slot)
                                 "unbound"))))

;;; pretty print object on a web page
(defun pp-object (obj)
  (with-output-to-string (str)
    (format str "<pre>")
    (format str "~a" (who:escape-string (format nil "~a~%" obj)))
    (loop for the-slot in (mapcar #'sb-pcl:slot-definition-name (sb-pcl:class-slots (class-of obj)))
       do
         (format str "~A~%" (who:escape-string (format nil "~A" (list the-slot  (if (slot-boundp obj the-slot)
                                                                                    (slot-value obj the-slot)
                                                                                    "unbound"))))))
    (format str "</pre>")))
