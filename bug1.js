var ohm = require ('ohm-js')

const grammar = ohm.grammar (
`
C2CL0 {

top = oneCharOrRexpr+

oneCharOrRexpr =
  | space -- space
  | &"(" rexpr -- rexpr
  | any -- other

rexpr =
  | pattern spaces -- pattern
  | "(" spaces rexpr* ")" spaces -- general
  | verbatim spaces -- verbatim
  | atom spaces -- bottom

pattern = ~any any any any
verbatim = ~any any any any
atom = ~any any any any
}
`);

const semantics = grammar.createSemantics ().addOperation ("junk", {
    top (x) {},
    oneCharOrRexpr_space (x) {},
    oneCharOrRexpr_rexpr (la, x) {},
    oneCharOrRexpr_other (x) {},
    rexpr_pattern (x, s) {},
    rexpr_general (lp, s, rs, rp, s2) {},
    rexpr_verbatim (x, s) {},
    rexpr_bottom (x, s) {},
    _terminal () {}
});
