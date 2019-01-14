window.addEventListener('load', function() {
  document.body.innerHTML += '<hr/>';
  checkToc();
});

function checkToc() {
  var tocs = document.querySelectorAll('.toc');
  assertEqual('Count of toc', tocs.length, 7);
  var i = 0;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc1');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'Table of contents');
  var arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:clause:1.1.:Chapter 1.1',
    '2:section:1.1.1.:Chapter 1.1.1',
    '3:section:1.1.1.1.:Chapter 1.1.1.1',
    '4:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '4:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '3:section:1.1.1.2.:Chapter 1.1.1.2',
    '1:clause:1.2.:Chapter 1.2',
    '2:section:1.2.1.:Chapter 1.2.1',
    '2:section:1.2.2.:Chapter 1.2.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc2');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'), '');
  arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '1:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc3');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'Table of contents');
  var arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:preface::Preface 1',
    '2:clause::Preface 1.1',
    '3:section::Preface 1.1.1',
    '1:preface::Preface 2',
    '1:chapter:1.:Chapter 1',
    '2:clause:1.1.:Chapter 1.1',
    '3:section:1.1.1.:Chapter 1.1.1',
    '4:section:1.1.1.1.:Chapter 1.1.1.1',
    '5:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '5:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '4:section:1.1.1.2.:Chapter 1.1.1.2',
    '2:clause:1.2.:Chapter 1.2',
    '3:section:1.2.1.:Chapter 1.2.1',
    '3:section:1.2.2.:Chapter 1.2.2',
    '1:chapter:2.:Chapter 2',
    '2:clause:2.1.:Chapter 2.1',
    '1:chapter:3.:Chapter 3',
    '1:appendix:A.:Appendix 1',
    '1:appendix:B.:Appendix 2',
    '2:clause:B.1.:Appendix 2.1',
    '2:clause:B.2.:Appendix 2.2',
    '1:postface::Postface 1',
    '2:clause::Postface 1.1',
    '1:postface::Postface 2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'aaa');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'only chapter');
  arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:chapter:1.:Chapter 1',
    '1:chapter:2.:Chapter 2',
    '1:chapter:3.:Chapter 3',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'bbb');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'preface, chapter, appendix and postface');
  arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:preface::Preface 1',
    '1:preface::Preface 2',
    '1:chapter:1.:Chapter 1',
    '1:chapter:2.:Chapter 2',
    '1:chapter:3.:Chapter 3',
    '1:appendix:A.:Appendix 1',
    '1:appendix:B.:Appendix 2',
    '1:postface::Postface 1',
    '1:postface::Postface 2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc6');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'chapter, appendix, clause and section');
  arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:chapter:1.:Chapter 1',
    '2:clause:1.1.:Chapter 1.1',
    '3:section:1.1.1.:Chapter 1.1.1',
    '4:section:1.1.1.1.:Chapter 1.1.1.1',
    '5:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '5:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '4:section:1.1.1.2.:Chapter 1.1.1.2',
    '2:clause:1.2.:Chapter 1.2',
    '3:section:1.2.1.:Chapter 1.2.1',
    '3:section:1.2.2.:Chapter 1.2.2',
    '1:chapter:2.:Chapter 2',
    '2:clause:2.1.:Chapter 2.1',
    '1:chapter:3.:Chapter 3',
    '1:appendix:A.:Appendix 1',
    '1:appendix:B.:Appendix 2',
    '2:clause:B.1.:Appendix 2.1',
    '2:clause:B.2.:Appendix 2.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'ccc');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', text(tocs[i], ':scope > .title'),
    'clause and section in chapter');
  arr = [];
  visit(tocs[i], function(div, depth) {
    var index = div.querySelector(':scope > .title > .index').textContent;
    var label = div.querySelector(':scope > .title > .label').textContent;
    arr.push(depth + ':' + div.className + ':' + index + ':' + label);
  });
  assertArrayEqual('+-- tree', arr, [
    '1:clause:1.1.:Chapter 1.1',
    '2:section:1.1.1.:Chapter 1.1.1',
    '3:section:1.1.1.1.:Chapter 1.1.1.1',
    '4:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '4:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '3:section:1.1.1.2.:Chapter 1.1.1.2',
    '1:clause:1.2.:Chapter 1.2',
    '2:section:1.2.1.:Chapter 1.2.1',
    '2:section:1.2.2.:Chapter 1.2.2',
    '1:clause:2.1.:Chapter 2.1',
  ]);
}

function get(elem, selector) {
  return elem.querySelector(selector);
}
function text(elem, selector) {
  return get(elem, selector).textContent;
}
function visit(parent, fn, depth) {
  depth = depth || 1;
  var children = parent.querySelectorAll(':scope > div');
  for (var i = 0, n= children.length; i < n; i++) {
    var child = children[i];
    fn(child, depth);
    visit(child, fn, depth + 1);
  }
}
