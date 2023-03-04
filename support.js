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

function down_resetnamestack () {
    try {
	namestack = [];
	return '';
    } catch (err) {
	console.error (`internal error in down_pushname: ${err}`);
	return '';
    }
}

function down_pushname (typ, s) {
    try {
	var s = s._fab ();
	namestack.push ({'kind':typ, 'val':s});
	return '';
    } catch (err) {
	console.error (`internal error in down_pushname: ${err}`);
	return '';
    }
}

function getname (typ) {
    console.error (`getname ${typ}`);
    var item = namestacktop ();
    if (typ === item.kind) {
	return item.val;
    } else {
	throw 'internal error : name kind mismatch';
    }
}

function popname () {
    console.error (`popname`);
    namestack.pop ();
    return '';
}
