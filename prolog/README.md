see lin.pl for basic FB (FactBase) manipulation
see chrpa.pl for test main3
- we initialize the FB to be [p,a,q,b,r]
- we find any FB that has 'a' and 'b' in it
- we apply 'rule' to the found factbase
- we return (print out) the resulting factbase
- the result is [d, c, p, q, r] because...
  - we delete 'a' from the factbase
  - we delete 'b' from the factbase
	- the intermediate result is [p, q, r]
  - we add 'c' to the factbase
  - we add 'd' to the factbase
  - since the additions can be stuck into the factbase "anywhere", the code pushes these items onto the front
  - the result is [d, c, p, q, r]
