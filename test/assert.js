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
