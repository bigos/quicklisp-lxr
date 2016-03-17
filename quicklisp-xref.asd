;;;; quicklisp-xref.asd

(asdf:defsystem #:quicklisp-xref
  :description "Describe quicklisp-lxr here"
  :author "Jacek Podkanski <ruby.object@googlemail.com>"
  :license "GPLv3, except xref.lisp file"
  :depends-on (:hunchentoot :cl-fad :parenscript :cl-who)
  :serial t
  :components ((:file "package")
               (:file "config")
               (:file "quicklisp-xref")
               (:module "xref"
                        :pathname "xref"
                        :components ((:file "xref")))
               (:file "routes")
               (:file "models")
               (:file "views")
               (:file "controllers")
               (:file "javascript")
               (:file "htmlizer")))
