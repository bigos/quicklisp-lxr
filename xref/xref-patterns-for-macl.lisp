;;; Thu Nov 15 21:50:05 1990 by Mark Kantrowitz <mkant@A.GP.CS.CMU.EDU>
;;; xref-patterns-for-macl.lisp
;;; ****************************************************************
;;; XREF Patterns for MACL ObjectLisp Functions ********************
;;; ****************************************************************
;;;
;;; Written by Rodney Daughtrey, BCS AI Center, Huntsville, AL  
;;; <rodney@huntsai.boeing.com>. Please also send bug reports to
;;; <mkant+@cs.cmu.edu>.
;;;
;;; This file contains XREF patterns defined for use with ObjectLisp
;;; functions in Macintosh Allegro Common Lisp (MACL). They have not
;;; been tested extensively, so there may be bugs. If you find any
;;; bugs, please send them to mkant+@cs.cmu.edu. 
;;;
;;; To Do:
;;;    define patterns for other MACL-specific functions

(define-pattern-substitution keyword-value-pairs
  (:star symbol form))

(define-caller-pattern defobject
  (symbol
   (:star symbol)) 
  :macl)

(define-caller-pattern oneof (form keyword-value-pairs) :macl)
(define-caller-pattern kindof (:star symbol) :macl)
(define-caller-pattern remake-object (form (:optional form)) :macl)
(define-caller-pattern exist (keyword-value-pairs) :macl)

(define-caller-pattern init-list-default
  ((keyword-value-pairs)
   symbol form
   keyword-value-pairs)
  :macl)

(define-caller-pattern ask (:plus form) :macl)
(define-caller-pattern talkto (:optional form) :macl)

(define-caller-pattern defobfun
  ((name form)
   lambda-list
   (:star (:or documentation-string declaration))
   (:star form))
  :macl)

(define-caller-pattern fset (form form) :macl)
(define-caller-pattern fset-globally (form form) :macl)

(define-caller-pattern nfunction
  (symbol 
   ((:eq LAMBDA)
    ((:star symbol))
    (:star form)))
  :macl)

(define-caller-pattern have (form form) :macl)
(define-caller-pattern fhave (form fn) :macl)
(define-caller-pattern makunbound-all (form) :macl)
(define-caller-pattern fmakunbound-all (form) :macl)
(define-caller-pattern ownp (form) :macl)
(define-caller-pattern fownp (form) :macl)
(define-caller-pattern bound-anywhere-p (form) :macl)
(define-caller-pattern fbound-anywhere-p (form) :macl)
(define-caller-pattern where (form) :macl)
(define-caller-pattern fwhere (form) :macl)
(define-caller-pattern self :macl)
(define-caller-pattern objectp (form) :macl)
(define-caller-pattern inherit-from-p (form form) :macl)
(define-caller-pattern object-parents (form) :macl)
(define-caller-pattern object-ancestors (form) :macl)
(define-caller-pattern print-self (:optional form) :macl)
(define-caller-pattern object-license (form) :macl)
(define-caller-pattern license-to-object (form) :macl)
(define-caller-pattern next-license-to-object (form) :macl)
(define-caller-pattern highest-license-number :macl)
(define-caller-pattern license-to-object (form) :macl)

(define-caller-pattern do-all-objects
  ((symbol form)
   (:star form))
  :macl)

(define-caller-pattern do-object-variables
  ((variable form form)
   (:star form))
  :macl)

(define-caller-pattern do-object-functions
  ((variable form form)
   (:star form))
  :macl)
