TocTypeEnum = {
  VERTICAL: 1,
  HORIZONTAL: 2
};

function CreateTOC(tocElement) {

  // 查找目录元素DIV。我们将在这里放置我们的目录。
  var toc = document.getElementById(tocElement);

  var tocTypeClass = toc.className;
  var tocType;

  switch (tocTypeClass) {
      case 'horizontal_toc':
        tocType = TocTypeEnum.HORIZONTAL;
        break;
      case 'vertical_toc':
        tocType = TocTypeEnum.VERTICAL;
        break;
      default:
        tocType = TocTypeEnum.VERTICAL;
        break;
  }

  // 如果定义了toc_levels，则将headingLevels设置为其值。
  // 否则，使用默认值"h2,h3"
  var headingLevels;
  if (typeof toc_levels === 'undefined') {
    headingLevels = 'h2,h3';
  } else {

  }

  // 将所有章节标题元素收集到一个数组中
  var headings = document.querySelectorAll(headingLevels);

  // 添加目录标题元素
  var tocHeadingDiv = document.createElement('div');
  toc.appendChild(tocHeadingDiv);
  tocHeadingDiv.className = 'toc_title';
  var tocHeading = document.createElement('h3');
  toc.appendChild(tocHeading);
  tocHeading.className = 'ignoreLink';
  tocHeading.id = 'toc';
  var tocText = document.createTextNode('目录');
  tocHeading.appendChild(tocText);

  // 添加表格和tbody
  var tocTable = document.createElement('table');
  if (tocType == TocTypeEnum.VERTICAL) {
    tocTable.className = 'columns';
  }
  toc.appendChild(tocTable);

  var tbody_element = document.createElement('tbody');
  tbody_element.setAttribute('valign', 'top');
  tbody_element.className = 'toc';
  tocTable.appendChild(tbody_element);

  // 获取最高级别的标题
  var firstHeading = headings[0];
  var masterLevel = parseInt(headingLevels.charAt(1));

  // 获取最低的标题级别
  var lowestLevel = parseInt(headingLevels.charAt(headingLevels - 1));

  switch (tocType) {
    case TocTypeEnum.HORIZONTAL:
        CreateHorizontalTOC(headings, masterLevel, lowestLevel, tbody_element);
        break;
    case TocTypeEnum.VERTICAL:
        CreateVerticalTOC(headings, masterLevel, lowestLevel, tbody_element);
        break;
    default:
   }
}

function CreateHorizontalTOC(
             headings, masterLevel, lowestLevel, tbody_element) {

  // 初始化标题计数器
  var h = 0;
  var ignoreChildren = false;

  while (h < headings.length) {
    // 获取当前标题
    var heading = headings[h];

    // 获取当前标题级别
    var level = parseInt(heading.tagName.charAt(1));

    if (isNaN(level) || level < 1 || level > lowestLevel) continue;

    // 如果级别是masterLevel，则将其设为目录父类别
    if ((level == masterLevel) && (!hasClass(heading, 'ignoreLink'))) {
      toc_current_row = AddTOCMaster(tbody_element, heading);
      ignoreChildren = false;
    }

    if ((level == masterLevel) && (hasClass(heading, 'ignoreLink'))) {
      ignoreChildren = true;
    }

    if ((level != masterLevel) && (!ignoreChildren)) {
      AddTOCElements(toc_current_row, heading);
    }

    // 推进标题计数器
    h++;
  }
}

// 添加主目录标题
function AddTOCMaster(tocTable, heading) {

  // 添加表行脚手架
  var toc_tr = document.createElement('tr');
  tocTable.appendChild(toc_tr);
  toc_tr.setAttribute('valign', 'top');
  var toc_tr_td = document.createElement('td');
  toc_tr.appendChild(toc_tr_td);
  var toc_category = document.createElement('div');
  toc_tr_td.appendChild(toc_category);
  toc_category.className = 'toc_category';

  // 创建指向此标题的链接
  var link = document.createElement('a');
  link.href = '#' + heading.id;       // 创建锚点链接
  link.textContent = heading.textContent; // 链接文本与标题相同
  toc_category.appendChild(link);

  // 添加用于其子项的容器表格单元格
  var toc_td = document.createElement('td');
  toc_tr.appendChild(toc_td);
  var toc_td_div = document.createElement('div');
  toc_td_div.className = 'toc_stylepoint';
  toc_td.appendChild(toc_td_div);

  return (toc_td_div);
}

