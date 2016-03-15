(restas:define-module #:restas.xref
  (:use :cl))

(in-package #:restas.xref)

(defvar *quicklisp-software-folder* (concatenate 'string
                                                 (directory-namestring
                                                  (user-homedir-pathname))
                                                 "quicklisp/dists/quicklisp/software/"))
(defun folder-content ()
  (cl-fad:list-directory *quicklisp-software-folder*))

;;; make sure we have log folder
(ensure-directories-exist #P"/tmp/hunchentoot/")

;;; specify log destination
(defclass acceptor (restas:restas-acceptor)
  ()
  (:default-initargs
   :access-log-destination #P"/tmp/hunchentoot/access_log"
   :message-log-destination #P"/tmp/hunchentoot/error_log"))

(restas:define-route main ("")
  (who:with-html-output-to-string (out)
    (:html
     (:body
      (:h1 "Hello everyone!")
      (:p (format out "directory listning of ~A"
                  *quicklisp-software-folder*))
      (:p (loop for f in (folder-content) do
               (who:htm
                (:span (format out "~A" f))
                (:br))
               (loop for i in (cl-fad:list-directory f do
                                                     ))))))))

(restas:start '#:restas.hello-world :port 8080  :acceptor-class 'acceptor)
