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
    result = '';
    keepStack.forEach (function (s) {
	result += "«assert(" + s + '),»\n';
    });
    return result;
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
    result = '';
    retractStack.forEach (function (s) {
	result += "«retract(" + s + '),»\n';
    });
    return result;
}
