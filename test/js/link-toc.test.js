window.addEventListener('load', function() {
  try {
    write('<hr/>');
    checkLinks();
  } catch (e) {
    fail(e);
  }
});

function checkLinks() {
  var links = document.querySelectorAll('.link');
  var arr  = [
    { content: 'This', href: 'link-toc.toc.xml#ch1' },
    { content: 'This', href: 'link-toc.toc.xml#ch2' },
    { content: 'This', href: 'link-toc.toc.xml#ch2_1' },
    { content: 'This', href: 'link-toc.toc.xml#ch2_1_1' },
    { content: 'This', href: 'link-toc.test.xml#ch3' },
    { content: 'This', href: 'link-toc.test.xml#ch3_1' },
    { content: 'This', href: 'link-toc.test.xml#ch3_2' },
    { content: 'This', href: 'link-toc.last.xml#ch4' },
    { content: 'This', href: 'link-toc.last.xml#ch5' },
    { content: 'This', href: 'link-toc.last.xml#ch5_1' },
    { content: 'This', href: 'link-toc.last.xml#ch5_1_1' },

    { content: '1.Chapter 1', href: 'link-toc.toc.xml#ch1',
      index: '1.', label: 'Chapter 1' },
    { content: '2.Chapter 2', href: 'link-toc.toc.xml#ch2',
      index: '2.', label: 'Chapter 2' },
    { content: '2.1.Chapter 2.1', href: 'link-toc.toc.xml#ch2_1',
      index: '2.1.', label: 'Chapter 2.1' },
    { content: '2.1.1.Chapter 2.1.1', href: 'link-toc.toc.xml#ch2_1_1',
      index: '2.1.1.', label: 'Chapter 2.1.1' },
    { content: '3.Link to ID in TOC file', href: 'link-toc.test.xml#ch3',
      index: '3.', label: 'Link to ID in TOC file' },
    { content: '3.1.Chapter 3.1', href: 'link-toc.test.xml#ch3_1',
      index: '3.1.', label: 'Chapter 3.1' },
    { content: '3.2.Chapter 3.2', href: 'link-toc.test.xml#ch3_2',
      index: '3.2.', label: 'Chapter 3.2' },
    { content: '4.Chapter 4', href: 'link-toc.last.xml#ch4',
      index: '4.', label: 'Chapter 4' },
    { content: '5.Chapter 5', href: 'link-toc.last.xml#ch5',
      index: '5.', label: 'Chapter 5' },
    { content: '5.1.Chapter 5.1', href: 'link-toc.last.xml#ch5_1',
      index: '5.1.', label: 'Chapter 5.1' },
    { content: '5.1.1.Chapter 5.1.1', href: 'link-toc.last.xml#ch5_1_1',
      index: '5.1.1.', label: 'Chapter 5.1.1' },

    { content: '1.', href: 'link-toc.toc.xml#ch1', index: '1.' },
    { content: '2.', href: 'link-toc.toc.xml#ch2', index: '2.' },
    { content: '2.1.', href: 'link-toc.toc.xml#ch2_1', index: '2.1.' },
    { content: '2.1.1.', href: 'link-toc.toc.xml#ch2_1_1', index: '2.1.1.' },
    { content: '3.', href: 'link-toc.test.xml#ch3', index: '3.' },
    { content: '3.1.', href: 'link-toc.test.xml#ch3_1', index: '3.1.' },
    { content: '3.2.', href: 'link-toc.test.xml#ch3_2', index: '3.2.' },
    { content: '4.', href: 'link-toc.last.xml#ch4', index: '4.' },
    { content: '5.', href: 'link-toc.last.xml#ch5', index: '5.' },
    { content: '5.1.', href: 'link-toc.last.xml#ch5_1', index: '5.1.' },
    { content: '5.1.1.', href: 'link-toc.last.xml#ch5_1_1', index: '5.1.1.' },

    { content: 'Chapter 1', href: 'link-toc.toc.xml#ch1',
      label: 'Chapter 1' },
    { content: 'Chapter 2', href: 'link-toc.toc.xml#ch2',
      label: 'Chapter 2' },
    { content: 'Chapter 2.1', href: 'link-toc.toc.xml#ch2_1',
      label: 'Chapter 2.1' },
    { content: 'Chapter 2.1.1', href: 'link-toc.toc.xml#ch2_1_1',
      label: 'Chapter 2.1.1' },
    { content: 'Link to ID in TOC file', href: 'link-toc.test.xml#ch3',
      label: 'Link to ID in TOC file' },
    { content: 'Chapter 3.1', href: 'link-toc.test.xml#ch3_1',
      label: 'Chapter 3.1' },
    { content: 'Chapter 3.2', href: 'link-toc.test.xml#ch3_2',
      label: 'Chapter 3.2' },
    { content: 'Chapter 4', href: 'link-toc.last.xml#ch4',
      label: 'Chapter 4' },
    { content: 'Chapter 5', href: 'link-toc.last.xml#ch5',
      label: 'Chapter 5' },
    { content: 'Chapter 5.1', href: 'link-toc.last.xml#ch5_1',
      label: 'Chapter 5.1' },
    { content: 'Chapter 5.1.1', href: 'link-toc.last.xml#ch5_1_1',
      label: 'Chapter 5.1.1' },
  ];
  for (var i = 0, n = links.length; i < n; i++) {
    assertEqual('Content of link', links[i].textContent, arr[i].content);
    assertEqual('Href of link', links[i].getAttribute('href'), arr[i].href);
    var oIndex = links[i].querySelector(S(':scope > .index')) || {};
    var oLabel = links[i].querySelector(S(':scope > .label')) || {};
    assertEqual('Index in link', oIndex.textContent, arr[i].index);
    assertEqual('Label in link', oLabel.textContent, arr[i].label);
  }
}
