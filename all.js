var keepStack = [];

function resetKeep () {
    keepStack = [];
    return '';
}

function pushKeep (s) {
    keepStack.push (s);
    return '';
}

function getKeep () {
    return keepStack.join ('\n');
}

var retractStack = [];

function resetRetract () {
    retractStack = [];
    return '';
}

function pushRetract (s) {
    retractStack.push (s);
    return '';
}

function getRetract () {
    return retractStack.join ('\n');
}

var namestack = [];

function namestacktop () {
    return namestack[namestack.length - 1];
}

function _eval (x) {
    try {
	return x._fab ();
    } catch (err) {
	throw new Error (`internal error in _eval: ${err}`);
	return '';
    }
}
    
function resetnamestack () {
    namestack = [];
    return '';
}

function pushname (typ, s) {
    try {
	namestack.push ({'kind':typ, 'val':s});
	return '';
    } catch (err) {
	throw new Error  (`internal error in pushname: ${err}`);
    }
}

function getname (typ) {
    var item = namestacktop ();
    if (typ === item.kind) {
	return item.val;
    } else {
	throw new Error ('internal error : name kind mismatch');
    }
}

function popname () {
    namestack.pop ();
    return '';
}


var counter = 0;
function gensym (prefix) {
    counter = counter + 1;
    return `${prefix}${counter}`;
}