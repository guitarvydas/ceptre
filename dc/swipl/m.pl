:- dynamic qui/0.
:- dynamic stage/1.
:- dynamic quit/0.

match(X) :-
    X.

run :-
    assert(stage("first")),
    toplevel.
    
stepstage :-
    match(stage("first")),
    \+ qui,
    !,
    write("first stage"),nl,
    retract(stage("first")),
    assert(stage("second")).

stepstage :-
    match(stage("second")),
    \+ qui,
    !,
    write("second stage"),nl,
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

