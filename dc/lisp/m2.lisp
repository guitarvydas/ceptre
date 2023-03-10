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
  (cond ((match `((layer "first")))
         (assert `(qui)))))
(push "first" *layer-names*)
(push 'layer-first *layers*)

(defun layer-second ()
  (cond ((match `((layer "second")))
         (assert `(qui)))))
(push "second" *layer-names*)
(push 'layer-second *layers*)

(defun top-level-1 ()
)
(push 'top-level-1 *top-level*)

(defun top-level-2 ()
)
(push 'top-level-2 *top-level*)

(defun run ()
  (clear-fb)
  (assert `(layer ,(car (reverse *layer-names*))))
  (mapc #'funcall (reverse *top-level*))
  (mapc #'funcall (reverse *layers*))
  *fb*)




