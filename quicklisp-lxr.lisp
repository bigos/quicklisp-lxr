;;;; quicklisp-lxr.lisp

(in-package #:quicklisp-lxr)

(defvar *quicklisp-software-folder* (concatenate 'string
                                                 (directory-namestring
                                                  (user-homedir-pathname))
                                                 "quicklisp/dists/quicklisp/software/"))
(defun folder-content ()
  (cl-fad:list-directory quicklisp-lxr::*quicklisp-software-folder*))

(restas:define-module #:restas.hello-world
  (:use :cl))

(in-package #:restas.hello-world)

(restas:define-route main ("")
  (who:with-html-output-to-string (out)
    (:html
     (:body
      (:h1 "Hello everyone!")
      (:p (format out "directory listning of ~A"
                  quicklisp-lxr::*quicklisp-software-folder*))
      (:p (loop for f in (quicklisp-lxr::folder-content) do
               (format out "~a<br>" f)
               ))
      ))))

;; (restas:start '#:restas.hello-world :port 8080)
