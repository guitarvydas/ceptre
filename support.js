var keepStack = [];

function resetKeep () {
    keepStack = [];
    return '';
}

function pushKeep (s) {
    keepStack.push (s);
    return s;
}

function getKeep () {
    result = '';
    keepStack.forEach (function (s) {
	result += s + ' * ';
    });
    return result;
}
