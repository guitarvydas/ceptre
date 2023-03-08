;;; stage first {
;;;   one : x -o y.
;;; }

;;; stage second {
;;;   two : y -o z.
;;; }

;;; qui * stage first -o stage second.
;;; qui * stage second -o quit.

(defun stage-first ()
  (cond ((and (match `(x)))
         (retract `(x))
         (assert `(y)))
        (t (assert `(qui)))))

(defun stage-second ()
  (cond ((and (match `(y)))
         (retract `(y))
         (assert `(z)))
        (t (assert `(qui)))))
              
(defun run-stage ()
  (format *error-output* "run-stage: ~a~%" *fb*)
  (cond ((match `(stage "first"))
         (stage-first))
        ((match `(stage "second"))
         (stage-second))
        (t (error "internal error in run-stage"))))

(defun top-level ()
  (format *error-output* "top-level: ~a~%" *fb*)
  (cond ((and (match `(qui))
              (match `(stage "first")))
         (retract `(qui))
         (retract `(stage "first"))
         (assert `(stage "second")))
        ((and (match `(qui))
              (match `(stage "second")))
         (retract `(qui)) 
         (retract `(stage "second"))
         (assert `(quit)))
        ((and (match `(quit)))
         (retract `(quit))
         (return-from top-level))
        (t
         (run-stage)))
  (top-level))

(defun run ()
  (clear-fb)
  (clear-lvars)
  (assert `(stage "first"))
  (top-level)
  (values))

