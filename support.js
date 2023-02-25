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
	result += "s\n";
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
	result += " s\n";
    });
    return result;
}

var stageNameStack = [];

function resetStageName () {
    stageNameStack = [];
    return '';
}

function pushStageName (s) {
    stageNameStack.push (s);
    return '';
}

function getStageName () {
    result = '';
    stageNameStack.forEach (function (s) {
	result += "«stage(" + s + '),»\n';
    });
    return result;
}
