(defparameter *fb* nil)
;; data structure: an FB (factbase, database, rulebase) consists of a list of items
;; an item is a list
;;  if the item list contains exactly one sub-list, then that item is a FACT
;;  if the item list contains more than one sub-list, it is a RULE, the head of the RULE is the first sub-list, the body of the RULE is the rest of the sub-list
;; an FB is not a SET, it is a BAG - it can contain more than one of the same thing, 'retract' removes only the first copy
;;
;; matching is done via Unification - all predicates must match up with items in the FB
;;  a predicate is a list (item list above) that contains constants and Lvars (Logical Variables)
;;  a predicate matches an item in the FB if all of its sub-items match
;;   a constant sub-item matches when the target is also a constant and is equal to source constant sub-item
;;   an Lvar sub-item matches if (1) its contains a constant that matches the target,
;;   or, (2) it contains an unbound Lvar, in which case the target is assigned to the Lvar
;;   or, (3) it contains a bound Lvar which matches the target
;;   Lvars can be joined together - if the bottom Lvar matches the target, then all of the joined Lvars match and are "equivalent" to the bottom Lvar

(defun clear-fb ()
  (setf *fb* '()))

(defun match (predicate-list)
  (let ((initial-db *fb*)
        (complete-db *fb*)
        (top-link nil) (top-env hprolog:*empty*) (top-cut nil)
        (goal predicate-list)
        (self nil)) ;; for method calling - not used here
    (let ((results (hprolog:prove top-link goal initial-db top-env 1 top-cut complete-db nil self)))
      ;; results contains ALL of the possible matches, we need only one of them - we'll take the first one
      ;; TODO: opportunity for optimization and/or replacement by miniKanren
      (cond ((null results)        (values nil nil))
            ((not (null results))  (values (first results) t))))))

(defun match-unless (positive-preds unless-preds)
  (let ((unlss (match unless-preds)))
    (cond (unlss nil)
          ((null unlss) (not (null (match positive-preds)))))))

(defun retract (predicate)
  ;; implementation prereqs: (for POC)
  ;;; predicate must not contain :?
  (let ((success (deep-find-symbol :? predicate)))
    (cond (success
           (error (format nil "NIY: for now, retract doesn't know how to handle predicates containing Logic Variables ~a" predicate)))
          ((not success)))) ;; OK, pass, we can proceed with this cheapo implementation
  (let ((found-in-fb (match predicate)))
    (cond (found-in-fb
           ;; we can use a dumb delete only if the predicate is present
           (let ((new-fb (delete-first predicate *fb*)))
             (setf *fb* new-fb)))
          ;; else don't try to delete, the predicate is already deleted (not present)
          ((not found-in-fb) nil))))

(defun assert (predicate)
  (push (list predicate) *fb*))

(defun rule (rule)
  (push rule *fb*))

(defun delete-first (p fb)
  (cond ((null fb) nil)
        ((equal p (first (first fb))) (rest fb))
        (t (cons (first fb) (delete-first p (rest fb))))))

(defun deep-find-symbol (sym lis)
  (cond ((null lis) nil)
        ((not (listp lis)) (equal sym lis))
        ((list lis)
         (and (deep-find-symbol sym (car lis))
              (deep-find-symbol sym (cdr lis))))))