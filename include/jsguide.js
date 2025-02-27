window.initStyleGuide = function(init) {
  // 在匹配查询选择器的每个元素上运行回调函数。
  function find(querySelector, callback) {
    var elements = [].slice.call(document.querySelectorAll(querySelector));
    for (var i = 0; i < elements.length; i++) {
      callback(elements[i]);
    }
  }
  // 在顶部添加目录div。
  var title = document.getElementsByTagName('h1')[0];
  var toc = document.createElement('div');
  toc.id = 'tocDiv';
  toc.className = 'vertical_toc';
  title.parentNode.insertBefore(toc, title.nextSibling);

  // 如果段落以（例如）"Note:" 或 "Tip:" 开头，则将该“标注类”添加到其元素中。
  find('p', function(paragraph) {
    var match = /^([a-z]+):/i.exec(paragraph.textContent);
    if (match) {
      paragraph.classList.add(match[1].toLowerCase());
    }
  });

  // 填充文档内链接的文本，确保即使部分移动或重新编号，链接也能保持最新。
  // 这会触发任何文本为 "??" 且 URL 以 "#" 开头的链接，填充的文本与所引用部分标题的文本完全相同。
  find('a[href^="#"]', function(link) {
    var href = link.getAttribute('href');
    var heading = document.getElementById(href.substring(1));
    // 使用标题填充链接文本
    if (heading && link.textContent == '??') {
      link.textContent = heading.textContent;
    }
  });

  // Hoedown 渲染的带围栏的代码块与 prettify 期望的不兼容。因此，prettify 无法正确处理它们。通过将代码直接移动到 pre 中来修复。
  find('pre > code', function(code) {
    var pre = code.parentElement;
    // 内部 HTML/CSS & TS 风格指南不使用 prettyprint。
    if (code.classList.contains('language-css') ||
        code.classList.contains('language-django') ||
        code.classList.contains('language-html') ||
        code.classList.contains('language-ts')) {
      code.classList.add('prettyprint');
    }
    pre.className = code.className;
    pre.innerHTML = code.innerHTML;
  });

  // 运行正常的初始化函数。
  init();

  // 在修复代码块后调用美化器。
  var pretty = document.createElement('script');
  pretty.src = 'https://cdn.rawgit.com/google/code-prettify/master/loader/' +
      'run_prettify.js';
  document.body.appendChild(pretty);
}.bind(null, window.initStyleGuide);