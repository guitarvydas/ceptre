(declaim (optimize (debug 3) (safety 3) (speed 0)))

(asdf:load-system :cl-holm-prolog)
(asdf:load-system :cl-holm-prolog/test)

(let ((root "/Users/tarvydas/quicklisp/local-projects/ceptre/dc/lisp/"))
  (labels ((ld (fname)
             (load (format nil "~a~a" root fname))))
    (ld "fb.lisp")
    (ld "m.lisp")))

