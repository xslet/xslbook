window.addEventListener('load', function() {
  document.body.innerHTML += '<hr/>';
  checkWindowTitle();
  checkCssLinks();
  checkScriptLinks();
  checkXslbookId();
  checkPageTitle();
  checkPageBody();
});

function checkWindowTitle() {
  var title = document.querySelector('html > head > title').textContent;
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
  var sections = document.querySelectorAll('section.xslbook');
  var cnt = sections.length;
  var id = sections[0].id;
  assertEqual('Count of section.xslbook elements', cnt , 1);
  assertEqual('ID of section.xslbook[0]', id, 'pageId');
}

function checkPageTitle() {
  var title = document.querySelector('section.xslbook > h1.title').textContent;
  assertEqual('Page title', title, 'Base');
}

function checkPageBody() {
  var body = document.querySelector('section.xslbook > div.body').textContent;
  assertEqual('Page body', body, 'This is the body of the page.');
}
