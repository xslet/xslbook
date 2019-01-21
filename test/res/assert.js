function debug(html) {
  var debugArea = document.getElementById('debug');
  if (!debugArea) {
    debugArea = document.createElement('div');
    document.body.appendChild(debugArea);
  }
  debugArea.innerHTML += html;
}

function assertEqual(text, result, expect) {
  var html = '<div><code>' + text + ' = [' + result + '] … ';
  if (expect === result) {
    html += '<span style="color:#0d0">PASS</span>';
  } else {
    html += '<span style="color:#d00">FAIL</span>';
    document.querySelector('h1').style.backgroundColor = '#f00';
  }
  html += '</code></div>';
  debug(html);
}

function assertArrayEqual(text, result, expect) {
  var html = '<div><code>' + text + ' = [<br/>';
  var n = Math.max(result.length, expect.length);
  for (var i = 0; i < n; i++) {
    html += '&nbsp;[' + result[i] + '] … ';
    if (expect[i] === result[i]) {
      html += '<span style="color:#0d0">PASS</span><br/>';
    } else {
      html += '<span style="color:#d00">FAIL</span><br/>';
      document.querySelector('h1').style.backgroundColor = '#f00';
    }
  }
  html += ']</code></div>';
  debug(html);
}

function assertTreeEqual(text, base, tag, fn, expect) {
  var result = [];
  _assertTreeEqual_r(result, base, tag, fn, 1);
  assertArrayEqual(text, result, expect);
}

function _assertTreeEqual_r(arr, parent, tag, fn, depth) {
  for (var i = 0, n = parent.children.length; i < n; i++) {
    var child = parent.children[i];
    if (child.tagName.toUpperCase() === tag.toUpperCase()) {
      arr.push(fn(child, depth));
      _assertTreeEqual_r(arr, child, tag, fn, depth + 1);
    }
  }
}

function write(text) {
  debug(text);
}

function fail(e) {
  if (e != null) {
    var html = '<div><code>' + e.stack + '</code></div>';
    debug(html);
    document.getElementsByTagName('h1')[0].style.backgroundColor = '#f00';
  }
}

function S(selector) {
  return selector.replace(/\s*:scope\s*>/, '').trim();
}
