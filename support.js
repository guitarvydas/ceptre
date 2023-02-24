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


///////////// indenter

function indenter (str) {
    indentation = [];
    let result = '';
    if (str) {
	str.split ('\n').forEach (line => {
	    let s = indent1 (line);
	    result += '\n' + s;
	});
    }
    return result;
}



 let indentation = [];
 // we emit code using bracketed notation (- and -) which is compatible
 // lisp pretty-printing, which allows easier debugging of the transpiled code
 // then, for Python, we convert the bracketing into indentation...
 function indent1 (s) {
   let opens = (s.match (/\(-/g) || []).length;
   let closes = (s.match (/-\)/g) || []).length;
     // let r0 = s.trim ();
     let r0 = s;
   let r1 = r0.replace (/\(-/g, '');
   let r2 = r1.replace (/-\)/g, '');
   let spaces = indentation.join ('');
   let r  = spaces + r2.replace (/\n/g, spaces);
   let diff = opens - closes;
   if (diff > 0) {
       while (diff > 0) {
           indentation.push ('  ');
           diff -=1;
       }
   } else {
     while (diff < 0) {
         indentation.pop ();
         diff += 1;
     }
   }
   return r;
 }
 
