(in-package :quicklisp-xref)

;;; Routes
(push
 (hunchentoot:create-static-file-dispatcher-and-handler
  "/style.css" (merge-pathnames *application-directory* "style.css"))
 hunchentoot:*dispatch-table*)

(push
 (hunchentoot:create-static-file-dispatcher-and-handler
  "/jquery-2.1.1.min.js" (merge-pathnames *application-directory* "jquery-2.1.1.min.js"))
 hunchentoot:*dispatch-table*)

(hunchentoot:define-easy-handler (uri0 :uri "/") ()
  (home-page))

(hunchentoot:define-easy-handler (uri1 :uri "/dists") ()
  (dists))

(hunchentoot:define-easy-handler (uri2 :uri "/dist") ()
  (dist))

;; (hunchentoot:define-easy-handler (js1 :uri "/javascript.js") ()
;;   (setf (hunchentoot:content-type*) "text/javascript")
;;   (app-js))
