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
  var naviPages = parent.querySelectorAll(S(':scope > .navi > .navi-page'));
  assertEqual('Count of navi page links', naviPages.length, 3);

  var prevPage = naviPages[0];
  assertEqual('Previous page navi\'s class', prevPage.className,
    'navi-page navi-previous');

  var prevLink = prevPage.querySelector(S(':scope > a'));
  assertEqual('Previous page link\'s text', prevLink.textContent, 'previous');
  assertEqual('Previous page link\'s class', prevLink.className, '');
  assertEqual('Previous page link\'s href', prevLink.getAttribute('href'),
    './paging.toc.xml');

  var nextPage = naviPages[1];
  assertEqual('Next page navi\'s class', nextPage.className,
    'navi-page navi-next');

  var nextLink = nextPage.querySelector(S(':scope > a'));
  assertEqual('Next page link\'s text', nextLink.textContent, 'next');
  assertEqual('Next page link\'s class', nextLink.className, '');
  assertEqual('Next page link\'s href', nextLink.getAttribute('href'),
    './paging.last.xml');

  var tocPage = naviPages[2];
  assertEqual('Toc page navi\'s class', tocPage.className,
    'navi-page navi-toc');

  var tocLink = tocPage.querySelector(S(':scope > a'));
  assertEqual('Toc page link\'s text', tocLink.textContent,
    'table of contents');
  assertEqual('Toc page link\'s class', tocLink.className, '');
  assertEqual('Toc page link\'s href', tocLink.getAttribute('href'),
    './paging.toc.xml');
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
  assertEqual('ID of toc', tocs[0].id, 'aaa');
  assertTreeEqual('+-- toc', tocs[0], 'div', treeNodeToString, [
    '1:body',
    '2:toc-section:title:3.1.1.Section (3.1.1):' +
      './paging.test.xml#idxbksection1',
    '3:toc-section:title:3.1.1.1.Section (3.1.1.1):' +
      './paging.test.xml#idxbksection2',
    '2:toc-section:title:3.1.2.Section (3.1.2):' +
      './paging.test.xml#idxbksection3',
    '3:toc-section:title:3.1.2.1.Section (3.1.2.1):' +
      './paging.test.xml#idxbksection4',
    '3:toc-section:title:3.1.2.2.Section (3.1.2.2):' +
      './paging.test.xml#idxbksection5',
    '2:toc-section:title:A.1.1.Section (1.1.1):' +
      './paging.test.xml#idxbksection6',
    '2:toc-section:title:4.1.1.Clause (4.1.1):' +
      './paging.test.xml#idxbksection7',
    '2:toc-section:title:B.1.1.Section (2.1.1):' +
      './paging.test.xml#idxbksection8',
  ]);
}
