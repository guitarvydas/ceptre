:- dynamic qui/0.
:- dynamic stage/1.
:- dynamic quit/0.

match(X) :-
    X.

run :-
    assert(stage("infiniteloop")),
    assert(forever),
    toplevel.
    
stepstage :-
    match(stage("infiniteloop")),
    match(forever),
    \+ qui,
    !,
    retract(forever),
    assert(forever),
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

