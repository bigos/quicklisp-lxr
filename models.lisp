(in-package :quicklisp-xref)

(defun split-by-delimiter (string delimiter)
  "Returns a list of substrings of string
divided by ONE delimiter character"
  (loop for i = 0 then (1+ j)
     as j = (position delimiter string :start i)
     collect (subseq string i j)
     while j))

(defun last-folder-part (folder)
  (car (last (butlast (split-by-delimiter (directory-namestring folder) *separator*)))))

(defun available-system-names ()
  (loop for s in (quicklisp:system-list)
     for z = (slot-value s 'ql-dist:name)
     collect z))

(defun installed-system-paths ()
  (remove-if 'null
             (loop for s in (quicklisp:system-list)
                for z = (slot-value s 'ql-dist:name)
                collect (ql:where-is-system z))))
