window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkToc();
  } catch (e) {
    fail(e);
  }
});

function treeNodeToString(div, depth) {
  var title = div.querySelector(S(':scope > .title'));
  if (title) {
    var index = title.querySelector(S(':scope > .index')).textContent;
    var label = title.querySelector(S(':scope > .label')).textContent;
    return depth + ':' + div.className + ':' + index + ':' + label;
  } else {
    return depth + ':' + div.className;
  }
}

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
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-clause:1.1.:Chapter 1.1',
    '3:toc-section:1.1.1.:Chapter 1.1.1',
    '4:toc-section:1.1.1.1.:Chapter 1.1.1.1',
    '5:toc-section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '5:toc-section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '4:toc-section:1.1.1.2.:Chapter 1.1.1.2',
    '2:toc-clause:1.2.:Chapter 1.2',
    '3:toc-section:1.2.1.:Chapter 1.2.1',
    '3:toc-section:1.2.2.:Chapter 1.2.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc2');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, '');
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '2:toc-section:1.1.1.1.2.:Chapter 1.1.1.1.2',
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
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-preface::Preface 1',
    '3:toc-clause::Preface 1.1',
    '4:toc-section::Preface 1.1.1',
    '2:toc-preface::Preface 2',
    '2:toc-chapter:1.:Chapter 1',
    '3:toc-clause:1.1.:Chapter 1.1',
    '4:toc-section:1.1.1.:Chapter 1.1.1',
    '5:toc-section:1.1.1.1.:Chapter 1.1.1.1',
    '6:toc-section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '6:toc-section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '5:toc-section:1.1.1.2.:Chapter 1.1.1.2',
    '3:toc-clause:1.2.:Chapter 1.2',
    '4:toc-section:1.2.1.:Chapter 1.2.1',
    '4:toc-section:1.2.2.:Chapter 1.2.2',
    '2:toc-chapter:2.:Chapter 2',
    '3:toc-clause:2.1.:Chapter 2.1',
    '2:toc-chapter:3.:Chapter 3',
    '2:toc-appendix:A.:Appendix 1',
    '2:toc-appendix:B.:Appendix 2',
    '3:toc-clause:B.1.:Appendix 2.1',
    '3:toc-clause:B.2.:Appendix 2.2',
    '2:toc-postface::Postface 1',
    '3:toc-clause::Postface 1.1',
    '2:toc-postface::Postface 2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'aaa');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'only chapter');
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-chapter:1.:Chapter 1',
    '2:toc-chapter:2.:Chapter 2',
    '2:toc-chapter:3.:Chapter 3',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'bbb');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'preface, chapter, appendix and postface');
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-preface::Preface 1',
    '2:toc-preface::Preface 2',
    '2:toc-chapter:1.:Chapter 1',
    '2:toc-chapter:2.:Chapter 2',
    '2:toc-chapter:3.:Chapter 3',
    '2:toc-appendix:A.:Appendix 1',
    '2:toc-appendix:B.:Appendix 2',
    '2:toc-postface::Postface 1',
    '2:toc-postface::Postface 2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'idxbktoc7');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'chapter, appendix, clause and section');
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-chapter:1.:Chapter 1',
    '3:toc-clause:1.1.:Chapter 1.1',
    '4:toc-section:1.1.1.:Chapter 1.1.1',
    '5:toc-section:1.1.1.1.:Chapter 1.1.1.1',
    '6:toc-section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '6:toc-section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '5:toc-section:1.1.1.2.:Chapter 1.1.1.2',
    '3:toc-clause:1.2.:Chapter 1.2',
    '4:toc-section:1.2.1.:Chapter 1.2.1',
    '4:toc-section:1.2.2.:Chapter 1.2.2',
    '2:toc-chapter:2.:Chapter 2',
    '3:toc-clause:2.1.:Chapter 2.1',
    '2:toc-chapter:3.:Chapter 3',
    '2:toc-appendix:A.:Appendix 1',
    '2:toc-appendix:B.:Appendix 2',
    '3:toc-clause:B.1.:Appendix 2.1',
    '3:toc-clause:B.2.:Appendix 2.2',
  ]);

  i++;
  assertEqual('toc[' + i + ']', tocs[i].id, 'ccc');
  assertEqual('+-- tagName', tocs[i].tagName, 'NAV');
  assertEqual('+-- title', tocs[i].querySelector(S(':scope > .title'))
    .textContent, 'clause and section in chapter');
  assertTreeEqual('+-- tree', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-clause:1.1.:Chapter 1.1',
    '3:toc-section:1.1.1.:Chapter 1.1.1',
    '4:toc-section:1.1.1.1.:Chapter 1.1.1.1',
    '5:toc-section:1.1.1.1.1.:Chapter 1.1.1.1.1',
    '5:toc-section:1.1.1.1.2.:Chapter 1.1.1.1.2',
    '4:toc-section:1.1.1.2.:Chapter 1.1.1.2',
    '2:toc-clause:1.2.:Chapter 1.2',
    '3:toc-section:1.2.1.:Chapter 1.2.1',
    '3:toc-section:1.2.2.:Chapter 1.2.2',
    '2:toc-clause:2.1.:Chapter 2.1',
  ]);
}
