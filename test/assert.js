function assertEqual(text, result, expect) {
  var html = '<div><code>' + text + ' = [' + result + '] … ';
  if (expect === result) {
    html += '<span style="color:#0d0">PASS</span>';
  } else {
    html += '<span style="color:#d00">FAIL</span>';
    document.querySelector('h1').style.backgroundColor = '#f00';
  }
  html += '</code></div>';
  document.body.innerHTML += html;
}

function assertArrayEqual(text, result, expect) {
  var html = '<div><code>' + text + ' = [<br/>';
  var n = Math.max(result.length, expect.length);
  for (var i = 0; i < n; i++) {
    html += ' [' + result[i] + '] … ';
    if (expect[i] === result[i]) {
      html += '<span style="color:#0d0">PASS</span><br/>';
    } else {
      html += '<span style="color:#d00">FAIL</span><br/>';
      document.querySelector('h1').style.backgroundColor = '#f00';
    }
  }
  html += ']</code></div>';
  document.body.innerHTML += html;
}
