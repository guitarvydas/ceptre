% from https://icaps06.icaps-conference.org/dc-papers/paper5.pdf

del(V,[V|L],L).
del(V,[H|L],[H|NL]):-
    del(V,L,NL).

add(V,L,[V|L]).

%ldel(E1,[E1|T1],L2) :- T1 == L2, !. %base case
%ldel(E1,[H1|T1],[H2|T2]) :- H1 == H2, del(E1,T1,T2). %general case
