(in-package :quicklisp-xref)

;;; Routes
(push
 (hunchentoot:create-static-file-dispatcher-and-handler
  "/style.css" (merge-pathnames (concatenate 'string
                                             (directory-namestring
                                              (user-homedir-pathname))
                                             "Programming/quicklisp-xref/style.css")))
 hunchentoot:*dispatch-table*)

;;; not using JS yet
;; (push
;;  (hunchentoot:create-static-file-dispatcher-and-handler
;;   "/jquery-2.1.1.min.js" (merge-pathnames *application-directory* "jquery-2.1.1.min.js"))
;;  hunchentoot:*dispatch-table*)

;; (hunchentoot:define-easy-handler (uri1 :uri "/faa") ()
;;   (faa1))

;; (hunchentoot:define-easy-handler (uri2 :uri "/about_me") ()
;;   (foo1))

(hunchentoot:define-easy-handler (uri3 :uri "/") ()
  (home-page))

;; (hunchentoot:define-easy-handler (js1 :uri "/javascript.js") ()
;;   (setf (hunchentoot:content-type*) "text/javascript")
;;   (app-js))
