<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dcq="http://purl.org/dc/qualifiers/1.0/"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="html"/>
  <!-- 默认设置为1以显示解释。设置为0以隐藏它们 -->
  <xsl:variable name="show_explanation_default" select="0" />
  <!-- Webdings字体中显示三角形的字符 -->
  <xsl:variable name="show_button_text" select="'&#x25B6;'" />
  <xsl:variable name="hide_button_text" select="'&#x25BD;'" />
  <!-- 名称的后缀 -->
  <xsl:variable name="button_suffix" select="'__button'"/>
  <xsl:variable name="body_suffix" select="'__body'"/>
  <!-- 为了方便引用，按钮的名称 -->
  <xsl:variable name="show_hide_all_button" select="'show_hide_all_button'"/>

  <!-- 顶级元素 -->
  <xsl:template match="GUIDE">
      <HTML>
          <HEAD>
              <TITLE><xsl:value-of select="@title"/></TITLE>
              <META http-equiv="Content-Type" content="text/html; charset=utf-8"/>
              <LINK HREF="/styleguide/favicon.ico" type="image/x-icon"
                    rel="shortcut icon"/>
              <LINK HREF="styleguide.css"
                    type="text/css" rel="stylesheet"/>

              <SCRIPT language="javascript" type="text/javascript">

                function GetElementsByName(name) {
                  // 解决旧版本Opera上的一个bug。
                  if (document.getElementsByName) {
                    return document.getElementsByName(name);
                  } else {
                    return [document.getElementById(name)];
                  }
                }

                /**
                 * @param {string} namePrefix 身体名称的前缀。
                 * @param {function(boolean): boolean} getVisibility 计算新可见性状态的函数，根据当前状态。
                 */
                function ChangeVisibility(namePrefix, getVisibility) {
                  var bodyName = namePrefix + '<xsl:value-of select="$body_suffix"/>';
                  var buttonName = namePrefix + '<xsl:value-of select="$button_suffix"/>';
                  var bodyElements = GetElementsByName(bodyName);
                  var linkElement = GetElementsByName('link-' + buttonName)[0];
                  if (bodyElements.length != 1) {
                    throw Error('ShowHideByName() 获得了错误数量的bodyElements:  ' + 
                        bodyElements.length);
                  } else {
                    var bodyElement = bodyElements[0];
                    var buttonElement = GetElementsByName(buttonName)[0];
                    var isVisible = bodyElement.style.display != "none";
                    if (getVisibility(isVisible)) {
                      bodyElement.style.display = "inline";
                      linkElement.style.display = "block";
                      buttonElement.innerHTML = '<xsl:value-of select="$hide_button_text"/>';
                    } else {
                      bodyElement.style.display = "none";
                      linkElement.style.display = "none";
                      buttonElement.innerHTML = '<xsl:value-of select="$show_button_text"/>';
                    }
                  }
                }

                function ShowHideByName(namePrefix) {
                  ChangeVisibility(namePrefix, function(old) { return !old; });
                }

                function ShowByName(namePrefix) {
                  ChangeVisibility(namePrefix, function() { return true; });
                }

                function ShowHideAll() {
                  var allButton = GetElementsByName("show_hide_all_button")[0];
                  if (allButton.innerHTML == '<xsl:value-of select="$hide_button_text"/>') {
                    allButton.innerHTML = '<xsl:value-of select="$show_button_text"/>';
                    SetHiddenState(document.getElementsByTagName("body")[0].childNodes, "none", '<xsl:value-of select="$show_button_text"/>');
                  } else {
                    allButton.innerHTML = '<xsl:value-of select="$hide_button_text"/>';
                    SetHiddenState(document.getElementsByTagName("body")[0].childNodes, "inline", '<xsl:value-of select="$hide_button_text"/>');
                  }
                }

                // 递归设置特定节点的所有子节点的状态。
                function SetHiddenState(root, newState, newButton) {
                  for (var i = 0; i != root.length; i++) {
                    SetHiddenState(root[i].childNodes, newState, newButton);
                    if (root[i].className == 'showhide_button')  {
                      root[i].innerHTML = newButton;
                    }
                    if (root[i].className == 'stylepoint_body' ||
                        root[i].className == 'link_button')  {
                      root[i].style.display = newState;
                    }
                  }
                }


                function EndsWith(str, suffix) {
                  var l = str.length - suffix.length;
                  return l >= 0 &amp;&amp; str.indexOf(suffix, l) == l;
                }

                function RefreshVisibilityFromHashParam() {
                  var hashRegexp = new RegExp('#([^&amp;#]*)$');
                  var hashMatch = hashRegexp.exec(window.location.href);
                  var anchor = hashMatch &amp;&amp; GetElementsByName(hashMatch[1])[0];
                  var node = anchor;
                  var suffix = '<xsl:value-of select="$body_suffix"/>';
                  while (node) {
                    var id = node.id;
                    var matched = id &amp;&amp; EndsWith(id, suffix);
                    if (matched) {
                      var len = id.length - suffix.length;
                      ShowByName(id.substring(0, len));
                      if (anchor.scrollIntoView) {
                        anchor.scrollIntoView();
                      }

                      return;
                    }
                    node = node.parentNode;
                  }
                }

                window.onhashchange = RefreshVisibilityFromHashParam;
