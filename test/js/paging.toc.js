window.addEventListener('load', function() {
  try {
    write('<hr/>');
    write('<b>Header:</b><br/>');
    checkNaviLinksInFirstPage('header');
    write('<b>Footer:</b><br/>');
    checkNaviLinksInFirstPage('footer');
    write('<b>Toc:</b><br/>');
    checkTocList();
  } catch (e) {
    fail(e);
  }
});

function checkNaviLinksInFirstPage(parentTag) {
  var parent = document.getElementsByTagName(parentTag)[0];
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .navi-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'navi-page navi-previous');

  var prevLink = prevPage.querySelector(S(':scope > .link'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className,
    'link disabled');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    null);

  var nextPage = naviPages[1];
  assertEqual('Next page navi\'s class', nextPage.className,
    'navi-page navi-next');

  var nextLink = nextPage.querySelector(S(':scope > .link'));
  assertEqual('Next page link\'s text', nextLink.textContent, 'next');
  assertEqual('Next page link\'s class', nextLink.className, 'link');
  assertEqual('Next page link\'s href', nextLink.getAttribute('href'),
    './paging.test.xml');

  var tocPage = naviPages[2];
  assertEqual('Toc page navi\'s class', tocPage.className,
    'navi-page navi-toc');

  var tocLink = tocPage.querySelector(S(':scope > .link'));
  assertEqual('Toc page link\'s text', tocLink.textContent,
    'table of contents');
  assertEqual('Toc page link\'s class', tocLink.className, 'link');
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
  assertEqual('Count of tocs', tocs.length, 1);

  var title = tocs[0].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Table of contents');
  assertEqual('ID of toc', tocs[0].id, 'idxbktoc1');
  assertTreeEqual('+-- toc', tocs[0], 'div', treeNodeToString, [
    '1:body',
    '2:toc-preface:title link:Preface:' +
      './paging.toc.xml#idxbkpreface1',
    '3:toc-clause:title link:Preface (1.1):' +
      './paging.toc.xml#idxbkclause1',
    '2:toc-chapter:title link:1.Chapter (1):' +
      './paging.toc.xml#idxbkchapter1',
    '2:toc-chapter:title link:2.Chapter (2):' +
      './paging.toc.xml#idxbkchapter2',
    '3:toc-clause:title link:2.1.Chapter (2.1):' +
      './paging.toc.xml#idxbkclause2',
    '2:toc-chapter:title link:3.Chapter (3):' +
      './paging.test.xml#idxbkchapter1',
    '3:toc-clause:title link:3.1.Clause (3.1):' +
      './paging.test.xml#idxbkclause1',
    '2:toc-appendix:title link:A.Appendix (1):' +
      './paging.test.xml#idxbkappendix1',
    '3:toc-clause:title link:A.1.Clause (1.1):' +
      './paging.test.xml#idxbkclause2',
    '2:toc-chapter:title link:4.Chapter (4):' +
      './paging.test.xml#idxbkchapter2',
    '3:toc-clause:title link:4.1.Clause (4.1):' +
      './paging.test.xml#idxbkclause3',
    '2:toc-appendix:title link:B.Appendix (2):' +
      './paging.test.xml#idxbkappendix2',
    '3:toc-clause:title link:B.1.Clause (2.1):' +
      './paging.test.xml#idxbkclause4',
    '2:toc-part:title:Part 1',
    '3:toc-chapter:title link:5.Chapter (5):' +
      './paging.last.xml#idxbkchapter1',
    '4:toc-clause:title link:5.1.Clause (5.1):' +
      './paging.last.xml#idxbkclause1',
    '4:toc-clause:title link:5.2.Clause (5.2):' +
      './paging.last.xml#idxbkclause2',
    '3:toc-appendix:title link:C.Appendix (3):' +
      './paging.last.xml#idxbkappendix1',
    '4:toc-clause:title link:C.1.Clause (3.1):' +
      './paging.last.xml#idxbkclause3',
    '4:toc-clause:title link:C.2.Clause (3.2):' +
      './paging.last.xml#idxbkclause4',
    '3:toc-chapter:title link:6.Chpater (6):' +
      './paging.last.xml#idxbkchapter2',
    '3:toc-appendix:title link:D.Appendix (4):' +
      './paging.last.xml#idxbkappendix2',
  ]);
}
