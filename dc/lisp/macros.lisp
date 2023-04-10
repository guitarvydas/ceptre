(defmacro memo (rule_list new_rule)
  `(setf ,rule_list (append ,rule_list '(,new_rule))))

(defmacro interact (stage-name prompt choices)
  `(cond ((and (match? '(stage ,stage-name))
	       (not (match? (_interaction_finished))))
	  (assert '(rule _interaction))
	  (princ ,prompt)
	  (let ((choice nil))
	    (loop until choice
                  do (progn
                       (setf choice (assoc (read) ,choices))
                       (unless choice
                         (print "try again")
                         (princ ,prompt))))
	    (let ((f (intern (format nil "~a_~a" ,stage-name (cdr choice)))
	      (assert (list f))
	      (assert '(_interaction_finished))
	      t)))
	 (t nil)))

#|
;; this call...

(macroexpand-1 '(interact main 
   "choose: 1 - do/rest ; 2 - do/adventure ; 3 - do/shop ; 4 - do/quit" 
   '((1 . do/rest) (2 . do/adventure) (3 . do/shop) (4 . do/quit)))))



;; should result in ...

(COND ((AND (MATCH? (QUOTE (STAGE MAIN)))
            (NOT (MATCH? (_INTERACTION_FINISHED))))
       (ASSERT (QUOTE (RULE _INTERACTION)))
       (PRINC "choose: 1 - do/rest ; 2 - do/adventure ; 3 - do/shop ; 4 - do/quit")
       (LET ((CHOICE NIL))
         (LOOP UNTIL CHOICE
               DO (PROGN
                    (SETF CHOICE (ASSOC (READ) (QUOTE ((1 . DO/REST) (2 . DO/ADVENTURE) (3 . DO/SHOP) (4 . DO/QUIT)))))
                    (UNLESS CHOICE
                      (PRINT "try again")
                      (PRINC "choose: 1 - do/rest ; 2 - do/adventure ; 3 - do/shop ; 4 - do/quit"))))
         (LET ((F (CDR CHOICE)))
           (ASSERT (LIST F))
           (ASSERT (QUOTE (_INTERACTION_FINISHED))) T)))
      (T NIL))


|#

#|

(interactive_stagerule main do/rest
	   (match (match? `(main_screen)))
	   (retract `(main_screen))
	   (assert `(rest_screen)))

-->

(defun main_do/rest ()
  (cond ((and (match? `(stage main))
	      (match? `(main_screen))
	      (match? `(_interaction_finished))
	      (match? `(do/rest)))
	 (assert `(rule do/rest))
	 (retract `(main_screen))
	 (retract `(_interaction_finished))
	 (assert `(rest_screen))
	 t)
	(t nil)))
(setf main_rules (append main_rules '(main_do/rest)))
|#

(defmacro interactive_stagerule (stage-name rule-name matches &rest body)
  `(defun ,(intern (format nil "~a_~a" stage-name rule-name)) ()
     (cond ((and (match? '(stage ,stage-name))
		 (match? '(_interaction_finished))
		 ,matches)
	    (assert '(rule ,rule-name))
	    (retract '(_interaction_finished))
	    ,@body
	    t)
	   (t nil))))
