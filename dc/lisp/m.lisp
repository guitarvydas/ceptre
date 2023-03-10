;;; stage first {
;;;   one : x -o y.
;;; }

;;; stage second {
;;;   two : y -o z.
;;; }

;;; qui * stage first -o stage second.
;;; qui * stage second -o ().

(defun run-stages ()
  (cond ((and (match `(stage "first"))
              (not (match `(qui))))
         (cond ((and (match `(x)))
                (retract `(x))
                (assert `(y)))
               (t (assert `(qui)))))
        ((and (match `(stage "second"))
              (not (match `(qui))))
         (cond ((and (match `(y)))
                (retract `(y))
                (assert `(z)))
               (t (assert `(qui)))))
        (t (error "internal error in run-stages"))))

(defun run-top-level ()
  (cond ((and (match `(qui))
              (match `(stage "first")))
         (retract `(qui))
         (retract `(stage "first"))
         (assert `(stage "second")))
        ((and (match `(qui))
              (match `(stage "second")))
         (retract `(qui)) 
         (retract `(stage "second")))))

(defun top-level ()
  (format *error-output* "~%top-level: ~a" *fb*)
  (run-top-level)
  (cond ((match `(stage (:? s)))
         (run-stages)
         (top-level))
        (t (format *error-output* "~%DONE"))))

(defun run ()
  (clear-fb)
  (assert `(stage "first"))
  (top-level)
  (values))

