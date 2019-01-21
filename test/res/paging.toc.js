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
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .go-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'go-page to-previous');

  var prevLink = prevPage.querySelector(S(':scope > .link'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className,
    'link disabled');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    null);

  var tocPage = naviPages[1];
  assertEqual('Toc page navi\'s class', tocPage.className, 'go-page to-toc');

  var tocLink = tocPage.querySelector(S(':scope > .link'));
  assertEqual('Toc page link\'s text', tocLink.textContent,
    'table of contents');
  assertEqual('Toc page link\'s class', tocLink.className, 'link');
  assertEqual('Toc page link\'s href', tocLink.getAttribute('href'),
    'paging.toc.xml');

  var nextPage = naviPages[2];
  assertEqual('Next page navi\'s class', nextPage.className,
    'go-page to-next');

  var nextLink = nextPage.querySelector(S(':scope > .link'));
  assertEqual('Next page link\'s text', nextLink.textContent, 'next');
  assertEqual('Next page link\'s class', nextLink.className, 'link');
  assertEqual('Next page link\'s href', nextLink.getAttribute('href'),
    './paging.test.xml');
}

function checkTocList() {
  var tocs = document.getElementsByClassName('toc');
  assertEqual('Count of tocs', tocs.length, 1);

  var title = tocs[0].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Table of contents');
  assertEqual('ID of toc', tocs[0].id, 'idxbktoc1');
  assertTreeEqual('+-- toc', tocs[0], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:preface:title link:Preface:./paging.toc.xml#idxbkpreface1',
    '2:clause:title link:Preface (1.1):./paging.toc.xml#idxbkclause1',
    '1:chapter:title link:1.Chapter (1):./paging.toc.xml#idxbkchapter1',
    '1:chapter:title link:2.Chapter (2):./paging.toc.xml#idxbkchapter2',
    '2:clause:title link:2.1.Chapter (2.1):./paging.toc.xml#idxbkclause2',
    '1:chapter:title link:3.Chapter (3):./paging.test.xml#idxbkchapter1',
    '2:clause:title link:3.1.Clause (3.1):./paging.test.xml#idxbkclause1',
    '1:appendix:title link:A.Appendix (1):./paging.test.xml#idxbkappendix1',
    '2:clause:title link:A.1.Clause (1.1):./paging.test.xml#idxbkclause2',
    '1:chapter:title link:4.Chapter (4):./paging.test.xml#idxbkchapter2',
    '2:clause:title link:4.1.Clause (4.1):./paging.test.xml#idxbkclause3',
    '1:appendix:title link:B.Appendix (2):./paging.test.xml#idxbkappendix2',
    '2:clause:title link:B.1.Clause (2.1):./paging.test.xml#idxbkclause4',
    '1:chapter:title link:5.Chapter (5):./paging.last.xml#idxbkchapter1',
    '2:clause:title link:5.1.Clause (5.1):./paging.last.xml#idxbkclause1',
    '2:clause:title link:5.2.Clause (5.2):./paging.last.xml#idxbkclause2',
    '1:appendix:title link:C.Appendix (3):./paging.last.xml#idxbkappendix1',
    '2:clause:title link:C.1.Clause (3.1):./paging.last.xml#idxbkclause3',
    '2:clause:title link:C.2.Clause (3.2):./paging.last.xml#idxbkclause4',
    '1:chapter:title link:6.Chpater (6):./paging.last.xml#idxbkchapter2',
    '1:appendix:title link:D.Appendix (4):./paging.last.xml#idxbkappendix2',
  ]);
}
