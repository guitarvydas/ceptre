(defun test ()
  ;; should display :yes T
  (clear-fb)
  (assert `(:man :paul))
  (match `((:man :paul))))
  
(defun test2 ()
  ;; should display :yes T
  (clear-fb)

  (assert `(:father :paul :albin))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (assert `(:father :justin :paul))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (rule `((:grandfather (:? :grandson) (:? :granddad))
            (:father (:? :dad) (:? :granddad))
            (:father (:? :grandson) (:? :dad))))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (format *error-output* "match using keywords: ~a~%" (match `((:grandfather :justin (:? g)))))

  (assert `(father paul albin))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (assert `(father justin paul))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (rule `((grandfather (:? grandson) (:? granddad))
            (father (:? dad) (:? granddad))
            (father (:? grandson) (:? dad))))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (format *error-output* "match using keyword ?: ~a~%" (match `((grandfather justin (:? g)))))

  ;;;
  (assert `(father paul albin))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (assert `(father justin paul))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (rule `((grandfather (? grandson) (? granddad))
            (father (? dad) (? granddad))
            (father (? grandson) (? dad))))
  ;(format *error-output* "fb: ~a~%" *fb*)
  (format *error-output* "match using keywords: ~a~%"  (match `((grandfather justin (? g)))))
  (values))

  
;;; (defun test0 ()
;;;   (let ((db '(((:man :paul)))))
;;;     (let ((complete-db db)
;;;           (initial-db db)
;;;           (top-link nil)
;;;           (top-env hprolog:*empty*)
;;;           (top-cut nil)
;;;           (self nil))
;;;       (hprolog:prove top-link '((:man :paul)) initial-db top-env 1 top-cut complete-db nil self))))

;;; (defun test1 ()
;;;   (let ((db '(((:man :paul)))))
;;;     (let ((complete-db db)
;;;           (initial-db db)
;;;           (top-link nil)
;;;           (top-env hprolog:*empty*)
;;;           (top-cut nil)
;;;           (self nil))
;;;       (hprolog:prove top-link '((:man (:? x))) initial-db top-env 1 top-cut complete-db nil self))))

(defun htest2 ()
  (let ((db '(
              ((:grandfather (:? :grandson) (:? :granddad))
               (:father (:? :dad) (:? :granddad))
               (:father (:? :grandson) (:? :dad)))
              ((:father :paul :albin))
              ((:father :justin :paul))
            )))
    (let ((complete-db db)
          (initial-db db)
          (top-link nil)
          (top-env hprolog:*empty*)
          (top-cut nil)
          (self nil))
      (hprolog:prove top-link '((:grandfather :justin (:? x))) initial-db top-env 1 top-cut complete-db nil self))))

;;; (defun cl-user::htest0a ()
;;;   (let ((db-very-small2
;;;          '(((:ellipse :id568))
;;;            ((:text :id1 :str1))
;;;            ((:text :id2 :str2))
;;;            ((:used :str1))
;;;            ((:rect :id391))
;;;            ((:bounding_box_left :id391 3585.0))
;;;            ((:bounding_box_top :id391 450.0))
;;;            ((:bounding_box_right :id391 3665.0))
;;;            ((:bounding_box_bottom :id391 530.0))
;;;            ((:geometry_h :id568 40.0))
;;;            ((:geometry_w :id568 40.0))
;;;            ((:geometry_center_x :id568 4405.0))
;;;            ((:geometry_center_y :id568 40.0)))))
;;;   (let ((complete-db db-very-small2)
;;;         (initial-db db-very-small2)
;;;         (top-link nil)
;;;         (top-env hprolog:*empty*)
;;;         (top-cut nil)
;;;         (self nil))
;;;     (hprolog:prove top-link '((:man :nils)) initial-db top-env 1 top-cut complete-db nil self))))
