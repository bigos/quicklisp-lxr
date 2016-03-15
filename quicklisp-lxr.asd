;;;; quicklisp-lxr.asd

(asdf:defsystem #:quicklisp-lxr
  :description "Describe quicklisp-lxr here"
  :author "Jacek Podkanski <ruby.object@googlemail.com>"
  :license "GPLv3, except xref.lisp file"
  :depends-on (:restas :cl-fad :parenscript :cl-who)
  :serial t
  :components ((:file "package")
               (:file "quicklisp-lxr")
               (:module "xref"
                        :components ((:file "xref")))
               (:file)
               ))
