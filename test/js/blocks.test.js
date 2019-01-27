window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkParagraphs();
  } catch (e) {
    fail(e);
  }
});

function checkParagraphs() {
  var para = document.querySelectorAll('.xslbook > .chapter > .body > p');
  assertEqual('Paragraph 1', para[0].textContent, 'This is a paragraph.');
  assertEqual('Paragraph 2', para[1].textContent, 'This is a paragraph, too.');
}
