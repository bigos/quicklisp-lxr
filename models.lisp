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

(defun asd-files ()
  (loop for s in (quicklisp:system-list)
     for z = (slot-value s 'ql-dist:name)
     for r = (slot-value s 'ql-dist:release)
     collect (list z (slot-value r 'ql-dist:system-files))))

(defun mapc-directory-tree (fn directory &key (depth-first-p t))
  (dolist (entry (cl-fad:list-directory directory))
    (unless depth-first-p
      (funcall fn entry))
    (when (cl-fad:directory-pathname-p entry)
      (mapc-directory-tree fn entry))
    (when depth-first-p
      (funcall fn entry))))

(defun system-folder (system-name)
  (ql:where-is-system system-name))

(defun recursive-files (system-name)
  (let ((my-file-list))
    (mapc-directory-tree
     (lambda (x) (push x my-file-list))
     (system-folder system-name))
    my-file-list))

;; this gives me heap exhausted warning
;; (xref:xref-file (elt  (check-files :alexandria)3))

;; another stack problem
;; (first (recursive-files :md5))

;;; ==============================================================================

;;; finding more
;; QUICKLISP-XREF>  (slot-value  (nth 31 (ql:system-list)) 'ql-dist:release)
;; #<QL-DIST:RELEASE anaphora-0.9.4 / quicklisp 2016-02-08>
;; C-c C-d d on the above gives interesting info

;;; slots of system
;; (type-of (nth 31 (ql:system-list)))
;; QL-DIST:SYSTEM
;; SYSTEM names the standard-class #<STANDARD-CLASS QL-DIST:SYSTEM>:
;;   Class precedence-list: QL-DIST:SYSTEM, QL-DIST::PREFERENCE-MIXIN,
;;                          STANDARD-OBJECT, SB-PCL::SLOT-OBJECT, T
;;   Direct superclasses: QL-DIST::PREFERENCE-MIXIN
;;   No subclasses.
;;   Direct slots:
;;     QL-DIST:NAME
;;       Initargs: :NAME
;;       Readers: QL-DIST:SHORT-DESCRIPTION, QL-DIST:NAME
;;       Writers: (SETF QL-DIST:NAME)
;;     QL-DIST:SYSTEM-FILE-NAME
;;       Initargs: :SYSTEM-FILE-NAME
;;       Readers: QL-DIST:SYSTEM-FILE-NAME
;;       Writers: (SETF QL-DIST:SYSTEM-FILE-NAME)
;;     QL-DIST:RELEASE
;;       Initargs: :RELEASE
;;       Readers: QL-DIST:PREFERENCE-PARENT, QL-DIST:RELEASE
;;       Writers: (SETF QL-DIST:RELEASE)
;;     QL-DIST:DIST
;;       Initargs: :DIST
;;       Readers: QL-DIST:DIST
;;       Writers: (SETF QL-DIST:DIST)
;;     QL-DIST:REQUIRED-SYSTEMS
;;       Initargs: :REQUIRED-SYSTEMS
;;       Readers: QL-DIST:REQUIRED-SYSTEMS
;;       Writers: (SETF QL-DIST:REQUIRED-SYSTEMS)
;;     QL-DIST:METADATA-NAME
;;       Initargs: :METADATA-NAME
;;       Readers: QL-DIST:METADATA-NAME
;;       Writers: (SETF QL-DIST:METADATA-NAME)

;; also examine
;; (slot-value (nth 31 (ql:system-list)) 'ql-dist:dist)
;; (slot-value (nth 31 (ql:system-list)) 'ql-dist:release)

;; note ::
;; (slot-value (slot-value (nth 31 (ql:system-list)) 'ql-dist:dist) 'ql-dist::system-index)
;; returns hash table?
;; yes!!!

;; (type-of (slot-value (slot-value (nth 31 (ql:system-list)) 'ql-dist:dist) 'ql-dist::system-index))
;; HASH-TABLE

;; iterating the hash table
;; (maphash #'(lambda (k v) (format t "~&~A ~A~%" k v)) (slot-value (slot-value (nth 31 (ql:system-list)) 'ql-dist:dist) 'ql-dist::system-index))
;; so system objects can be accessed by name!!!

;; what is cdb in
;; (ql-cdb:lookup )

;; dists on the system
;; (ql-dist:all-dists )
;; (#<QL-DIST:DIST quicklisp 2016-02-08>)

;; list of all release objects
;; (ql-dist:provided-releases (car (ql-dist:all-dists)) )

;; searching systems by name
;; (ql-dist:system-apropos-list "babel")
;; (ql:system-apropos-list "babel") <<- is this the same as above?
;; (#<QL-DIST:SYSTEM babel / babel-20150608-git / quicklisp 2016-02-08>
;;                   #<QL-DIST:SYSTEM babel-streams / babel-20150608-git / quicklisp 2016-02-08>
;;                   #<QL-DIST:SYSTEM babel-tests / babel-20150608-git / quicklisp 2016-02-08>)

;; list of all systems
;; (ql-dist:system-apropos-list "")

;; systems containing letter x in name
;; (ql-dist:system-apropos-list "x")

;; system dependencies
;; (ql:who-depends-on "md5")
;; ("bknr.modules" "bknr.utils" "bknr.web" "cl-mongo-id" "cl-postgres"
;;                 "cl-scrobbler" "cl-xul" "cleric" "clickr" "clsql-helper"
;;                 "clsql-postgresql-socket" "clsql-postgresql-socket3" "gravatar" "hunchentoot"
;;                 "ixf" "nuclblog" "odesk" "tbnl" "toot")
