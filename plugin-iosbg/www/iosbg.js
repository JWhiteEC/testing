var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var iosbg=function(){};
iosbg.update = function(c,z) { cordova.exec(function(){}, function(err) { console.warn('iosbg: error: ',err); }, "iosbg", "update", [c,z]); };
module.exports = iosbg;

