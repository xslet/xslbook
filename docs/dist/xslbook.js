(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.xslet = f()}})(function(){var define,module,exports;return (function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
'use strict';

/* global window */

var xslet = {};

xslet.platform = require('@xslet/platform')(window);

module.exports = xslet;

},{"@xslet/platform":7}],2:[function(require,module,exports){
'use strict';

function compareVersions(obj, name, version) {
  if (obj.name !== name || obj.name === 'UNKNOWN') {
    return NaN;
  }

  var arr1 = obj.version.split('.');
  for (var i1 = 0, n1 = arr1.length; i1 < n1; i1++) {
    arr1[i1] = parseInt(arr1[i1], 10);
  }

  var arr2 = version.split('.');
  for (var i2 = 0, n2 = arr2.length; i2 < n2; i2++) {
    arr2[i2] = parseInt(arr2[i2], 10);
  }

  for (var i = 0, n = arr1.length; i < n; i++) {
    if (i >= arr2.length) {
      return 1;
    }

    if (arr1[i].length || isNaN(arr1[i]) ||
        arr2[i].length || isNaN(arr2[i])) {
      return NaN;
    }

    if (arr1[i] < arr2[i]) {
      return -1;
    }

    if (arr1[i] > arr2[i]) {
      return 1;
    }
  }

  if (arr1.length < arr2.length) {
    return -1;
  }

  return 0;
}

module.exports = compareVersions;

},{}],3:[function(require,module,exports){
'use strict';

var compareVersions = require('./compare-versions');

function createComparable() {
  var obj = {};

  Object.defineProperties(obj, {
    lt: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) < 0);
      },
    },
    lte: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) <= 0);
      },
    },
    gt: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) > 0);
      },
    },
    gte: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) >= 0);
      },
    },
    eq: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) === 0);
      },
    },
    ne: {
      enumerable: true,
      value: function(name, version) {
        return (compareVersions(obj, name, version) !== 0);
      },
    },
  });

  return obj;
}

module.exports = createComparable;

},{"./compare-versions":2}],4:[function(require,module,exports){
'use strict';

var createComparable = require('./create-comparable');
var getVersion = require('./get-version');
var setNameAndVersion = require('./set-name-and-version');

/* eslint max-statements: "off" */

function detectOS(useragent) {
  var os = createComparable(),
      version,
      candids = [
        'IPOD',
        'IPAD',
        'IPHONE',
        'ANDROID',
        'WINNT',
        'MACOS',
        'LINUX',
        'UNKNOWN',
      ];

  if (useragent.indexOf('IPOD') >= 0) {
    version = getVersion(useragent, 'IPHONE OS', 2);
    setNameAndVersion(os, candids, 'IPOD', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: true });
    return os;
  }

  if (useragent.indexOf('IPAD') >= 0) {
    version = getVersion(useragent, 'IPHONE OS', 2);
    if (!version) {
      version = getVersion(useragent, 'CPU OS', 2);
    }
    setNameAndVersion(os, candids, 'IPAD', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: true });
    return os;
  }

  if (useragent.indexOf('IPHONE') >= 0) {
    version = getVersion(useragent, 'IPHONE OS', 2);
    setNameAndVersion(os, candids, 'IPHONE', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: true });
    return os;
  }

  if ((version = getVersion(useragent, 'ANDROID', 2)) != null) {
    setNameAndVersion(os, candids, 'ANDROID', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: false });
    return os;
  }

  if ((version = getVersion(useragent, 'WINDOWS', 2)) != null) {
    setNameAndVersion(os, candids, 'WINNT', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: false });
    return os;
  }

  if ((version = getVersion(useragent, 'MAC OS X', 2)) != null) {
    setNameAndVersion(os, candids, 'MACOS', version);
    Object.defineProperty(os, 'IOS', { enumerable: true, value: false });
    return os;
  }

  if (useragent.indexOf('LINUX') >= 0) {
    setNameAndVersion(os, candids, 'LINUX', '');
    Object.defineProperty(os, 'IOS', { enumerable: true, value: false });
    return os;
  }

  setNameAndVersion(os, candids, 'UNKNOWN', '');
  Object.defineProperty(os, 'IOS', { enumerable: true, value: false });
  return os;
}

