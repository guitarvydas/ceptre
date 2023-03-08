(defparameter *fb* nil)

(defun clear-fb ()
  (setf *fb* nil))

(defclass lvar ()
  ((hole :accessor hole :initform nil)))

(defmethod bind ((self lvar) v)
  (cond ((null (hole self)) (setf (hole self) v) (values v t))
        ((not (null (hole self)))
         (cond ((equal v (hole self)) (values v t))
               ((not (equal v (hole self)))
                (values nil nil))))))

(defmethod bind ((self T) v)
  (cond ((equal self v) (values v t))
        ((not (equal self v))
         (values nil nil))))

(defmethod clear ((self lvar))
  (setf (hole self) nil))

(defparameter *lvars* nil)

(defun fresh ()
  (let ((newlv (make-instance 'lvar)))
    (push newlv *lvars*)
    newlv))

(defun clear-lvars ()
  (mapc #'clear *lvars*)
  (setf *lvars* nil))


(defun match-one (predicate-from-fb predicate) 
  (mapc #'(lambda (arg actual)
            (multiple-value-bind (v success) (bind arg actual)
              (declare (ignore v))
              (cond
               (success nil)
               ((not success) (return-from match-one nil)))))
        predicate predicate-from-fb)
  t)


(defun match (pred)
  (mapc #'(lambda (predicate-from-fb)
            (let ((b (match-one predicate-from-fb pred)))
            (cond
             ((not b))
             (b (return-from match t)))))
        *fb*)
  nil)

(defun retract (pred)
  (setf *fb* (delete pred *fb* :test 'equal :count 1)))

(defun assert (pred)
  (push pred *fb*))

(defun test ()
  (clear-fb)
  (clear-lvars)
  (assert `(max_hp 10))
  (match `(max_hp ,(fresh))))


  

