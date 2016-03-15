(in-package :quicklisp-xref)

(defun default-layout (content)
  (who:with-html-output-to-string (out)
    (:html
     (:head
      (:title "layout")
      (:link :href "/style.css" :media "all" :rel "stylesheet" :type "text/css")
      (:script :src "jquery-2.1.1.min.js")
      (:script :src "/javascript.js" ))
     (:body
      (:h1 "In Layout")

      (:div
       (:a :href "/" "see the index")
       (:span :style "margin:0 2em;" "|")
       (:a :href "/about_me?name=Jacek&language=Lisp" "info about me")
       (:span :style "margin:0 2em;" "|")
       (:a :href "/hunchentoot-doc.html" "Documentation"))
      (:hr))

     (who:fmt "~A" content)
     (:footer "footer"))))

(defun home-page-view ()
  (who:with-html-output-to-string (out)
    (:h1 "Welcome")
    (:p "This is Home Page" )
    (:a :href "/faa" "More")))
