do_formOpinion_like(FB,FBp) :-
    member(at(C,L)),
    member(at(Cp,L)),
    member(neutral(C,Cp)),

    % -o dels
    del(at(C,L),FB,T1),
    del(at(Cp,L),T1,T2),
    del(neutral(C,Cp),T2,T3),

    % -o adds
    add(at(C,L),T3,T4),
    add(at(Cp,L),T4,T5),
    add(philia(C,Cp),T5,FBp).

do_formOpinion_dislike(FB,FBp) :-
    member(at(C,L)),
    member(at(Cp,L)),
    member(neutral(C,Cp)),

    % -o dels
    del(at(C,L),FB,T1),
    del(at(Cp,L),T1,T2),
    del(neutral(C,Cp),T2,T3),

    % -o adds
    add(at(C,L),T3,T4),
    add(at(Cp,L),T4,T5),
    add(anger(C,Cp),T5,FBp).

do_compliment_private(FB,FBp) :-
    member(at(C,L)),
    member(at(Cp,L)),
    member(philia(C,Cp)),

    % -o dels
    del(at(C,L),FB,T1),
    del(at(Cp,L),T1,T2),
    del(philia(C,Cp),T2,T3),

    % -o adds
    add(at(C,L),T3,T4),
    add(at(Cp,L),T4,T5),
    add(philia(C,Cp),T5,FBp),
    add(philia(C,Cp),T5,FBp).
    


    
	   