```javascript
                window.onload = function() {
                  // 如果URL包含"?showall=y"，则展开所有子项的详细信息
                  var showHideAllRegex = new RegExp("[\\?&amp;](showall)=([^&amp;#]*)");
                  var showHideAllValue = showHideAllRegex.exec(window.location.href);
                  if (showHideAllValue != null) {
                    if (showHideAllValue[2] == "y") {
                      SetHiddenState(document.getElementsByTagName("body")[0].childNodes, 
                          "inline", '<xsl:value-of select="$hide_button_text"/>');
                    } else {
                      SetHiddenState(document.getElementsByTagName("body")[0].childNodes, 
                          "none", '<xsl:value-of select="$show_button_text"/>');
                    }
                  }
                  var showOneRegex = new RegExp("[\\?&amp;](showone)=([^&amp;#]*)");
                  var showOneValue = showOneRegex.exec(window.location.href);
                  if (showOneValue) {
                    ShowHideByName(showOneValue[2]);
                  }


                  RefreshVisibilityFromHashParam();
                }
              </SCRIPT>
          </HEAD>
          <BODY>
            <H1><xsl:value-of select="@title"/></H1>
              <xsl:apply-templates/>
          </BODY>
      </HTML>
  </xsl:template>

  <xsl:template match="OVERVIEW">
    <xsl:variable name="button_text">
      <xsl:choose>
        <xsl:when test="$show_explanation_default">
          <xsl:value-of select="$hide_button_text"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$show_button_text"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <DIV style="margin-left: 50%; font-size: 75%;">
      <P>
        每个样式点都有一个摘要，可以通过切换旁边的箭头按钮来获取更多信息，箭头按钮看起来像这样：
        <SPAN class="showhide_button" style="margin-left: 0; float: none">
          <xsl:value-of select="$show_button_text"/></SPAN>。
        您可以通过大箭头按钮切换所有摘要：
      </P>
      <DIV style=" font-size: larger; margin-left: +2em;">
        <SPAN class="showhide_button" style="font-size: 180%; float: none">
          <xsl:attribute name="onclick"><xsl:value-of select="'javascript:ShowHideAll()'"/></xsl:attribute>
          <xsl:attribute name="name"><xsl:value-of select="$show_hide_all_button"/></xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="$show_hide_all_button"/></xsl:attribute>
          <xsl:value-of select="$button_text"/>
        </SPAN>
        切换所有摘要
      </DIV>
    </DIV>
    <xsl:call-template name="TOC">
      <xsl:with-param name="root" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="PARTING_WORDS">
    <H2>离别词</H2>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="CATEGORY">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <H2>
        <xsl:variable name="category_name">
          <xsl:call-template name="anchorname">
            <xsl:with-param name="sectionname" select="@title"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:attribute name="name"><xsl:value-of select="$category_name"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$category_name"/></xsl:attribute>
        <xsl:value-of select="@title"/>
      </H2>
      <xsl:apply-templates/>
    </DIV>
  </xsl:template>

  <xsl:template match="STYLEPOINT">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <xsl:variable name="stylepoint_name">
        <xsl:call-template name="anchorname">
          <xsl:with-param name="sectionname" select="@title"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="button_text">
        <xsl:choose>
          <xsl:when test="$show_explanation_default">
            <xsl:value-of select="$hide_button_text"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$show_button_text"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <H3>
        <A>
          <xsl:attribute name="name"><xsl:value-of select="$stylepoint_name"/></xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="$stylepoint_name"/></xsl:attribute>
          <xsl:value-of select="@title"/>
        </A>
      </H3>
      <xsl:variable name="buttonName">
        <xsl:value-of select="$stylepoint_name"/><xsl:value-of select="$button_suffix"/>
      </xsl:variable>
      <xsl:variable name="onclick_definition">
        <xsl:text>javascript:ShowHideByName('</xsl:text>
        <xsl:value-of select="$stylepoint_name"/>
        <xsl:text>')</xsl:text>
      </xsl:variable>
      <SPAN class="link_button" id="link-{$buttonName}" name="link-{$buttonName}">
        <A>
          <xsl:attribute name="href">?showone=<xsl:value-of select="$stylepoint_name"/>#<xsl:value-of select="$stylepoint_name"/></xsl:attribute>
          链接
        </A>
      </SPAN>
      <SPAN class="showhide_button">
        <xsl:attribute name="onclick"><xsl:value-of select="$onclick_definition"/></xsl:attribute>
        <xsl:attribute name="name"><xsl:value-of select="$buttonName"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$buttonName"/></xsl:attribute>
        <xsl:value-of select="$button_text"/>
      </SPAN>
      <xsl:apply-templates>
        <xsl:with-param name="anchor_prefix" select="$stylepoint_name" />
      </xsl:apply-templates>
    </DIV>
  </xsl:template>

  <xsl:template match="SUMMARY">
    <xsl:param name="anchor_prefix" />
    <DIV style="display:inline;">
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <xsl:apply-templates/>
    </DIV>
  </xsl:template>
```
<xsl:template match="BODY">
    <xsl:param name="anchor_prefix" />
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <DIV class="stylepoint_body">
        <xsl:attribute name="name"><xsl:value-of select="$anchor_prefix"/><xsl:value-of select="$body_suffix"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$anchor_prefix"/><xsl:value-of select="$body_suffix"/></xsl:attribute>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$show_explanation_default">display: inline</xsl:when>
            <xsl:otherwise>display: none</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates/>
      </DIV>
    </DIV>
  </xsl:template>

  <xsl:template match="DEFINITION">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_section">定义:  </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="PROS">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_section">优点:  </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="CONS">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_section">缺点: </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="DECISION">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_section">决策:  </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="TODO">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <DIV style="font-size: 150%;">待办:
        <xsl:apply-templates/>
      </DIV>
    </P>
  </xsl:template>

  <xsl:template match="SUBSECTION">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_subsection"><xsl:value-of select="@title"/>  </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="SUBSUBSECTION">
    <P>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <SPAN class="stylepoint_subsubsection"><xsl:value-of select="@title"/>  </SPAN>
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="CODE_SNIPPET">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <PRE><xsl:call-template name="print_without_leading_chars">
           <xsl:with-param name="text" select="."/>
           <xsl:with-param name="strip" select="1"/>
           <xsl:with-param name="is_firstline" select="1"/>
           <xsl:with-param name="trim_count">
             <xsl:call-template name="num_leading_spaces">
               <xsl:with-param name="text" select="."/>
               <xsl:with-param name="max_so_far" select="1000"/>
             </xsl:call-template>
           </xsl:with-param>
         </xsl:call-template></PRE>
    </DIV>
  </xsl:template>

  <xsl:template match="BAD_CODE_SNIPPET">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <PRE class="badcode"><xsl:call-template name="print_without_leading_chars">
           <xsl:with-param name="text" select="."/>
           <xsl:with-param name="strip" select="1"/>
           <xsl:with-param name="is_firstline" select="1"/>
           <xsl:with-param name="trim_count">
             <xsl:call-template name="num_leading_spaces">
               <xsl:with-param name="text" select="."/>
               <xsl:with-param name="max_so_far" select="1000"/>
             </xsl:call-template>
           </xsl:with-param>
         </xsl:call-template></PRE>
    </DIV>
  </xsl:template>

  <xsl:template match="PY_CODE_SNIPPET">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <PRE><xsl:call-template name="print_python_code">
             <xsl:with-param name="text" select="."/>
           </xsl:call-template></PRE>
    </DIV>
  </xsl:template>

  <xsl:template match="BAD_PY_CODE_SNIPPET">
    <DIV>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <PRE class="badcode"><xsl:call-template name="print_python_code">
                             <xsl:with-param name="text" select="."/>
                           </xsl:call-template></PRE>
    </DIV>
  </xsl:template>

  <xsl:template match="FUNCTION">
    <xsl:call-template name="print_function_name">
      <xsl:with-param name="text" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="SYNTAX">
    <I>
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
      <xsl:apply-templates/>
    </I>
  </xsl:template>


  <!-- 此模板允许XML文档中用于轻微格式化的任何HTML元素通过 -->
  <xsl:template match="a|address|blockquote|br|center|cite|code|dd|div|dl|dt|em|hr|i|img|li|ol|p|pre|span|table|td|th|tr|ul|var|A|ADDRESS|BLOCKQUOTE|BR|CENTER|CITE|CODE|DD|DIV|DL|DT|EM|HR|I|LI|OL|P|PRE|SPAN|TABLE|TD|TH|TR|UL|VAR">
      <xsl:element name="{local-name()}">
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
      </xsl:element>
  </xsl:template>
