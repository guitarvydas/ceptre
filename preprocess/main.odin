package preprocess

import "core:fmt"
import "core:log"
import "core:runtime"
import "core:strings"
import "core:slice"
import "core:os"
import "core:unicode/utf8"

import reg  "../tools/odin/engine/registry0d"
import zd   "../tools/odin/engine/0d"
import std "../tools/odin/std"

import "../tools/odin/util/transpiler"
import "../tools/odin/util/fakepipe"

main :: proc() {
    source_file := parse_command_line_args ()
    diagram_name := "preprocess.drawio"
    palette := initialize_component_palette (diagram_name)
    transpiler.initialize (palette)
    fakepipe.initialize (palette)
    run (palette, source_file, "main", diagram_name, kick_start_function)
}

kick_start_function :: proc (main_container : ^zd.Eh, source_file : string) {
    b := zd.new_datum_string (source_file)
    msg := zd.make_message("input", b, zd.make_cause (main_container, nil) )
    main_container.handler(main_container, msg)
}

initialize_project_specific_components :: proc (leaves: ^[dynamic]reg.Leaf_Template) {
    append(leaves, std.string_constant ("Word"))
    append(leaves, std.string_constant ("word.sem.js"))
    append(leaves, std.string_constant ("word.ohm"))
    append(leaves, std.string_constant ("Escapes"))
    append(leaves, std.string_constant ("escapes.ohm"))
    append(leaves, std.string_constant ("escapes.rwr"))
    append(leaves, std.string_constant ("escapessupport.js"))
}


////////

run :: proc (r : ^reg.Component_Registry, source_file, main_container_name, diagram_source_file : string, injectfn : #type proc (^zd.Eh, string)) {
    // get entrypoint container
    main_container, ok := reg.get_component_instance(r, main_container_name, owner=nil)
    fmt.assertf(
        ok,
        "Couldn't find main container with page name %s in file %s (check tab names, or disable compression?)\n",
        main_container_name,
        diagram_source_file,
    )
    injectfn (main_container, source_file)
    err := print_error_maybe (main_container)
    if !err {
	print_output (main_container)
    }
}


print_output :: proc (main_container : ^zd.Eh) {
    zd.print_specific_output (main_container, "output")
}
print_error_maybe :: proc (main_container : ^zd.Eh) -> (ok: bool) {
    error_port := "error"
    edatum, found := zd.fetch_first_output (main_container, error_port)
    estr := edatum.repr (&edatum)
    err := found && 0 != len (estr)
    if err {
	fmt.println("\n\n--- !!! ERRORS found at the top level !!! ---")
	zd.print_specific_output (main_container, error_port)
    }
    return err
}

parse_command_line_args :: proc () -> (source_file : string) {
    source_file = slice.get(os.args, 1) or_else "<specify source file on command line>"
    if !os.exists(source_file) {
        fmt.println("Source file", source_file, "does not exist.")
        os.exit(1)
    }
    return source_file
}

initialize_component_palette :: proc (diagram_source_file: string) -> ^reg.Component_Registry {
    // set up standard leaves
    leaves := std.initialize (diagram_source_file)
    // add leaves specific to this project
    initialize_project_specific_components (&leaves)

    containers := reg.json2internal (diagram_source_file)
    palette := reg.make_component_registry(leaves[:], containers)
    return palette
}



