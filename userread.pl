:- dynamic animal/1.
    
animal(dog).
animal(cat).
animal(cow).

q :-
  read(X),
  animal(X),
  write(X),
  nl.