<!-- 构建目录 -->
<xsl:template name="TOC">
  <xsl:param name="root"/>
  <DIV class="toc">
    <DIV class="toc_title">目录</DIV>
    <TABLE>
    <xsl:for-each select="$root/CATEGORY">
      <TR valign="top">
        <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
        <TD>
        <DIV class="toc_category">
          <A>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:call-template name="anchorname">
                <xsl:with-param name="sectionname" select="@title"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="@title"/>
          </A>
        </DIV>
        </TD><TD>
          <DIV class="toc_stylepoint">
            <xsl:for-each select="./STYLEPOINT">
              <SPAN style="padding-right: 1em; white-space:nowrap;">
                <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
                <A>
                  <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:call-template name="anchorname">
                      <xsl:with-param name="sectionname" select="@title"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:value-of select="@title"/>
                </A>
              </SPAN>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </DIV>
        </TD>
      </TR>
    </xsl:for-each>
    </TABLE>
  </DIV>
</xsl:template>

<xsl:template name="TOC_one_stylepoint">
  <xsl:param name="stylepoint"/>
</xsl:template>

<!-- 根据任意文本创建标准锚点。
     将不适合URL的字符替换为下划线 -->
<xsl:template name="anchorname">
  <xsl:param name="sectionname"/>
  <!-- 需要奇怪的引用以去除撇号 -->
  <xsl:variable name="bad_characters" select="&quot; ()#'&quot;"/>
  <xsl:value-of select="translate($sectionname,$bad_characters,'_____')"/>
