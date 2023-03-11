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
         (assert `(named-rule "one"))
         (retract `(x))
         (assert `(y)))
        ((match-unless? `((layer "first")) `((qui)))
         (retract `(named-rule (:? any)))
         (assert `(named-rule "first%final"))
         (assert `(qui)))))
(push "first" *layer-names*)
(push 'layer-first *layers*)

(defun layer-second ()
  (cond ((match-unless? `((layer "second") (y)) `((qui)))
         (retract `(named-rule (:? any)))
         (assert `(named-rule "two"))
         (retract `(y))
         (assert `(z)))
        ((match-unless? `((layer "second")) `((qui)))
         (retract `(named-rule (:? any)))
         (assert `(named-rule "second%final"))
         (assert `(qui)))))
(push "second" *layer-names*)
(push 'layer-second *layers*)

(defun top-level-1 ()
  (cond ((match? `((layer "first") (qui)))
         (retract `(layer "first"))
         (retract `(qui))
         (retract `(named-rule (:? nr)))
         (assert `(layer "second")))))
(push 'top-level-1 *top-level*)

(defun top-level-2 ()
  (cond ((match? `((layer "second") (qui)))
         (retract `(layer "second"))
         (retract `(qui))
         (retract `(named-rule (:? nr)))
         (assert `(quit)))))
(push 'top-level-2 *top-level*)

(defun top-level ()
  (mapc #'funcall (reverse *top-level*)))

(defun layers ()  
  (mapc #'funcall (reverse *layers*)))

(defun cstep ()
  (top-level)
  (format *error-output* "after top fb:    ~a~%" *fb*)
  (layers)
  (format *error-output* "after layers fb: ~a~%" *fb*))

(defun run ()
  (clear-fb)
  (assert `(layer ,(car (reverse *layer-names*))))
  (assert `(x))
  (cstep)
  (cstep)
  (cstep)

  (cstep)

  (cstep)

  (values))




