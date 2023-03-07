:- dynamic qui/0.
:- dynamic stage/1.
:- dynamic quit/0.
:- dynamic rule_name/2.

match(X) :-
    X.

run :-
    assert(stage("first")),
    toplevel.
    
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
    write('in second'),nl,
    retract(stage("second")),
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