module.exports = detectOS;

},{"./create-comparable":3,"./get-version":6,"./set-name-and-version":9}],5:[function(require,module,exports){
'use strict';

var createComparable = require('./create-comparable');
var getVersion = require('./get-version');
var setNameAndVersion = require('./set-name-and-version');

/* eslint max-statements: "off" */

function detectUA(useragent) {
  var ua = createComparable(),
      version,
      candids = [
        'FIREFOX',
        'CHROME',
        'EDGE',
        'MSIE',
        'SAFARI',
        'OPERA',
        'VIVALDI',
        'PHANTOMJS',
        'UNKNOWN',
      ];

  if (useragent.indexOf('OPERA') >= 0) {
    version = getVersion(useragent, 'VERSION');
    setNameAndVersion(ua, candids, 'OPERA', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'OPR'))) {
    setNameAndVersion(ua, candids, 'OPERA', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'OPIOS'))) {
    setNameAndVersion(ua, candids, 'OPERA', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'EDGE'))) {
    setNameAndVersion(ua, candids, 'EDGE', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'MSIE'))) {
    setNameAndVersion(ua, candids, 'MSIE', version);
    return ua;
  }

  if (useragent.indexOf('TRIDENT') >= 0) {
    setNameAndVersion(ua, candids, 'MSIE', getVersion(useragent, 'RV'));
    return ua;
  }

  if ((version = getVersion(useragent, 'VIVALDI'))) {
    setNameAndVersion(ua, candids, 'VIVALDI', version);
    return ua;
  }

  if (useragent.indexOf('FXIOS') >= 0) {
    setNameAndVersion(ua, candids, 'FIREFOX', '');
    return ua;
  }

  if ((version = getVersion(useragent, 'CHROME'))) {
    setNameAndVersion(ua, candids, 'CHROME', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'CRIOS'))) {
    setNameAndVersion(ua, candids, 'CHROME', version);
    return ua;
  }

  if ((version = getVersion(useragent, 'PHANTOMJS'))) {
    setNameAndVersion(ua, candids, 'PHANTOMJS', version);
    return ua;
  }

  if (useragent.indexOf('SAFARI') >= 0) {
    setNameAndVersion(ua, candids, 'SAFARI', getVersion(useragent, 'VERSION'));
    return ua;
  }

  if ((version = getVersion(useragent, 'FIREFOX'))) {
    setNameAndVersion(ua, candids, 'FIREFOX', version);
    return ua;
  }

  setNameAndVersion(ua, candids, 'UNKNOWN', '');
  return ua;
}

module.exports = detectUA;

},{"./create-comparable":3,"./get-version":6,"./set-name-and-version":9}],6:[function(require,module,exports){
'use strict';

function getVersion(useragent, key, num) {
  num = num || 1;
  var index = useragent.indexOf(key);
  if (index < 0) {
    return null;
  }

  var str = useragent.slice(index + key.length);
  str = str.replace(/[^0-9)]*/, '');

  var version = '';
  for (var i = 0; i < num; i++) {
    var result = /[^0-9]/.exec(str);
    if (result && result.index > 0) {
      version += '.' + str.slice(0, result.index);
      str = str.slice(result.index + 1);
    }
  }

  return version.slice(1);
}

module.exports = getVersion;

},{}],7:[function(require,module,exports){
'use strict';

var detectUA = require('./detect-ua');
var detectOS = require('./detect-os');
var setHtmlTagClass = require('./set-html-tag-class');

function createPlatform(window) {
  var userAgent = window.navigator.userAgent.toUpperCase();
  var htmlTag = window.document.getElementsByTagName('html')[0];

  var ua = detectUA(userAgent);
  var os = detectOS(userAgent);

  setHtmlTagClass(htmlTag, ua, os);

  var platform = {};

  Object.defineProperties(platform, {
    ua: { enumerable: true, value: ua },
    os: { enumerable: true, value: os },
  });

  return platform;
}

module.exports = createPlatform;

},{"./detect-os":4,"./detect-ua":5,"./set-html-tag-class":8}],8:[function(require,module,exports){
'use strict';

function setHtmlTagClass(htmlTag, ua, os) {
  var cls = htmlTag.className || '';
  if (cls) {
    cls += ' ';
  }

  cls += ua.name;
  if (ua.version) {
    cls += ' ' + ua.name + '-' + String(ua.version).replace(/\./, '_');
  }

  cls += ' ' + os.name;
  if (os.version) {
    cls += ' ' + os.name + '-' + String(os.version).replace(/\./, '_');
  }
  if (os.IOS) {
    cls += ' IOS';
  }

  htmlTag.className = cls;
}

module.exports = setHtmlTagClass;

},{}],9:[function(require,module,exports){
'use strict';

function setNameAndVersion(obj, candids, name, version) {
  Object.defineProperty(obj, 'name', { enumerable: true, value: name });
  Object.defineProperty(obj, 'version', { enumerable: true, value: version });
  Object.defineProperty(obj, name, { enumerable: true, value: true });

  for (var i = 0, n = candids.length; i < n; i++) {
    if (candids[i] === name) {
      continue;
    }
    Object.defineProperty(obj, candids[i], { enumerable: true, value: false });
  }
}

module.exports = setNameAndVersion;

},{}]},{},[1])(1)
});
