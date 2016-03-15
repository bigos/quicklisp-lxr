;;;; quicklisp-lxr.lisp

(in-package #:quicklisp-lxr)

;;; "quicklisp-lxr" goes here. Hacks and glory await!


(restas:define-module #:restas.hello-world
    (:use :cl))

(in-package #:restas.hello-world)

(restas:define-route main ("")
  "<h1>Hello world!</h1>")

(restas:start '#:restas.hello-world :port 8080)
