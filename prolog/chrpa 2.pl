
% formula a ⊗ b -o c ⊕ d can be written in Prolog like this:
% (lin_del(a,L1,L2),lin_del(b,L2,L3)),
% (lin_add(c,L3,L4);lin_add(d,L3,L4))

%fb([a,b]).
fb([p,a,q,b,r]).

rule(FB,FBn):-
    del(a,FB,FBp),
    del(b,FBp,FBpp),

    add(c,FBpp,FBppp),
    add(d,FBppp,FBn).

main1(NewFB):-
    consult(lin),
    fb(InitFB),
    rule(InitFB,NewFB).

main2(NewFB):-
    consult(lin),
    fb(InitFB),
    InitFB=[a,b],
    rule(InitFB,NewFB).

main3(NewFB):-
    consult(lin),
    fb(FB),
    member(a,FB),
    member(b,FB),
    rule(FB,NewFB).