</xsl:template>

<!-- 给定文本，计算前导空格的数量。 -->
<!-- TODO(csilvers): 处理前导制表符（视为8个空格？） -->
<xsl:template name="num_leading_spaces_one_line">
  <xsl:param name="text"/>
  <xsl:param name="current_count"/>
  <xsl:choose>
    <xsl:when test="starts-with($text, ' ')">
      <xsl:call-template name="num_leading_spaces_one_line">
        <xsl:with-param name="text" select="substring($text, 2)"/>
        <xsl:with-param name="current_count" select="$current_count + 1"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$current_count"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 给定一个以\n结尾的文本块，计算该文本的缩进级别；即，所有非空行至少以n个空格开头的最大n值。 -->
<xsl:template name="num_leading_spaces">
  <xsl:param name="text"/>
  <xsl:param name="max_so_far"/>
  <!-- TODO(csilvers): 处理文本不以换行符结尾的情况 -->
  <xsl:variable name="line" select="substring-before($text, '&#xA;')"/>
  <xsl:variable name="rest" select="substring-after($text, '&#xA;')"/>
  <xsl:variable name="num_spaces_this_line">
    <xsl:choose>
      <xsl:when test="$line=''">
         <xsl:value-of select="$max_so_far"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="num_leading_spaces_one_line">
          <xsl:with-param name="text" select="$line"/>
          <xsl:with-param name="current_count" select="0"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="new_max_so_far">
     <xsl:choose>
       <xsl:when test="$num_spaces_this_line &lt; $max_so_far">
         <xsl:value-of select="$num_spaces_this_line"/>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="$max_so_far"/>
       </xsl:otherwise>
     </xsl:choose>
  </xsl:variable>
  <!-- 现在检查是否是最后一行，如果不是，则递归 -->
  <xsl:if test="$rest=''">
    <xsl:value-of select="$new_max_so_far"/>
  </xsl:if>
  <xsl:if test="not($rest='')">
    <xsl:call-template name="num_leading_spaces">
      <xsl:with-param name="text" select="$rest"/>
      <xsl:with-param name="max_so_far" select="$new_max_so_far"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>
