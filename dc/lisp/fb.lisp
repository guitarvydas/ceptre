(defparameter *fb* nil)

(defun clear-fb ()
  (setf *fb* nil))

(defclass lvar ()
  ((hole :accessor hole :initform nil)))

(defun bind (self v)
  (let ((is-lvar (eq 'lvar (type-of self))))
    (cond ((not is-lvar)
           (format *error-output* "bindA ~a ~a~%" self v)
           (cond ((equal self v) (values v t))
                 ((not (equal self v))
                  (values nil nil))))
          (is-lvar
           (format *error-output* "bindB ~a ~a~%" self v)
           (cond ((null (hole self)) (setf (hole self) v) (values v t))
                 ((not (null (hole self)))
                  (cond ((equal v (hole self)) (values v t))
                        ((not (equal v (hole self)))
                         (values nil nil)))))))))

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
(format *error-output* "match-one ~a ~a~%" predicate-from-fb predicate)
  (mapc #'(lambda (arg actual)
(format *error-output* "match-one-mapc ~a ~a~%" arg actual)
            (multiple-value-bind (v success) (bind arg actual)
              (declare (ignore v))
(format *error-output* "match-one-bind ~a~%" success)
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


  

