window.addEventListener('load', function() {
  try {
    write('<hr/>');
    write('<b>Header:</b><br/>');
    checkNaviLinksInMiddlePage('header');
    write('<b>Footer:</b><br/>');
    checkNaviLinksInMiddlePage('footer');
    write('<b>Toc:</b><br/>');
    checkTocList();
  } catch (e) {
    fail(e);
  }
});

function checkNaviLinksInMiddlePage(parentTag) {
  var parent = document.getElementsByTagName(parentTag)[0];
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .go-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'go-page to-previous');

  var prevLink = prevPage.querySelector(S(':scope > .link'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className,
    'link');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    './paging.toc.xml');

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
    './paging.last.xml');
}

function checkTocList() {
  var tocs = document.getElementsByClassName('toc');
  assertEqual('Count of tocs', tocs.length, 1);

  var title = tocs[0].querySelector(S(':scope > .title')).textContent;
  assertEqual('Title of toc', title, 'Table of contents');
  assertEqual('ID of toc', tocs[0].id, 'aaa');
  assertTreeEqual('+-- toc', tocs[0], 'div', function(div, depth) {
    var a = div.querySelector(S(':scope > .link'));
    return depth + ':' + div.className + ':' + a.className + ':' +
      a.textContent + ':' + a.getAttribute('href');
  }, [
    '1:section:title link:3.1.1.Section (3.1.1):' +
      './paging.test.xml#idxbksection1',
    '2:section:title link:3.1.1.1.Section (3.1.1.1):' +
      './paging.test.xml#idxbksection2',
    '1:section:title link:3.1.2.Section (3.1.2):' +
      './paging.test.xml#idxbksection3',
    '2:section:title link:3.1.2.1.Section (3.1.2.1):' +
      './paging.test.xml#idxbksection4',
    '2:section:title link:3.1.2.2.Section (3.1.2.2):' +
      './paging.test.xml#idxbksection5',
    '1:section:title link:A.1.1.Section (1.1.1):' +
      './paging.test.xml#idxbksection6',
    '1:section:title link:4.1.1.Clause (4.1.1):' +
      './paging.test.xml#idxbksection7',
    '1:section:title link:B.1.1.Section (2.1.1):' +
      './paging.test.xml#idxbksection8',
  ]);
}
