
package transpiler

import "core:fmt"
import "core:runtime"
import "core:log"
import "core:strings"
import "core:slice"
import "core:os"
import "core:unicode/utf8"

import "../../../ir"
import zd "../../engine/0d"
import reg "../../engine/registry0d"
import "../../engine/process"
import "../../std"


initialize :: proc(r : ^reg.Component_Registry) {
    // for ohmjs
    reg.add_leaf (r, reg.Leaf_Template { name = "OhmJS", instantiate = ohmjs_instantiate })
    reg.add_leaf (r, std.string_constant ("RWR"))
    reg.add_leaf (r, std.string_constant ("rwr.ohm"))
    reg.add_leaf (r, std.string_constant ("rwr.sem.js"))
}

///////////

////////

OhmJS_Instance_Data :: struct {
    grammarname : string, // grammar name
    grammarfilename : string, // file name of grammar in ohm-js format
    semanticsfilename : string, // file name of source text of semantics support code JavaScript namespace
    input : string, // source file to be parsed
}

ohmjs_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    instance_name := std.gensym ("OhmJS")
    inst := new (OhmJS_Instance_Data) // all fields have zero value before any messages are received
    return zd.make_leaf (instance_name, owner, inst^, ohmjs_handle)
}

ohmjs_maybe :: proc (eh: ^zd.Eh, inst: ^OhmJS_Instance_Data, causingMsg: ^zd.Message) {
    if "" != inst.grammarname && "" != inst.grammarfilename && "" != inst.semanticsfilename && "" != inst.input {
        cmd := fmt.aprintf ("0Dutil/ohmjs.js %s %s %s", inst.grammarname, inst.grammarfilename, inst.semanticsfilename)
	captured_output, err := process.run_command (cmd, inst.input)
        zd.send_string (eh, "output", strings.trim_space (captured_output), causingMsg)
	zd.send_string (eh, "error", strings.trim_space (err), causingMsg)
    }
}

ohmjs_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := &eh.instance_data.(OhmJS_Instance_Data)
    switch (msg.port) {
    case "grammar name":
	inst.grammarname = strings.clone (msg.datum.repr (msg.datum))
	ohmjs_maybe (eh, inst, msg)
    case "grammar":
	inst.grammarfilename = strings.clone (msg.datum.repr (msg.datum))
	ohmjs_maybe (eh, inst, msg)
    case "semantics":
	inst.semanticsfilename = strings.clone (msg.datum.repr (msg.datum))
	ohmjs_maybe (eh, inst, msg)
    case "input":
	inst.input = strings.clone (msg.datum.repr (msg.datum))
	ohmjs_maybe (eh, inst, msg)
	case:
        emsg := fmt.aprintf("!!! ERROR: OhmJS got an illegal message port %v", msg.port)
	zd.send_string (eh, "error", emsg, msg)
    }
}

////


