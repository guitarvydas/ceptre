;; hand-edited starting with test.cst

;;; stage first {
;;;   one : x -o y.
;;; }

;;; stage second {
;;;   two : y -o z.
;;; }

;;; qui * stage first -o stage second.
;;; qui * stage second -o ().

(defparameter *layers* nil)
(defparameter *layer-names* nil)
(defparameter *top-level* nil)
(defparameter *rule* nil)

(defun layer-first ()
  (cond ((match-unless? `((layer "first") (x)) `((qui)))
         (retract `(named-rule (:? any)))
         (assert `(named-rule "first"))
         (retract `(x))
         (assert `(y)))
        ((match? `((layer "first")))
         (retract `(named-rule (:? any)))
         (assert `(named-rule "first%final"))
         (assert `(qui)))))
(push "first" *layer-names*)
(push 'layer-first *layers*)

(defun layer-second ()
  (cond ((match-unless? `((layer "second")) `((qui)))
         (assert `(qui)))))
(push "second" *layer-names*)
(push 'layer-second *layers*)

(defun top-level-1 ()
  (cond ((match? `((layer "first") (qui)))
         (retract `(layer "first"))
         (retract `(qui))
         (assert `(layer "second")))))
(push 'top-level-1 *top-level*)

(defun top-level-2 ()
  (cond ((match? `((layer "second") (qui)))
         (assert `(quit)))))
(push 'top-level-2 *top-level*)

(defun top-level ()
  (mapc #'funcall (reverse *top-level*)))

(defun layers ()  
  (mapc #'funcall (reverse *layers*)))

(defun run ()
  (clear-fb)
  (assert `(layer ,(car (reverse *layer-names*))))
  (assert `(x))
  (top-level)
  (layers)
  (format *error-output* "fb: ~a~%" *fb*)
  (top-level)
  (format *error-output* "fb: ~a~%" *fb*)
  (layers)
  (format *error-output* "fb: ~a~%" *fb*)
  (values))




