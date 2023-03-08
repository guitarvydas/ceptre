(defparameter *fb* nil)

(defclass lvar ()
  ((hole :accessor hole :initform nil)))

(defmethod bind ((self lvar) v)
  (cond ((null (hole self)) (setf (hole self) v) (values v t))
        ((not (null (hole self)))
         (cond ((equal v (hole self)) (values v t))
               ((not (equal v (hole self))) (values nil nil))))))

(defmethod bind ((self T) v)
  (equal self v))
  
(defun match-one (predicate-from-fb predicate) 
  (mapc #'(lambda (arg actual)
            (multiple-value-bind (v success) (bind arg actual)
              (declare (ignore v))
              (cond ((not success) (return-from match-one nil)))))
        predicate predicate-from-fb)
  t)


(defun match (pred)
  (mapc #'(lambda (predicate-from-fb)
            (cond ((match-one predicate-from-fb pred) (return-from match t))))
        *fb*)
  nil)

(defun retract (pred)
  (setf *fb* (delete pred *fb* :test 'equal :count 1)))

(defun assert (pred)
  (push pred *fb*))

(defun test ()
  (assert '(max_hp 10))
  (match '(max_hp 5)))


  

