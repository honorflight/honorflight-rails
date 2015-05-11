'use strict';

var Loader = (function() {

  var _xhrSuccess = function() {
    this.callback.apply(this, this.arguments);
  };

  var _xhrError = function() {
    console.error(this.statusText);
  };

  var loadFile = function(sURL, fCallback /*, argumentToPass1, argumentToPass2, etc. */ ) {
    var oReq = new XMLHttpRequest();
    oReq.callback = fCallback;
    oReq.arguments = Array.prototype.slice.call(arguments, 2);
    oReq.onload = _xhrSuccess;
    oReq.onerror = _xhrError;
    oReq.open('get', sURL, true);
    oReq.send(null);
  };

  return {
    load: loadFile
  };

})();