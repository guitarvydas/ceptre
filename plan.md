---
example:
```
(fact max_hp 10 ) (fact damage sword  4 ) (fact cost sword  10 )

context init_ctx = {(fact init_tok } )

(comment  [c]  )
(defexternal (d  n  n  ) b )
(fact d X X ) (comment  [ for now]  )
(defstage [flee]
  (namedrule [do/flee]
	     (match(predicate  flee_screen  )
		   (predicate  spoils  X )
		   (predicate  monster  _   )
		   (predicate  monster_hp  _   ))
	     (retract(predicate  flee_screen  )
		     (predicate  spoils  X )
		     (predicate  monster  _   )
		     (predicate  monster_hp  _   ))
	     (assert(predicate  empty  )))
  (namedrule [infix]
	     (match(predicate  ndays  NDAYS ))
	     (retract(predicate  ndays  NDAYS ))
	     (assert(predicate  health  N )
		    (predicate ndays (+  NDAYS 1    )))))
(defbwd (drop_amount  nat  nat  ) bwd)
(defpred (try_fight  ) pred)
(deftype (nat  ) type)
(defexternal (d  n  n  ) b )
```
---

invariant: tool can only match rt exprs, everything else is left untouched

--- step 0 ---
delete "(comment ...)" recursively / everywhere

--- step 1 ---
for-every "(fact Name ...)" replace with "«Name»«...»"

--- step 2 ---
for-every "(defstage Name ...)" -->
  find-and-replace "(namedrule Rname ...2)" in ... to "(namedrule «stage_name»_«Rname» ...2)"

--- Step 3 ---
*** for-every "(match ...)" find-and-replace "(predicate name ...args)" in "..." to "«match(name(...cargs)),»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"
*** for-every "(retract ...)" find-and-replace "(predicate name ...args)" in "..." to "«retract(name(...cargs)),»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"
*** for-every "(assert ...)" find-and-replace "(predicate name ...args)" in "..." to "«assert(name(...cargs)),»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"

--- step 4 ---

for-every "(retract ...)" replace with "..."
for-every "(assert ...)" replace with "..."

--- step 5 ---

for-every "(defstage StageName ...)" --> 
  find-and-replace "(namedrule RuleName (match ...matches) ...actions)" --> replace with
stagestep :-
  match(stage(«StageName»)),
  refuse(qui),
  ...matches
  !,
  assert(rule_name, "«RuleName»"),
  ...actions
stagestep :-
  match(stage(«StageName»)),
  refuse(qui),
  !,
  assert(rule_name(«RuleName», "%final")),
  assert(qui).

--- step 5 ---
replace illegal characters 
 ]_[ --> _
 '   --> _
 /   --> _
and delete Verbatim brackets
 «   -->
 »   -->
