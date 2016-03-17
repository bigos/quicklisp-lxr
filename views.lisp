(in-package :quicklisp-xref)

(defun default-layout (content)
  (who:with-html-output-to-string
   (out)
   (:html
    (:head
     (:title "layout")
     (:link :href "/style.css" :media "all" :rel "stylesheet" :type "text/css")
     (:script :src "jquery-2.1.1.min.js")
     (:script :src "/javascript.js" ))
    (:body
     (:h1 "Application Layout")

     (:div
      (:a :href "/" "root")
      (:span :style "margin:0 2em;" "|")
      (:a :href "/dists" "dists")
      (:span :style "margin:0 2em;" "|")
      )
     (:hr))

    (who:fmt "~A" content)
    (:footer "footer")
    (:p (who:fmt "~A" (pp-object hunchentoot:*request*)))
    )))

(defun home-page-view ()
  (who:with-html-output-to-string
   (out)
   (:h1 "Quicklisp folder")
   (:p (who:fmt "~A" *quicklisp-software-folder*))
   (loop for f in (cl-fad:list-directory *quicklisp-software-folder*) do
         (who:htm
          (:h3 (who:fmt "~a" (last-folder-part f)))
          (:div
           (loop for i in (cl-fad:list-directory f) do ;need recursive search instead
                 (who:htm
                  (:span (who:fmt "~A" i))
                  (:br))))))))

(defun dists-view ()
  (who:with-html-output-to-string
      (out)
    (:h1 "Dists found on this system")
    (:ul
     (loop for d in (ql-dist:all-dists)
        for id = 0 then (1+ id)
        do
          (who:htm
           (:li
            (:a :href (format nil "dist?id=~a" id) (who:fmt "~A" (ql-dist:name (nth id (ql-dist:all-dists)))))))))))

(defun dist-view (dist-obj)
  (who:with-html-output-to-string
      (out)
    (:h1 (who:fmt "Dist: ~A" 1))
    (:p "todo")
    (:p (who:fmt "~A" (pp-object dist-obj)))))
