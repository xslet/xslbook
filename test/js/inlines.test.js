window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkLineBreak();
    checkBold();
    checkItalic();
    checkUnderline();
    checkSuperscriptAndSubscript();
    checkHorizontalLine();
  } catch (e) {
    fail(e);
  }
});

function checkLineBreak() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(1) > .body > p');
  assertEqual('Line break', para.innerHTML,
    'This sentence contains<br>a line break.');
}

function checkBold() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(2) > .body > p');
  assertEqual('Bold', para.innerHTML,
    'This sentence contains a <b>BOLD</b> text.');
}

function checkItalic() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(3) > .body > p');
  assertEqual('Italic', para.innerHTML,
    'This sentence contains a <i>italic</i> text.');
}

function checkUnderline() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(4) > .body > p');
  assertEqual('Underline', para.innerHTML,
    'This sentence contains a <u>underlined</u> text.');
}

function checkSuperscriptAndSubscript() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(5) > .body > p');
  assertEqual('Superscript &amp; Subscript', para.innerHTML,
    'This sentence contains a <sup>superscript</sup> and ' +
    'a <sub>subscript</sub> text.');
}

function checkHorizontalLine() {
  var para = document.querySelector(
    '.xslbook > .chapter:nth-of-type(6) > .body > p');
  assertEqual('Horizontal line', para.innerHTML,
   'This sentence is upper of a horizontal line.' +
   '<hr>' +
   'This sentence is lower of a horizontal line.');
}
