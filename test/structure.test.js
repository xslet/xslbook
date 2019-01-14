window.addEventListener('load', function() {
  document.body.innerHTML += '<hr/>';
  checkStructureAndId();
  checkIndex();
  checkTitle();
  checkBody();
});

function checkStructureAndId() {
  var arr = [];
  visitSections(document.querySelector('.xslbook'), function(child, depth) {
    arr.push(depth + ':' +
      child.tagName + '.' + child.className + '#' + child.id);
  });
  assertArrayEqual('Structure', arr, [
    '1:SECTION.preface#idxbkpreface1',
    '2:SECTION.clause#idxbkclause1',
    '3:SECTION.section#idxbksection1',
    '1:SECTION.preface#aaa',
    '1:SECTION.chapter#idxbkchapter1',
    '2:SECTION.clause#idxbkclause2',
    '3:SECTION.section#idxbksection2',
    '4:SECTION.section#idxbksection3',
    '2:SECTION.clause#bbb',
    '3:SECTION.section#ccc',
    '3:SECTION.section#ddd',
    '1:SECTION.chapter#eee',
    '2:SECTION.clause#idxbkclause4',
    '1:SECTION.chapter#idxbkchapter3',
    '1:SECTION.appendix#idxbkappendix1',
    '1:SECTION.appendix#fff',
    '2:SECTION.clause#idxbkclause5',
    '2:SECTION.clause#idxbkclause6',
    '1:SECTION.postface#idxbkpostface1',
    '2:SECTION.clause#idxbkclause7',
    '1:SECTION.postface#ggg',
  ]);
}

function checkIndex() {
  var arr = [];
  visitSections(document.querySelector('.xslbook'), function(child, depth) {
    var elm = get(':scope > .title > .index', child) || {};
    arr.push('.' + child.className + '#' + child.id + ' = [' +
      elm.textContent + ']');
  });
  assertArrayEqual('Section indexies', arr, [
    '.preface#idxbkpreface1 = []',
    '.clause#idxbkclause1 = []',
    '.section#idxbksection1 = []',
    '.preface#aaa = []',
    '.chapter#idxbkchapter1 = [1.]',
    '.clause#idxbkclause2 = [1.1.]',
    '.section#idxbksection2 = [1.1.1.]',
    '.section#idxbksection3 = [1.1.1.1.]',
    '.clause#bbb = [1.2.]',
    '.section#ccc = [1.2.1.]',
    '.section#ddd = [1.2.2.]',
    '.chapter#eee = [2.]',
    '.clause#idxbkclause4 = [2.1.]',
    '.chapter#idxbkchapter3 = [3.]',
    '.appendix#idxbkappendix1 = [A.]',
    '.appendix#fff = [B.]',
    '.clause#idxbkclause5 = [B.1.]',
    '.clause#idxbkclause6 = [B.2.]',
    '.postface#idxbkpostface1 = []',
    '.clause#idxbkclause7 = []',
    '.postface#ggg = []',
  ]);
}

function checkTitle() {
  var arr = [];
  visitSections(document.querySelector('.xslbook'), function(child, depth) {
    var elm = get(':scope > .title > .label', child) || {};
    arr.push('.' + child.className + '#' + child.id + ' = [' +
      elm.textContent + ']');
  });
  assertArrayEqual('Section titles', arr, [
    '.preface#idxbkpreface1 = [Preface 1]',
    '.clause#idxbkclause1 = [Preface 1.1]',
    '.section#idxbksection1 = [Preface 1.1.1]',
    '.preface#aaa = [Preface 2]',
    '.chapter#idxbkchapter1 = [Chapter 1]',
    '.clause#idxbkclause2 = [Chapter 1.1]',
    '.section#idxbksection2 = [Chapter 1.1.1]',
    '.section#idxbksection3 = [Chapter 1.1.1.1]',
    '.clause#bbb = [Chapter 1.2]',
    '.section#ccc = [Chapter 1.2.1]',
    '.section#ddd = [Chapter 1.2.2]',
    '.chapter#eee = [Chapter 2]',
    '.clause#idxbkclause4 = [Chapter 2.1]',
    '.chapter#idxbkchapter3 = [Chapter 3]',
    '.appendix#idxbkappendix1 = [Appendix 1]',
    '.appendix#fff = [Appendix 2]',
    '.clause#idxbkclause5 = [Appendix 2.1]',
    '.clause#idxbkclause6 = [Appendix 2.2]',
    '.postface#idxbkpostface1 = [Postface 1]',
    '.clause#idxbkclause7 = [Postface 1.1]',
    '.postface#ggg = [Postface 2]',
  ]);
}

function checkBody() {
  var arr = [];
  visitSections(document.querySelector('.xslbook'), function(child, depth) {
    var elm = get(':scope > .body', child) || {};
    arr.push('.' + child.className + '#' + child.id + ' = [' +
      elm.textContent + ']');
  });
  assertArrayEqual('Section bodies', arr, [
    '.preface#idxbkpreface1 = [This is the body of the preface 1.]',
    '.clause#idxbkclause1 = [This is the body of the preface 1.1.]',
    '.section#idxbksection1 = [This is the body of the preface 1.1.1.]',
    '.preface#aaa = [This is the body of the preface 2.]',
    '.chapter#idxbkchapter1 = [This is the body of the chapter 1.]',
    '.clause#idxbkclause2 = [This is the body of the chapter 1.1.]',
    '.section#idxbksection2 = [This is the body of the chapter 1.1.1.]',
    '.section#idxbksection3 = [This is the body of the chapter 1.1.1.1.]',
    '.clause#bbb = [This is the body of the chapter 1.2.]',
    '.section#ccc = [This is the body of the chapter 1.2.1.]',
    '.section#ddd = [This is the body of the chapter 1.2.2.]',
    '.chapter#eee = [This is the body of the chapter 2.]',
    '.clause#idxbkclause4 = [This is the body of the chapter 2.1.]',
    '.chapter#idxbkchapter3 = [This is the body of the chapter 3.]',
    '.appendix#idxbkappendix1 = [This is the body of the appendix 1.]',
    '.appendix#fff = [This is the body of the appendix 2.]',
    '.clause#idxbkclause5 = [This is the body of the appendix 2.1.]',
    '.clause#idxbkclause6 = [This is the body of the appendix 2.2.]',
    '.postface#idxbkpostface1 = [This is the body of the postface 1.]',
    '.clause#idxbkclause7 = [This is the body of the postface 1.1.]',
    '.postface#ggg = [This is the body of the postface 2.]',
  ]);
}


function visitSections(parent, fn, depth) {
  depth = depth || 1;
  var children = parent.querySelectorAll(':scope > section');
  for (var i = 0, n= children.length; i < n; i++) {
    var child = children[i];
    fn(child, depth);
    visitSections(child, fn, depth + 1);
  }
}

function get(selector, parent) {
  parent = parent || document;
  return parent.querySelector(selector);
}
