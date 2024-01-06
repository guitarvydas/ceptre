% let's see if I can code up page 46 onwards of the thesis in Prolog...

do_formOpinion_like :-
    at(C,L),
    at(Cp,L),
    neutral(C,Cp),
    
    del(at(C,L),FB1,FB2),
    del(at(Cp,L),FB2,FB3),
    del(neutral(C,Cp),FB3,FB4),

    add(at(C,L),FB4,Fb5),
    add(at(Cp,L),FB4,Fb5),
    add(philia(C,Cp),FB4,Fb5).

