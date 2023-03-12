---
example:

invariant: tool can only match rt exprs, everything else is left untouched

--- step 0 ---
delete "(comment ...)" recursively / everywhere

--- step 0a ---
for-every "(rule ...)" replace with "(defstage «gensym ('top')» (namedrule «gensym ('subtop')» ...))"

--- step 1 ---
for-every "(fact Name ...)" replace with "«Name»«...»"

--- step 2 ---
for-every "(defstage Name ...)" -->
  find-and-replace "(namedrule Rname ...2)" in ... to "(namedrule «stage_name»_«Rname» ...2)"

--- Step 3 ---
*** for-every "(match ...)" find-and-replace "(predicate name ...args)" in "..." to "«(match? `((name ...cargs)))»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"
*** for-every "(retract ...)" find-and-replace "(predicate name ...args)" in "..." to "«(retract `(name ...cargs))»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"
*** for-every "(assert ...)" find-and-replace "(predicate name ...args)" in "..." to "«(assert `(name ...cargs))»"
 where cargs is find-and-replace "...args" with "comma-separated ...args"

--- step 4 ---

for-every "(retract ...)" replace with "..."
for-every "(assert ...)" replace with "..."

--- step 5a ---

for-every "(defstage StageName ...)" --> 
(defparameter *StageName-rules* nil)
(defstage StageName ...)

--- step 5b ---

for-every "(defstage StageName ...)" --> 
  find-and-replace "(namedrule RuleName (match ...matches) ...actions)" --> replace with

--- step 5 ---

for-every "(defstage StageName ...)" --> 
  find-and-replace "(namedrule RuleName (match ...matches) ...actions)" --> replace with
  (defun «StageName»-«RuleName» ()
        (cond ((match-unless? `((layer "«StageName»") ...matches) `((qui)))
         (retract `(named-rule (:? any)))
	 (assert `(named-rule "«RuleName»"))
	 ...actions))
  (push «StageName»-«RuleName» *«StageName»-rules*)

--- step 6 ---

for-every "(defstage StageName ...)" --> 
  find-and-replace "(namedrule RuleName (match ...matches) ...actions)" --> replace with
(defun layer-«StageName» ()
  (cond ((match-unless? `((layer "«StageName»") ...matches) `((qui)))
         (retract `(named-rule (:? any)))
	 (assert `(named-rule "«RuleName»"))
	 ...actions)
(push "«StageName»" *layer-namess*)
(push 'layer-«StageName» *layers*)

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
  assert(rule_name(«StageName», "%final")),
  assert(qui).



--- step cleanup ---
replace illegal characters 
 ]_[ --> _ , but not inside of strings
 '   --> _ , but not inside of strings
 /   --> _ , but not inside of strings
and delete Verbatim bracketsm, everwhere, including inside strings
 «   --> 
 »   -->


-------------
-------------

transpile *.cep to *.rt (*.cst)

step 00 rewrite-nametag

ohm: Nametag = name ":" ~(name* ".")
fab: Nametag [name kcolon] = ‛name «name» %\n’

---

step 01 rewrite-dollar

ohm: ceptreRule = applySyntactic<MatchClause> "-o" applySyntactic<ReplacementClause> "."
fab: ceptreRule [MatchClause klolli ReplacementClause kdot] ‛«resetKeep ()»«resetRetract ()»’ = ‛(rule 
(match
«MatchClause»
)
(retract 
«getRetract ()»
)
(assert
«getKeep ()»«ReplacementClause»
)
)’
...

---

step 02 rulename

ohm: RuleName = "name" name "%" kwRule
fab: RuleName [kname name kpercent kwRule] = ‛(namedrule [«name»]\n’
...

---

step 03 stage
ohm: Stagedefinition = 
  | "stage" name "=" "{" NamedRule+ "}" -- ok
  | "stage" name "=" "{" BlockError "}" -- err
...
fab: Stagedefinition_ok [kstage name keq lb rules+ rb] = ‛(defstage [«name»]«rules»)’
Stagedefinition_err [kstage name keq lb err rb] = ‛\n«err»«name»’
...

---

step 04 defx
ohm: defineExternal =
  | name+ ":" spaces "pred" "." -- pred
  | name+ ":" spaces "bwd" "." -- bwd
  | name+ ":" spaces "type" "." -- type
  | name+ ":" spaces name "." -- other
...
fab: defineExternal_pred [opAndArgs+ kcolon s1 type kperiod] = ‛(defpred («opAndArgs») «type»)’
defineExternal_bwd [opAndArgs+ kcolon s1 type kperiod] = ‛(defbwd («opAndArgs») «type»)’
defineExternal_type [opAndArgs+ kcolon s1 type kperiod] = ‛(deftype («opAndArgs») «type»)’
defineExternal_other [opAndArgs+ kcolon s1 type kperiod] = ‛(defexternal («opAndArgs») «type»)’
...

---

step 05 prefix

ohm: infix = "(" spaces sexprInnard operator spaces sexprInnard ")" spaces
fab: infix [lp s1 e1 op s2 e2 rp s3] = ‛(«op» «e1» «e2»)’
...

---

step 06 fact
ohm: fact = name atom+ "."
...
fab: fact [name atom+ kperiod] = ‛(fact «name»«atom»)’
...

-----

rewrite *.cst to *.pl
step 0 comment

ohm:  | "(" spaces "comment" spaces string ")" spaces -- comment
fab: rexpr_comment [lp s k s2 str rp s3] = ‛’

---
step 1

---
step 2

---
step 3

---
step 4

---
step 5

---
step 6

---
