window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkToc();
  } catch (e) {
    fail(e);
  }
});

function checkToc() {
  var ua = xslet.platform.ua;
  var tocs = ua.MSIE ? document.getElementsByClassName('toc') :
    document.querySelectorAll('.toc');
  assertEqual('Count of toc', tocs.length, 8);
  var i = 0;

  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc1');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'Table of contents');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var title = div.querySelector(S(':scope > .title'));
    var index = title.querySelector(S(':scope > .index')).textContent;
    var label = title.querySelector(S(':scope > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
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
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, '');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var title = div.querySelector(S(':scope > .title'));
    var index = title.querySelector(S(':scope > .index')).textContent;
    var label = title.querySelector(S(':scope > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
    '1:section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '1:section:1.1.1.1.2.:Chapter 1.1.1.1.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc3');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'Table of contents');

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc4');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'Table of contents');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var title = div.querySelector(S(':scope > .title'));
    var index = title.querySelector(S(':scope > .index')).textContent;
    var label = title.querySelector(S(':scope > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
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
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'only chapter');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var title = div.querySelector(S(':scope > .title'));
    var index = title.querySelector(S(':scope > .index')).textContent;
    var label = title.querySelector(S(':scope > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
    '1:chapter:1.:Chapter 1',
    '1:chapter:2.:Chapter 2',
    '1:chapter:3.:Chapter 3',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'bbb');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'preface, chapter, appendix and postface');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var index = div.querySelector(S(':scope > .title > .index')).textContent;
    var label = div.querySelector(S(':scope > .title > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
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
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc7');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'chapter, appendix, clause and section');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var index = div.querySelector(S(':scope > .title > .index')).textContent;
    var label = div.querySelector(S(':scope > .title > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
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
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'clause and section in chapter');
  assertTreeEqual('+-- tree', tocs[i], 'div', function(div, depth) {
    var index = div.querySelector(S(':scope > .title > .index')).textContent;
    var label = div.querySelector(S(':scope > .title > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  }, [
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