<!-- 给定文本，确定代码的起始位置。
     这与num_leading_spaces_one_line类似，但将"Yes:"和"No:"视为空格。
     另外，如果第一行没有代码，它会搜索后续行直到找到非空行。
     用于查找类似以下代码片段的代码起始位置：
     Yes: if(foo):
     No : if(foo):
     以及：
     Yes:
       if (foo):
-->
<xsl:template name="code_start_index">
  <xsl:param name="text"/>
  <xsl:param name="current_count"/>
  <xsl:choose>
    <xsl:when test="starts-with($text, ' ')">
      <xsl:call-template name="code_start_index">
        <xsl:with-param name="text" select="substring($text, 2)"/>
        <xsl:with-param name="current_count" select="$current_count + 1"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="starts-with($text, 'Yes:')">
      <xsl:call-template name="code_start_index">
        <xsl:with-param name="text" select="substring($text, 5)"/>
        <xsl:with-param name="current_count" select="$current_count + 4"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="starts-with($text, 'No:')">
      <xsl:call-template name="code_start_index">
        <xsl:with-param name="text" select="substring($text, 4)"/>
        <xsl:with-param name="current_count" select="$current_count + 3"/>
      </xsl:call-template>
    </xsl:when>
    <!-- 只有当第一行完全是空白或仅包含"Yes:"或"No:"时才会到达这里 -->
    <xsl:when test="starts-with($text, '&#xA;')">
      <xsl:call-template name="code_start_index">
        <xsl:with-param name="text" select="substring($text, 2)"/>
        <xsl:with-param name="current_count" select="0"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$current_count"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ends_with_colon的辅助函数。确定给定行是否仅包含空格和Python风格的注释。 -->
<xsl:template name="is_blank_or_comment">
  <xsl:param name="line"/>
  <xsl:choose>
    <xsl:when test="$line = ''">
      <xsl:value-of select="1"/>
    </xsl:when>
    <xsl:when test="starts-with($line, '&#xA;')">
      <xsl:value-of select="1"/>
    </xsl:when>
    <xsl:when test="starts-with($line, '#')">
      <xsl:value-of select="1"/>
    </xsl:when>
    <xsl:when test="starts-with($line, ' ')">
      <xsl:call-template name="is_blank_or_comment">
        <xsl:with-param name="line" select="substring($line, 2)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="0"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 确定给定行是否以冒号结尾。注意，Python风格的注释会被忽略，因此以下行返回True：
     - def foo():
     - def foo():  # Bar
     - if(foo):

     但有些代码可能会混淆此函数。例如，以下行也被认为是"以冒号结尾"，尽管它们在Python中不是：
     - foo(":  #")
     - foo() # No need for :
-->
<xsl:template name="ends_with_colon">
  <xsl:param name="line"/>
  <xsl:param name="found_colon"/>
  <xsl:choose>
    <xsl:when test="$line = ''">
      <xsl:value-of select="$found_colon"/>
    </xsl:when>
    <xsl:when test="starts-with($line, '&#xA;')">
      <xsl:value-of select="$found_colon"/>
    </xsl:when>
    <xsl:when test="starts-with($line, ' ')">
      <xsl:call-template name="ends_with_colon">
        <xsl:with-param name="line" select="substring($line, 2)"/>
        <xsl:with-param name="found_colon" select="$found_colon"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="starts-with($line, ':')">
      <xsl:variable name="rest_is_comment">
        <xsl:call-template name="is_blank_or_comment">
          <xsl:with-param name="line" select="substring($line, 2)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$rest_is_comment = '1'">
          <xsl:value-of select="1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ends_with_colon">
            <xsl:with-param name="line" select="substring($line, 2)"/>
            <xsl:with-param name="found_colon" select="0"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="ends_with_colon">
        <xsl:with-param name="line" select="substring($line, 2)"/>
        <xsl:with-param name="found_colon" select="0"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 打印一行Python代码，并以适当的缩进递归调用自身处理剩余文本。
     此模板使用"a", "b", "c"和"d"来指代四个关键列号。它们是：
     - a: 代码片段中所有行的共同缩进。这在xml中被去除以便于代码更清晰。
     - b: 代码中最外层缩进的行。这与"a"不同，当代码带有"Yes:"或"No:"标签时。
     - c: 当前Python块的缩进，换句话说，是此块第一行的缩进，即我们看到的最后以冒号结尾的行的缩进。
     - d: 行的“总”缩进，忽略行上可能的"Yes:"或"No:"文本。

     例如，对于以下代码片段的最后一行，a, b, c和d的位置如下所示：
         Yes: def Foo():
                if bar():
                  a += 1
                  baz()
         a    b c d
