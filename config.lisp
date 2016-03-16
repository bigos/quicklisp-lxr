(defvar *separator* #\/)

(defparameter *application-directory* (concatenate 'string
                                             (directory-namestring
                                              (user-homedir-pathname))
                                             "Programming/quicklisp-xref/"))

(defvar *quicklisp-software-folder* (concatenate 'string
                                                 (directory-namestring
                                                  (user-homedir-pathname))
                                                 "quicklisp/dists/quicklisp/software/"))
