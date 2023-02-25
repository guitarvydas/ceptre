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
    return stageNameStack.join ('\n');
}
