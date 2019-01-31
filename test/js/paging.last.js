window.addEventListener('load', function() {
  try {
    write('<hr/>');
    write('<b>Header:</b><br/>');
    checkNaviLinksInLastPage('header');
    write('<b>Footer:</b><br/>');
    checkNaviLinksInLastPage('footer');
    write('<b>Toc:</b><br/>');
    checkTocList();
  } catch (e) {
    fail(e);
  }
});

function checkNaviLinksInLastPage(parentTag) {
  var parent = document.getElementsByTagName(parentTag)[0];
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .navi-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'navi-page navi-previous');

  var prevLink = prevPage.querySelector(S(':scope > a'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className, '');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    './paging.test.xml');

  var nextPage = naviPages[1];
  assertEqual('Next page navi\'s class', nextPage.className,
    'navi-page navi-next');

  var nextLink = nextPage.querySelector(S(':scope > a'));
  assertEqual('Next page link\'s text', nextLink.textContent, 'next');
  assertEqual('Next page link\'s class', nextLink.className, 'disabled');
  assertEqual('Next page link\'s href', nextLink.getAttribute('href'), null);

  var tocPage = naviPages[2];
  assertEqual('Toc page navi\'s class', tocPage.className,
    'navi-page navi-toc');

  var tocLink = tocPage.querySelector(S(':scope > a'));
  assertEqual('Toc page link\'s text', tocLink.textContent,
    'table of contents');
  assertEqual('Toc page link\'s class', tocLink.className, '');
  assertEqual('Toc page link\'s href', tocLink.getAttribute('href'),
    'paging.toc.xml');

}

function treeNodeToString(div, depth) {
  var title = div.querySelector(S(':scope > .title'));
  if (!title) {
    return depth + ':' + div.className;
  } else if (title.tagName === 'A') {
    var a = title;
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  } else {
    return depth + ':' + div.className + ':' + title.className + ':' +
      title.textContent;
  }
}

function checkTocList() {
  var tocs = document.getElementsByClassName('toc');
  assertEqual('Count of tocs', tocs.length, 4);

  var i = 0;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Table of contents');
  assertEqual('ID of toc', tocs[i].id, 'idxbktoc1');
  assertTreeEqual('+-- toc', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-chapter:title:5.Chapter (5):' +
      './paging.last.xml#idxbkchapter1',
    '3:toc-clause:title:5.1.Clause (5.1):' +
      './paging.last.xml#idxbkclause1',
    '4:toc-section:title:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '5:toc-section:title:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '5:toc-section:title:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '4:toc-section:title:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
    '3:toc-clause:title:5.2.Clause (5.2):' +
      './paging.last.xml#idxbkclause2',
    '4:toc-section:title:5.2.1.Section (5.2.1):' +
      './paging.last.xml#idxbksection5',
    '4:toc-section:title:5.2.2.Section (5.2.2):' +
      './paging.last.xml#idxbksection6',
    '2:toc-appendix:title:C.Appendix (3):' +
      './paging.last.xml#idxbkappendix1',
    '3:toc-clause:title:C.1.Clause (3.1):' +
      './paging.last.xml#idxbkclause3',
    '4:toc-section:title:C.1.1.Section (3.1.1):' +
      './paging.last.xml#idxbksection7',
    '4:toc-section:title:C.1.2.Section (3.1.2):' +
      './paging.last.xml#idxbksection8',
    '3:toc-clause:title:C.2.Clause (3.2):' +
      './paging.last.xml#idxbkclause4',
    '4:toc-section:title:C.2.1.Section (3.2.1):' +
      './paging.last.xml#idxbksection9',
    '4:toc-section:title:C.2.2.Section (3.2.2):' +
      './paging.last.xml#idxbksection10',
    '2:toc-chapter:title:6.Chpater (6):' +
      './paging.last.xml#idxbkchapter2',
    '2:toc-appendix:title:D.Appendix (4):' +
      './paging.last.xml#idxbkappendix2',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section (id=aaa)');
  assertEqual('ID of toc', tocs[i].id, 'aaa');
  assertTreeEqual('+-- toc', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-clause:title:5.1.Clause (5.1):' +
      './paging.last.xml#idxbkclause1',
    '3:toc-section:title:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '4:toc-section:title:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '4:toc-section:title:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '3:toc-section:title:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
    '2:toc-clause:title:5.2.Clause (5.2):' +
      './paging.last.xml#idxbkclause2',
    '3:toc-section:title:5.2.1.Section (5.2.1):' +
      './paging.last.xml#idxbksection5',
    '3:toc-section:title:5.2.2.Section (5.2.2):' +
      './paging.last.xml#idxbksection6',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section (id=bbb)');
  assertEqual('ID of toc', tocs[i].id, 'bbb');
  assertTreeEqual('+-- toc', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-section:title:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '3:toc-section:title:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '3:toc-section:title:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '2:toc-section:title:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section');
  assertEqual('ID of toc', tocs[i].id, 'idxbktoc4');
  assertTreeEqual('+-- toc', tocs[i], 'div', treeNodeToString, [
    '1:body',
    '2:toc-section:title:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '2:toc-section:title:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
  ]);
}