算法如下：
1) 将文本分割为第一行和剩余部分。请注意，substring-before函数应该处理字符串中不存在该字符的情况，但它没有做到，所以我们自动忽略代码片段的最后一行，该行总是空的（即关闭代码片段标签）。这与print_without_leading_chars的行为一致。
2) 如果当前行为空（仅包含空白字符），则打印换行符，并对剩余文本和不变的其他参数进行递归调用。
3) 否则，测量“d”。
4) 通过以下方式测量“c”：
   - 如果前一行以冒号结尾或当前行相对于前一行缩进减少，则取“d”的值
   - 否则，取前一行的缩进
5) 打印line[a:c]（注意我们忽略line[0:a]）
6) 在外部span中打印line[b:c]（为了在外部代码中加倍块缩进）。
7) 打印line[c:<end>]，并处理函数名以生成内部和外部名称。
8) 如果还有更多行，则递归处理。
-->
<xsl:template name="print_python_line_recursively">
  <xsl:param name="text"/>
  <xsl:param name="a"/>
  <xsl:param name="b"/>
  <xsl:param name="previous_indent"/>
  <xsl:param name="previous_ends_with_colon"/>
  <xsl:param name="is_first_line"/>
  <xsl:variable name="line" select="substring-before($text, '&#xA;')"/>
  <xsl:variable name="rest" select="substring-after($text, '&#xA;')"/>
  <xsl:choose>
    <xsl:when test="substring($line, $b) = '' and not($rest = '')">
      <xsl:if test="not($is_first_line = '1')">
        <xsl:text>&#xA;</xsl:text>
      </xsl:if>
      <xsl:call-template name="print_python_line_recursively">
        <xsl:with-param name="text" select="$rest"/>
        <xsl:with-param name="a" select="$a"/>
        <xsl:with-param name="b" select="$b"/>
        <xsl:with-param name="previous_indent" select="$previous_indent"/>
        <xsl:with-param name="previous_ends_with_colon"
                        select="$previous_ends_with_colon"/>
        <xsl:with-param name="is_first_line" select="0"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="indent_after_b">
        <xsl:call-template name="num_leading_spaces_one_line">
          <xsl:with-param name="text" select="substring($line, $b + 1)"/>
          <xsl:with-param name="current_count" select="0"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="d" select="$b + $indent_after_b"/>
      <xsl:variable name="c">
         <xsl:choose>
           <xsl:when test="$previous_ends_with_colon = '1' or
                           $previous_indent > $d">
             <xsl:value-of select="$d"/>
           </xsl:when>
           <xsl:otherwise>
             <xsl:value-of select="$previous_indent"/>
           </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:value-of select="substring($line, $a + 1, $c - $a)"/>
      <span class="external">
         <xsl:value-of select="substring($line, $b + 1, $c - $b)"/>
      </span>
      <xsl:call-template name="munge_function_names_in_text">
        <xsl:with-param name="stripped_line"
           select="substring($line, $c + 1)"/>
      </xsl:call-template>
      <xsl:if test="not(substring($rest, $a) = '')">
        <xsl:text>&#xA;</xsl:text>
        <xsl:call-template name="print_python_line_recursively">
          <xsl:with-param name="text" select="$rest"/>
          <xsl:with-param name="a" select="$a"/>
          <xsl:with-param name="b" select="$b"/>
          <xsl:with-param name="previous_indent" select="$c"/>
          <xsl:with-param name="previous_ends_with_colon">
            <xsl:call-template name="ends_with_colon">
              <xsl:with-param name="line" select="$line"/>
              <xsl:with-param name="found_colon" select="0"/>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="is_first_line" select="0"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 以内部和外部样式打印Python代码。
     为了在外部符合PEP-8，我们识别2个空格的缩进和仅外部的4个空格的缩进。
     标记为$$FunctionName/$$的函数名会添加一个外部的下划线小写版本。 -->
