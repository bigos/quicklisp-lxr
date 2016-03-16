;;; Mon Jan 21 15:43:39 1991 by Mark Kantrowitz <mkant@GLINDA.OZ.CS.CMU.EDU>
;;; xref-test.lisp

;;; ****************************************************************
;;; Test Source File for XREF **************************************
;;; ****************************************************************
;;;
;;; This file contains source code to be used to test XREF.
;;;
;;; Evaluating the following commented out code should produce the
;;; listed output.
;;;
#|
<cl> (xref:xref-file "xref-test.lisp")
Cross-referencing file XRef/xref-test.lisp.
......
6 forms processed.
<cl> (xref:print-caller-trees)

Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
           PROCESS-KEYS
           SNARF-ITEM
           PROCESS-KEY
              SYMBOL-NAME-KEY
           NODE-POSITION
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION
NIL
<cl> (xref:print-caller-trees :compact t)

Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION
NIL
<cl> (xref:list-callers 'frowz)

(BARF TOP-LEVEL)
T
<cl> (xref:list-users 'items)

NIL
NIL
(FROWZ BARF FROB)
|#

;;; ********************************
;;; Test Source Program ************
;;; ********************************

(defun top-level () 
  "Top level function with null lambda list."
  (let* ((input (read))
	 (key (car input)))
    (declare (special key))
    (case key
      (quit
       (return (values (frob (rest input)) 'quit)))
      (otherwise
       (cond ((member key '(foo bar baz))
	      (barf key (rest input)))
	     (t
	      (frowz (rest input) :key key)))))))

(defun frob (items)
  "Here we test mapcar."
  (mapcar #'frob-item items))
(defun frob-item (item)
  "Here we test apply."
  (apply #'append-frobs item))
(defun barf (key &optional items)
  "Optional args test."
  (cons key (frowz items)))
(defun frowz (items &key key)
  "Keyword args test."
  (dolist (item items)
    (let ((frowz (if (eq key 'quit)
		     (intern (format nil "FOO~A" 
				     (round (+ (length (process-keys items))
					       10))) 'keyword)
		     (snarf-item item))))
      (when (string-equal frowz (process-key key))
	(setf (node-position key) 12)
	(return frowz)))))
(defun process-key (key)
  (funcall #'symbol-name-key key))

;;; *EOF*
