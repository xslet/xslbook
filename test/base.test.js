window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkWindowTitle();
    checkCssLinks();
    checkScriptLinks();
    checkXslbookId();
    checkPageTitle();
    checkPageBody();
  } catch (e) {
    fail(e);
  }
});

function checkWindowTitle() {
  var title = document.querySelector('title').textContent;
  assertEqual('Window title', title, 'Base');
}

function checkCssLinks() {
  var links = document.querySelectorAll('link');
  assertEqual('Count of link elements', links.length, 1);
  assertEqual('Css file', links[0].getAttribute('href'), './xslbook.css');
}

function checkScriptLinks() {
  var scripts = document.querySelectorAll('script');
  assertEqual('Count of script elements', scripts.length, 3);
  var src0 = scripts[0].getAttribute('src');
  var src1 = scripts[1].getAttribute('src');
  var src2 = scripts[2].getAttribute('src');
  assertEqual('Script file[0]', src0, './xslbook.js');
  assertEqual('Script file[1]', src1, './assert.js');
  assertEqual('Script file[2]', src2, './base.test.js');
}

function checkXslbookId() {
  var sections = document.querySelectorAll('.xslbook');
  var cnt = sections.length;
  assertEqual('Count of section.xslbook elements', cnt , 1);
  var id = sections[0].id;
  assertEqual('ID of section.xslbook[0]', id, 'pageId');
}

function checkPageTitle() {
  var xslbook = document.querySelector('.xslbook');
  var title = xslbook.querySelector(S(':scope > .title')).textContent;
  assertEqual('Page title', title, 'Base');
}

function checkPageBody() {
  var xslbook = document.querySelector('.xslbook');
  var body = xslbook.querySelector(S(':scope > .body')).textContent;
  assertEqual('Page body', body, 'This is the body of the page.');
}