// 将目录元素作为子项添加到主标题
```javascript
function AddTOCElements(toc_div, heading) {

  if (heading.offsetParent === null) {
    // 元素当前被隐藏，因此不创建目录条目
  } else {
    // 创建列表项元素
    var toc_list_element = document.createElement('li');
    toc_list_element.className = 'toc_entry';
    toc_div.appendChild(toc_list_element);

    // 创建指向此标题的链接
    var link = document.createElement('a');
    link.href = '#' + heading.id;       // 创建锚链接
    link.textContent = heading.textContent; // 链接文本与标题相同
    toc_list_element.appendChild(link);
  }
}

function CreateVerticalTOC(headings, masterLevel, lowestLevel, tbody_element) {

  // 创建列脚手架
  var toc_tr = document.createElement('tr');
  tbody_element.appendChild(toc_tr);
  var toc_tr_td = document.createElement('td');
  toc_tr_td.className = 'two_columns';
  toc_tr.appendChild(toc_tr_td);


  // 初始化标题计数器和当前行
  var h = 0;
  var toc_current_col = null;
  var ignoreChildren = false;

  while (h < headings.length) {
    // 获取当前标题
    var heading = headings[h];

    // 获取当前标题级别
    var level = parseInt(heading.tagName.charAt(1));

    if (isNaN(level) || level < 1 || level > lowestLevel) continue;

    // 如果级别是masterLevel，则将其设为目录父类别
    if ((level == masterLevel) && (!hasClass(heading, 'ignoreLink'))) {
      if (heading.offsetParent === null) {
        // 元素当前被隐藏，因此不创建目录条目
      } else {
        var td_dl = document.createElement('dl');
        toc_tr_td.appendChild(td_dl);
        var td_dt = document.createElement('dt');
        td_dl.appendChild(td_dt);
        toc_current_col = td_dl;

        // 创建指向此标题的链接
        var link = document.createElement('a');
        link.href = '#' + heading.id;       // 创建锚链接
        link.textContent = heading.textContent; // 链接文本与标题相同
        td_dt.appendChild(link);
        ignoreChildren = false;
      }
    }

    // 如果级别是masterLevel但指定忽略链接，则跳过它及其子项。
    if ((level == masterLevel) && (hasClass(heading, 'ignoreLink'))) {
      ignoreChildren = true;
    }

    if ((level != masterLevel) && (!ignoreChildren)) {
      if (heading.offsetParent === null) {
        // 元素当前被隐藏，因此不创建目录条目
      } else {
        var td_dd = document.createElement('dd');
        toc_current_col.appendChild(td_dd);
        // 创建指向此标题的链接
        var link = document.createElement('a');
        link.href = '#' + heading.id;       // 创建锚链接
        link.textContent = heading.textContent; // 链接文本与标题相同
        td_dd.appendChild(link);
      }
    }

    // 推进标题计数器
    h++;
  }
}

/*
 * 用于查找具有给定类的元素的实用函数。
 */
function hasClass(element, cls) {
    return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
}

/*
 * 将所有h2到h4标题链接化，除了标记为
 * "ignoreLink"的标题
 */

// 将链接图像添加到元素中。
function LinkifyHeader(header, fileName, sizePixels) {
  var link = document.createElement('a');
  link.href = '#' + header.id;
  link.setAttribute('alt', '链接到 ' + header.id);
  link.innerHTML =
      '<img src="include/' + fileName + '"' +
      ' width=' + sizePixels +
      ' height=' + sizePixels +
      ' style="float:left;position:relative;bottom:5px;">';
  header.appendChild(link);
}

// 查找所有给定标签的元素，并在它们没有在类中包含'ignoreLink'时进行链接化。
```
function LinkifyHeadersForTag(tagName) {
  var headers = document.getElementsByTagName(tagName);
  var header;
  for (var j = 0; j != headers.length; j++) {
    header = headers[j];
    if (!hasClass(header, 'ignoreLink') && ('id' in header)) {
      if (header.id != '') {
        LinkifyHeader(header, 'link.png', 21);
        header.style.left = '-46px';
        header.style.position = 'relative';
      }
    }
  }
}

// 链接所有h2、h3和h4标题。h1标题是标题。
function LinkifyHeaders() {
  LinkifyHeadersForTag('h2');
  LinkifyHeadersForTag('h3');
  LinkifyHeadersForTag('h4');
}

/*
 * 通过显示所有内部元素并随后链接标题来初始化样式指南。
 */

function initStyleGuide() {
  LinkifyHeaders();
  CreateTOC('tocDiv');
}