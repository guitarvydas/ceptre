;; hand-edited starting with test.cst

(defparameter *stages* nil)
(defparameter *top-level* nil)
(defparameter *rule* nil)

(defun stage-first ()
  (cond ((multi-match `(stage "first")
		 `(! (qui))
		 `(x))
	 (retract `( x  ))
	 (assert `( y  )))
	 
	((multi-match `(stage "first") `(! (qui)))
	 (assert `(qui)))))
(push 'stage-first *stages*)



(defun stage-second ()
  (cond ((and (match `(stage "first"))
	      (not (match `(qui))))
	 (setf *rule* "second/two")
	 (cond ((and (match `( y  )))
		(retract `( y  ))
		(assert `( z  )))
	       (t (assert `(qui)))))
	(t nil)))
(push 'stage-second *stages*)

(defun top-level-1 ()
  (cond ((and (match `( qui  ))
	      `( stage  "first"  ))
	 (setf *rule* "top-level-1")
	 (retract `( qui  ))
	 (retract `( stage  "first"  ))
	 (assert  `( stage  "second"  )))
	(t nil)))
(push 'top-level-1 *top-level*)

(defun top-level-2 ()
  (cond ((and (match `( qui  ) )
	      (match `( stage  "second"  )))
	 (setf *rule* "top-level-2")
	 (retract `( qui  ))
	 (retract `( stage  "second"  ))
	 #+nil(assert) )
	(t nil)))
(push 'top-level-2 *top-level*)

(defun top-level ()
  (format *error-output* "~%top-level: ~a" *fb*)
  (mapc #'funcall (reverse *top-level*))
  (cond ((match `(stage ,(fresh)))
	 (mapc #'funcall (reverse *stages*))
	 (top-level))
	(t (format *error-output* "~%DONE"))))

(defun run ()
  (clear-fb)
  (clear-lvars)
  (assert `(stage ,(car (last *stages*))))
  (top-level)
  (values))




