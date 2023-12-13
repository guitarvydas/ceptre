package transpiler

import "core:fmt"
import "core:runtime"
import "core:log"
import "core:strings"
import "core:slice"
import "core:os"
import "core:unicode/utf8"

import reg "../registry0d"
import "../process"
import "../../ir"
import zd "../0d"


initialize :: proc(leaves: ^[dynamic]reg.Leaf_Instantiator) {

    // for ohmjs
    append(leaves, reg.Leaf_Template { name = "HardCodedGrammar", instantiate = leaf.hard_coded_rwr_grammar_instantiate })
    append(leaves, reg.Leaf_Template { name = "HardCodedSemantics", instantiate = leaf.hard_coded_rwr_semantics_instantiate })
    append(leaves, reg.Leaf_Template { name = "HardCodedSupport", instantiate = leaf.hard_coded_rwr_support_instantiate })
    append(leaves, reg.Leaf_Template { name = "OhmJS", instantiate = leaf.ohmjs_instantiate })

    // for RT front end
    append(leaves, reg.Leaf_Template { name = "'Word'", instantiate = leaf.word_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/word.ohm'", instantiate = leaf.wordohm_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/word.sem.js'", instantiate = leaf.wordjs_instantiate })

    append(leaves, reg.Leaf_Template { name = "'RWR'", instantiate = leaf.rwr_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rwr/rwr.ohm'", instantiate = leaf.rwrohm_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rwr/rwr.sem.js'", instantiate = leaf.rwrsemjs_instantiate })

    append(leaves, reg.Leaf_Template { name = "fakepipename", instantiate = leaf.fakepipename_instantiate })

    append(leaves, leaf.string_constant ("Escapes"))
    append(leaves, leaf.string_constant ("rt/escapes.ohm"))
    append(leaves, leaf.string_constant ("rt/escapes.rwr"))
    append(leaves, leaf.string_constant ("rt/escapessupport.js"))