<xsl:template name="print_python_code">
  <xsl:param name="text"/>

  <xsl:variable name="a">
     <xsl:call-template name="num_leading_spaces">
       <xsl:with-param name="text" select="."/>
       <xsl:with-param name="max_so_far" select="1000"/>
     </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="b">
    <xsl:call-template name="code_start_index">
      <xsl:with-param name="text" select="$text"/>
      <xsl:with-param name="current_count" select="0"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="print_python_line_recursively">
    <xsl:with-param name="text" select="$text"/>
    <xsl:with-param name="a" select="$a"/>
    <xsl:with-param name="b" select="$b"/>
    <xsl:with-param name="previous_indent" select="$b"/>
    <xsl:with-param name="previous_ends_with_colon" select="0"/>
    <xsl:with-param name="is_first_line" select="1"/> 
  </xsl:call-template>
</xsl:template>
<!-- 给定一个文本块，每行以\n结束，以及一个数字n，
     输出删除每行前n个字符后的文本。如果strip==1，则我们省略文本开头和结尾的空行（但不包括中间的！） -->
<!-- TODO(csilvers): 处理前导制表符（视为8个空格？） -->
<xsl:template name="print_without_leading_chars">
  <xsl:param name="text"/>
  <xsl:param name="trim_count"/>
  <xsl:param name="strip"/>
  <xsl:param name="is_firstline"/>
  <!-- TODO(csilvers): 处理文本不以换行符结尾的情况 -->
  <xsl:variable name="line" select="substring-before($text, '&#xA;')"/>
  <xsl:variable name="rest" select="substring-after($text, '&#xA;')"/>
  <xsl:variable name="stripped_line" select="substring($line, $trim_count+1)"/>
  <xsl:choose>
    <!-- 如果我们将整行修剪掉，则$line（或$rest）被视为空 -->
    <xsl:when test="($strip = '1') and ($is_firstline = '1') and
                    (string-length($line) &lt;= $trim_count)">
    </xsl:when>
    <xsl:when test="($strip = '1') and
                    (string-length($rest) &lt;= $trim_count)">
      <xsl:value-of select="$stripped_line"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$stripped_line"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="not($rest='')">
    <xsl:call-template name="print_without_leading_chars">
      <xsl:with-param name="text" select="$rest"/>
      <xsl:with-param name="trim_count" select="$trim_count"/>
      <xsl:with-param name="strip" select="$strip"/>
      <xsl:with-param name="is_firstline" select="0"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!-- 给定一行代码，查找用$$ /$$标记的函数名，
     并输出带有函数名内部和外部版本的行。-->
<xsl:template name="munge_function_names_in_text">
  <xsl:param name="stripped_line"/>
  <xsl:choose>
    <xsl:when test="contains($stripped_line, '$$')">
      <xsl:value-of select="substring-before($stripped_line, '$$')"/>
      <xsl:call-template name="print_function_name">
        <xsl:with-param name="text" select="substring-after(substring-before($stripped_line, '/$$'), '$$')"/>
      </xsl:call-template>
      <xsl:call-template name="munge_function_names_in_text">
        <xsl:with-param name="stripped_line" select="substring-after($stripped_line, '/$$')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$stripped_line"/>
   </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- 给定一个函数名，在各自的span中输出函数名的内部和外部版本。-->
<xsl:template name="print_function_name">
  <xsl:param name="text"/>
    <xsl:call-template name="convert_camel_case_to_lowercase_with_under">
      <xsl:with-param name="text" select="$text"/>
    </xsl:call-template>
</xsl:template>

<!-- 给定一个单词，将其从CamelCase转换为
     lower_with_under。
     这意味着用_后跟小写版本替换每个大写字符，除了第一个字符，它被替换时不添加_。-->
<xsl:template name="convert_camel_case_to_lowercase_with_under">
  <xsl:param name="text"/>
  <xsl:param name="is_recursive_call"/>
  <xsl:variable name="first_char" select="substring($text, 1, 1)"/>
  <xsl:variable name="rest" select="substring($text, 2)"/>
  <xsl:choose>
    <xsl:when test="contains('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $first_char)">
      <xsl:if test="$is_recursive_call='1'">
         <xsl:text>_</xsl:text>
      </xsl:if>
      <xsl:value-of select="translate($first_char, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$first_char" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="not($rest='')">
    <xsl:call-template name="convert_camel_case_to_lowercase_with_under">
      <xsl:with-param name="text" select="$rest"/>
      <xsl:with-param name="is_recursive_call" select="1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>