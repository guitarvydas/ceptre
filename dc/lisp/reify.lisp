(defparameter r `(named-rule (:? any)))

;(reify r nil)
;(reify r ((ANY . "<junk>")))

(defun reify (lis alis)
  (cond ((null lis) nil)
        ((not (listp lis)) lis)
        ((listp lis)
         (let ((looks-like-a-var (and (= 2 (length lis)) (eq ':? (first lis)))))
           (cond (looks-like-a-var
                  (let ((sym (second lis)))         
                    (let ((vl (assoc sym alis)))
                      (cond (vl (cdr vl))
                            ((null vl) lis)))))
                 ((not looks-like-a-var)
                  (cons (reify (car lis) alis)
                         (reify (cdr lis) alis))))))))


(defun rtest ()
  (reify r nil))

(defun rtest2 ()
  (reify r '((ANY . "<junk>"))))
