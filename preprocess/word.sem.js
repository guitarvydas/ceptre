{
    input : function (items) {
	return items.rwr ().join(''); },
    item : function (x) { return x.rwr ();},
    separator: function (c) { return c.rwr () },
    word : function (legalchars) { return "❲" + legalchars.rwr ().join ('') + "❳"; },
    legalchar: function (c) { return c.rwr (); },
    integer : function (ds) { return ds.rwr ().join (''); },
    comment: function (kcomment, cs, nl) { return kcomment.rwr () + cs.rwr ().join ('') + nl.rwr (); },
    space : function (spc) { return spc.rwr (); },
    string : function (dq1, cs, dq2) { return dq1.rwr () + cs.rwr ().join ('') + dq2.rwr (); },
    dq : function (dq) { return dq.rwr (); },

    _terminal: function() { return this.sourceString; },
    _iter: function (...children) { return children.map(c => c.rwr ()); }
}
