window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkLineBreak();
    checkBold();
    checkItalic();
    checkUnderline();
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
