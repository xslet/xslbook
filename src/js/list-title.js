'use strict';

window.addEventListener('load', function() {
  var titles = document.querySelectorAll('ul.list > li.item > span.title');
  var map = {};
  for (var i = 0; i < titles.length; i++) {
    var title = titles[i];
    var ul = title.parentNode.parentNode;
    if (!map[ul.id]) {
      map[ul.id] = [];
    }
    map[ul.id].push(title);
  }
  Object.keys(map).forEach(function(key) {
    var arr = map[key], maxWidth = 0, j, span;
    for (j = 0; j < arr.length; j++) {
      span = arr[j];
      maxWidth = Math.max(maxWidth, span.offsetWidth);
    }
    for (j = 0; j < arr.length; j++) {
      span = arr[j];
      span.style.width = maxWidth + 'px';
    }
  });
});
