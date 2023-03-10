;; hand-edited starting with test.cst

(defparameter *stages* nil)
(defparameter *top-level* nil)
(defparameter *rule* nil)

(defun stage-first ()
)
(push 'stage-first *stages*)

(defun stage-second ()
)
(push 'stage-second *stages*)

(defun top-level-1 ()
)
(push 'top-level-1 *top-level*)

(defun top-level-2 ()
)
(push 'top-level-2 *top-level*)

(defun run ()
  (clear-fb)
  (assert `(stage ,(car (reverse *stages*))))
  *fb*)




