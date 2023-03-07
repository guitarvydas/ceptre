:- dynamic qui/0.
:- dynamic stage/1.
:- dynamic quit/0.
:- dynamic rule_name/2.

match(X) :-
    X.

run :-
    assert(stage("first")),
    toplevel.

stagestep :-
    match(stage("first")),
    \+ qui,
    match(x),
    !,
    assert(rule_name("first", "first_one")),
    retract(x),
    assert(y).
stagestep :-
    match(stage("first")),
    \+ qui,
    match(x),
    !,
    assert(rule_name("first", "%final")),
    assert(qui).

stagestep :-
    match(stage("second")),
    \+ qui,
    match(y),
    !,
    assert(rule_name("second", "second_two")),
    retract(y),
    assert(z).
stagestep :-
    match(stage("second")),
    \+ qui,
    !,
    assert(rule_name("second", "%final")),
    assert(qui).

step :-
 match(qui),
match(stage(first)),
 !,
 assert(stage("%toplevel", "%toplevel")),
 retract(qui),
retract(stage(first)),
assert(stage(second))
.

step :-
 match(qui),
match(stage(second)),
 !,
 assert(stage("%toplevel", "%toplevel")),
 retract(qui),
retract(stage(second)),
assert(empty)
.


----------------
stepstage :-
    match(stage("first")),
    \+ qui,
    !,
    assert(rule_name("first", "first_1")),
    write('in first'),nl,
    retract(stage("first")),
    assert(stage("second")).


stepstage :-
    match(stage("second")),
    \+ qui,
    !,
    assert(rule_name("second", "second_1")),
    write('in second_1'),nl,
    retract(stage("second")),

stepstage :-
    match(stage("second")),
    \+ qui,
    !,
    assert(rule_name("second", "second_%final")),
    write('in second_%final'),nl,
    assert(quit).


toplevel :-
    write("stepping"),nl,
    stepstage,
    continue.


continue :-
    quit,
    !,
    write("quit"),
    nl.

continue :-
    toplevel,
    !.

