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
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .go-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'go-page to-previous');

  var prevLink = prevPage.querySelector(S(':scope > .link'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className, 'link');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    './paging.test.xml');

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
  assertEqual('Next page link\'s class', nextLink.className, 'link disabled');
  assertEqual('Next page link\'s href', nextLink.getAttribute('href'), null);
}

function checkTocList() {
  var tocs = document.getElementsByClassName('toc');
  assertEqual('Count of tocs', tocs.length, 4);

  var i = 0;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Table of contents');
  assertEqual('ID of toc', tocs[i].id, 'idxbktoc1');
  assertTreeEqual('+-- toc', tocs[i], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:chapter:title link:5.Chapter (5):' +
      './paging.last.xml#idxbkchapter1',
    '2:clause:title link:5.1.Clause (5.1):' +
      './paging.last.xml#idxbkclause1',
    '3:section:title link:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '4:section:title link:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '4:section:title link:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '3:section:title link:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
    '2:clause:title link:5.2.Clause (5.2):' +
      './paging.last.xml#idxbkclause2',
    '3:section:title link:5.2.1.Section (5.2.1):' +
      './paging.last.xml#idxbksection5',
    '3:section:title link:5.2.2.Section (5.2.2):' +
      './paging.last.xml#idxbksection6',
    '1:appendix:title link:C.Appendix (3):' +
      './paging.last.xml#idxbkappendix1',
    '2:clause:title link:C.1.Clause (3.1):' +
      './paging.last.xml#idxbkclause3',
    '3:section:title link:C.1.1.Section (3.1.1):' +
      './paging.last.xml#idxbksection7',
    '3:section:title link:C.1.2.Section (3.1.2):' +
      './paging.last.xml#idxbksection8',
    '2:clause:title link:C.2.Clause (3.2):' +
      './paging.last.xml#idxbkclause4',
    '3:section:title link:C.2.1.Section (3.2.1):' +
      './paging.last.xml#idxbksection9',
    '3:section:title link:C.2.2.Section (3.2.2):' +
      './paging.last.xml#idxbksection10',
    '1:chapter:title link:6.Chpater (6):' +
      './paging.last.xml#idxbkchapter2',
    '1:appendix:title link:D.Appendix (4):' +
      './paging.last.xml#idxbkappendix2',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section (id=aaa)');
  assertEqual('ID of toc', tocs[i].id, 'aaa');
  assertTreeEqual('+-- toc', tocs[i], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:clause:title link:5.1.Clause (5.1):' +
      './paging.last.xml#idxbkclause1',
    '2:section:title link:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '3:section:title link:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '3:section:title link:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '2:section:title link:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
    '1:clause:title link:5.2.Clause (5.2):' +
      './paging.last.xml#idxbkclause2',
    '2:section:title link:5.2.1.Section (5.2.1):' +
      './paging.last.xml#idxbksection5',
    '2:section:title link:5.2.2.Section (5.2.2):' +
      './paging.last.xml#idxbksection6',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section (id=bbb)');
  assertEqual('ID of toc', tocs[i].id, 'bbb');
  assertTreeEqual('+-- toc', tocs[i], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:section:title link:5.1.1.Section (5.1.1):' +
      './paging.last.xml#idxbksection1',
    '2:section:title link:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '2:section:title link:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
    '1:section:title link:5.1.2.Section (5.1.2):' +
      './paging.last.xml#idxbksection4',
  ]);

  i++;
  var title = tocs[i].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Clause & Section');
  assertEqual('ID of toc', tocs[i].id, 'idxbktoc4');
  assertTreeEqual('+-- toc', tocs[i], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:section:title link:5.1.1.1.Section (5.1.1.1):' +
      './paging.last.xml#idxbksection2',
    '1:section:title link:5.1.1.2.Section (5.1.1.2):' +
      './paging.last.xml#idxbksection3',
  ]);
}
