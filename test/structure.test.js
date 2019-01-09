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
    '1:SECTION.preface#preface1',
    '2:SECTION.clause#clause1',
    '3:SECTION.section#section1',
    '1:SECTION.preface#aaa',
    '1:SECTION.chapter#chapter1',
    '2:SECTION.clause#clause2',
    '3:SECTION.section#section2',
    '4:SECTION.section#section3',
    '2:SECTION.clause#bbb',
    '3:SECTION.section#ccc',
    '3:SECTION.section#ddd',
    '1:SECTION.chapter#eee',
    '2:SECTION.clause#clause4',
    '1:SECTION.chapter#chapter3',
    '1:SECTION.appendix#appendix1',
    '1:SECTION.appendix#fff',
    '2:SECTION.clause#clause5',
    '2:SECTION.clause#clause6',
    '1:SECTION.postface#postface1',
    '2:SECTION.clause#clause7',
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
    '.preface#preface1 = []',
    '.clause#clause1 = []',
    '.section#section1 = []',
    '.preface#aaa = []',
    '.chapter#chapter1 = [1.]',
    '.clause#clause2 = [1.1.]',
    '.section#section2 = [1.1.1.]',
    '.section#section3 = [1.1.1.1.]',
    '.clause#bbb = [1.2.]',
    '.section#ccc = [1.2.1.]',
    '.section#ddd = [1.2.2.]',
    '.chapter#eee = [2.]',
    '.clause#clause4 = [2.1.]',
    '.chapter#chapter3 = [3.]',
    '.appendix#appendix1 = [A.]',
    '.appendix#fff = [B.]',
    '.clause#clause5 = [B.1.]',
    '.clause#clause6 = [B.2.]',
    '.postface#postface1 = []',
    '.clause#clause7 = []',
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
    '.preface#preface1 = [Preface 1]',
    '.clause#clause1 = [Preface 1.1]',
    '.section#section1 = [Preface 1.1.1]',
    '.preface#aaa = [Preface 2]',
    '.chapter#chapter1 = [Chapter 1]',
    '.clause#clause2 = [Chapter 1.1]',
    '.section#section2 = [Chapter 1.1.1]',
    '.section#section3 = [Chapter 1.1.1.1]',
    '.clause#bbb = [Chapter 1.2]',
    '.section#ccc = [Chapter 1.2.1]',
    '.section#ddd = [Chapter 1.2.2]',
    '.chapter#eee = [Chapter 2]',
    '.clause#clause4 = [Chapter 2.1]',
    '.chapter#chapter3 = [Chapter 3]',
    '.appendix#appendix1 = [Appendix 1]',
    '.appendix#fff = [Appendix 2]',
    '.clause#clause5 = [Appendix 2.1]',
    '.clause#clause6 = [Appendix 2.2]',
    '.postface#postface1 = [Postface 1]',
    '.clause#clause7 = [Postface 1.1]',
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
    '.preface#preface1 = [This is the body of the preface 1.]',
    '.clause#clause1 = [This is the body of the preface 1.1.]',
    '.section#section1 = [This is the body of the preface 1.1.1.]',
    '.preface#aaa = [This is the body of the preface 2.]',
    '.chapter#chapter1 = [This is the body of the chapter 1.]',
    '.clause#clause2 = [This is the body of the chapter 1.1.]',
    '.section#section2 = [This is the body of the chapter 1.1.1.]',
    '.section#section3 = [This is the body of the chapter 1.1.1.1.]',
    '.clause#bbb = [This is the body of the chapter 1.2.]',
    '.section#ccc = [This is the body of the chapter 1.2.1.]',
    '.section#ddd = [This is the body of the chapter 1.2.2.]',
    '.chapter#eee = [This is the body of the chapter 2.]',
    '.clause#clause4 = [This is the body of the chapter 2.1.]',
    '.chapter#chapter3 = [This is the body of the chapter 3.]',
    '.appendix#appendix1 = [This is the body of the appendix 1.]',
    '.appendix#fff = [This is the body of the appendix 2.]',
    '.clause#clause5 = [This is the body of the appendix 2.1.]',
    '.clause#clause6 = [This is the body of the appendix 2.2.]',
    '.postface#postface1 = [This is the body of the postface 1.]',
    '.clause#clause7 = [This is the body of the postface 1.1.]',
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
