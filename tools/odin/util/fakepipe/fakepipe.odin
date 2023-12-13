package fakepipe

initialize :: proc(leaves: ^[dynamic]reg.Leaf_Instantiator) {
    append(leaves, reg.Leaf_Template { name = "fakepipename", instantiate = fakepipename_instantiate })
}

///////

fakepipename_instantiate :: proc(name_prefix: string, name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("fakepipename")
    return zd.make_leaf (name_prefix, name_with_id, owner, nil, fakepipename_handle)
}

fakepipename_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    @(static) rand := 0
    rand += 1
    zd.send_string (eh, "output", fmt.aprintf ("/tmp/fakepipename%d", rand), msg)
}

