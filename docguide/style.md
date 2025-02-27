# Markdown 风格指南

Markdown 的魅力很大程度上在于能够编写纯文本，并获得出色的格式化输出。为了给下一位作者提供清晰的创作环境，你的 Markdown 代码应尽可能简洁，并与整个语料库保持一致。

我们力求平衡以下三个目标：

1.  *源文本可读且易于移植。*
2.  *Markdown 语料库在长期和跨团队中都易于维护。*
3.  *语法简单易记。*

目录：

1.  [最小可行文档](#minimum-viable-documentation)
2.  [更好优于最佳](#better-is-better-than-best)
3.  [大小写](#capitalization)
4.  [文档布局](#document-layout)
5.  [目录](#table-of-contents)
6.  [字符行限制](#character-line-limit)
7.  [尾随空格](#trailing-whitespace)
8.  [标题](#headings)
    1.  [ATX 样式的标题](#atx-style-headings)
    2.  [为标题使用唯一、完整的名称](#use-unique-complete-names-for-headings)
    3.  [为标题添加间距](#add-spacing-to-headings)
    4.  [使用单个 H1 标题](#use-a-single-h1-heading)
    5.  [标题的大小写](#capitalization-of-titles-and-headers)
9.  [列表](#lists)
    1.  [长列表使用惰性编号](#use-lazy-numbering-for-long-lists)
    2.  [嵌套列表间距](#nested-list-spacing)
10. [代码](#code)
    1.  [内联](#inline)
    2.  [使用代码跨度进行转义](#use-code-span-for-escaping)
    3.  [代码块](#codeblocks)
        1.  [声明语言](#declare-the-language)
        2.  [转义换行符](#escape-newlines)
        3.  [使用围栏式代码块而不是缩进式代码块](#use-fenced-code-blocks-instead-of-indented-code-blocks)
        4.  [在列表中嵌套代码块](#nest-codeblocks-within-lists)
11. [链接](#links)
    1.  [在 Markdown 中为链接使用显式路径](#use-explicit-paths-for-links-within-markdown)
    2.  [避免使用相对路径，除非在同一目录下](#avoid-relative-paths-unless-within-the-same-directory)
    3.  [使用信息丰富的 Markdown 链接标题](#use-informative-markdown-link-titles)
    4.  [引用链接](#reference-links)
        1.  [长链接使用引用链接](#use-reference-links-for-long-links)
        2.  [使用引用链接减少重复](#use-reference-links-to-reduce-duplication)
        3.  [在首次使用后定义引用链接](#define-reference-links-after-their-first-use)
12. [图片](#images)
13. [表格](#tables)
14. [强烈建议使用 Markdown 而不是 HTML](#strongly-prefer-markdown-to-html)

## 最小可行文档

一小部分新鲜且准确的文档胜过庞大而松散的、处于各种损坏状态的“文档”集合。

**Markdown 方式**鼓励工程师拥有自己的文档，并像保持测试良好状态一样，保持文档的更新。努力做到这一点。

*   确定你真正需要什么：发布文档、API 文档、测试指南。
*   经常且小批量地删除无用内容。

## 更好优于最佳

内部文档审查的标准与代码审查的标准不同。审查者应该要求改进，但一般来说，作者应该始终能够援引“更好/最佳规则”。

快速迭代是你的朋友。为了获得长期改进，**作者在进行短期改进时必须保持高效**。为每个 CL 设置较低的标准，以便可以发生**更多这样的 CL**。

作为文档 CL 的审查者：

1.  在合理的情况下，立即 LGTM 并相信评论将得到适当修复。
2.  更喜欢提出替代方案，而不是留下模糊的评论。
3.  对于重大更改，请启动你自己的后续 CL。尤其要避免“你还应该……”形式的评论。
4.  在极少数情况下，如果 CL 实际上使文档变得更糟，则阻止提交。可以要求作者恢复。

作为作者：

1.  避免在琐碎的争论中浪费时间。尽早屈服并继续前进。
2.  根据需要多次引用更好/最佳规则。

## 大小写

使用产品、工具和二进制文件的原始名称，保留大小写。例如：

```markdown
# Markdown 风格指南

`Markdown` 是一个极其简单的内部工程文档平台。
```

而不是

```markdown
# markdown 糟糕的风格指南示例

`markdown` 是一个极其简单的内部工程文档平台。
```

## 文档布局

一般来说，文档可以从以下布局的某种变体中受益：

```markdown
# 文档标题

简短介绍。

[TOC]

## 主题

内容。

## 参见

* https://link-to-more-info
```

1.  `# 文档标题`：第一个标题应为一级标题，理想情况下与文件名相同或几乎相同。第一个一级标题用作页面 `<title>`。

1.  `author`：*可选*。如果你想声明文档的所有权，或者你对它感到非常自豪，请在标题下添加你自己。但是，修订历史通常就足够了。

1.  `简短介绍。` 1-3 句话，提供主题的高级概述。把自己想象成一个完全的新手，偶然发现了你的“扩展 Foo”文档，并且不知道你认为理所当然的最基本信息。“什么是 Foo？我为什么要扩展它？”

1.  `[TOC]`：如果你使用的托管服务支持目录，例如 Gitiles，请在简短介绍后放置 `[TOC]`。请参阅 [`[TOC]` 文档][TOC-docs]。

1.  `## 主题`：其余标题应从 2 级开始。

1.  `## 参见`：将其他链接放在底部，供想要了解更多信息或没有找到所需内容的用户使用。

[TOC-docs]: https://gerrit.googlesource.com/gitiles/+/HEAD/Documentation/markdown.md#Table-of-contents

## 目录

### 使用 `[TOC]` 指令

使用 [`[TOC]` 指令][TOC-docs]，除非你的所有内容都在笔记本电脑上的首屏[^above]上。

[^above]: 内容是“首屏”的，如果它在页面首次显示时可见。内容是“非首屏”的，如果它在用户在计算机上向下滚动页面或实际展开报纸等文档之前是隐藏的。

### 将 `[TOC]` 指令放在介绍之后

将 `[TOC]` 指令放在页面介绍之后和第一个 H2 标题之前。例如：

```markdown
# 我的页面

这是 TOC **之前**的介绍。

[TOC]

## 我的第一个 H2
```

```markdown
# 我的页面

[TOC]

这是 TOC **之后**的介绍，它不应该在那里。

## 我的第一个 H2
```

对于以视觉方式阅读文档的用户来说，`[TOC]` 指令放置在哪里并不重要，因为 Markdown 始终将 TOC 显示在页面顶部和右侧。但是，当涉及屏幕阅读器或键盘控件时，`[TOC]` 的放置位置非常重要。

这是因为 `[TOC]` 会将目录的 HTML 插入到 DOM 中，无论你在 Markdown 文件中包含该指令的位置。例如，如果你将指令放在文件的最底部，屏幕阅读器只有在到达文档末尾时才会读取它。

## 字符行限制

Markdown 内容遵循 80 个字符行限制的剩余约定。为什么？因为这是我们大多数人对代码所做的事情。

*   **工具集成**：我们所有的工具都是围绕代码设计的，因此我们的文档按照类似的规则格式化得越多，这些工具的效果就越好。例如，代码搜索不会软换行。

*   **质量**。工程师在创建和编辑 Markdown 内容时，使用他们磨练已久的编码习惯越多，质量就越好。Markdown 利用了我们已经拥有的优秀审查文化。

### 例外

80 个字符规则的例外情况包括：

*   链接
*   表格
*   标题
*   代码块

这意味着带有链接的行可以超出第 80 列，以及任何相关的标点符号：

```markdown
*   请参阅
    [foo 文档](https://gerrit.googlesource.com/gitiles/+/HEAD/Documentation/markdown.md)。
    并找到日志文件。
```

但是，请注意，链接之前和之后的文本会被换行。

表格也可能很长。但是，有一些
[创建简短、可读表格的最佳实践](#tables)。

```markdown
Foo                                                                           | Bar | Baz
----------------------------------------------------------------------------- | --- | ---
Somehow-unavoidable-long-cell-filled-with-content-that-simply-refuses-to-wrap | Foo | Bar
```

## 尾随空格

不要使用尾随空格。使用尾随反斜杠来断行。

[CommonMark 规范](http://spec.commonmark.org/0.20/#hard-line-breaks)规定，行尾的两个空格应插入一个 `<br />` 标签。但是，许多目录都有一个预提交检查来检查尾随空格，并且许多 IDE 无论如何都会清理它。

谨慎使用尾随反斜杠：

```markdown
由于某种原因，我只是真的很想在这里休息一下，\
尽管这可能没有必要。
```

最佳实践是完全避免需要 `<br />`。一对换行符将创建一个段落标签；习惯它。

## 标题

### ATX 样式的标题

```markdown
# 标题 1

## 标题 2
```

带有 `=` 或 `-` 下划线的标题可能难以维护，并且与其余标题语法不符。编辑器必须问：`---` 是指 H1 还是 H2？

```markdown
标题 - 你还记得是什么级别吗？不要这样做。
---------
```

### 为标题使用唯一、完整的名称

为每个标题使用唯一且完全描述性的名称，即使是子部分也是如此。由于链接锚点是从标题构建的，因此这有助于确保自动构建的锚点链接直观且清晰。

例如，不要：

```markdown
## Foo
### 摘要
### 示例
## Bar
### 摘要
### 示例
```

而是首选：

```markdown
## Foo
### Foo 摘要
### Foo 示例
## Bar
### Bar 摘要
### Bar 示例
```

### 为标题添加间距

首选在 `#` 之后添加空格，并在之前和之后添加换行符：

```markdown
...之前的文字。

## 标题 2

之后的文字...
```

缺少间距会使源中的阅读更加困难：

```markdown
...之前的文字。

##标题 2
之后的文字... 不要这样做。
```

### 使用单个 H1 标题

使用一个 H1 标题作为文档的标题。后续标题应为 H2 或更深。有关更多信息，请参阅[文档布局](#document-layout)。

### 标题的大小写

请遵循
[大小写](https://developers.google.com/style/capitalization#capitalization-in-titles-and-headings)
中的指南
[Google 开发者文档风格指南](https://developers.google.com/style/)。

## 列表

### 长列表使用惰性编号

Markdown 非常智能，可以使生成的 HTML 正确呈现你的编号列表。对于可能更改的较长列表，尤其是较长的嵌套列表，请使用“惰性”编号：

```markdown
1.  Foo。
1.  Bar。
    1.  Foofoo。
    1.  Barbar。
1.  Baz。
```

但是，如果列表很小并且你不希望更改它，则首选完全编号的列表，因为它在源中更易于阅读：

```markdown
1.  Foo。
2.  Bar。
3.  Baz。
```

### 嵌套列表间距

嵌套列表时，编号列表和项目符号列表都使用 4 个空格的缩进：

```markdown
1.  在项目编号后使用 2 个空格，以便文本本身缩进 4 个空格。
    对于换行文本，使用 4 个空格的缩进。
2.  再次为下一个项目使用 2 个空格。

*   在项目符号后使用 3 个空格，以便文本本身缩进 4 个空格。
    对于换行文本，使用 4 个空格的缩进。
    1.  与之前一样，编号列表使用 2 个空格。
        嵌套列表中的换行文本需要 8 个空格的缩进。
    2.  看起来不错，不是吗？
*   返回到项目符号列表，缩进 3 个空格。
```

以下方法有效，但非常混乱：

```markdown
* 一个空格，
换行文本没有缩进。
     1. 不规则嵌套... 不要这样做。
```

即使没有嵌套，使用 4 个空格的缩进也可以使换行文本的布局保持一致：

```markdown
*   Foo，
    使用 4 个空格的缩进换行。

1.  列表项的两个空格
    以及换行文本之前的 4 个空格。
2.  返回到 2 个空格。
```

但是，当列表很小、未嵌套且为单行时，两种类型的列表都可以使用一个空格：

```markdown
* Foo
* Bar
* Baz。

1. Foo。
2. Bar。
```

## 代码

### 内联

`反引号` 指定将按字面意义呈现的 `内联代码`。将它们用于简短的代码引用、字段名称等：

```markdown
你将需要运行 `really_cool_script.sh arg`。

请注意该表中的 `foo_bar_whammy` 字段。
```

在以通用意义引用文件类型时，而不是特定的现有文件时，请使用内联代码：

```markdown
请务必更新你的 `README.md`！
```

### 使用代码跨度进行转义

当你不想将文本作为普通 Markdown 处理时，例如虚假路径或会导致错误自动链接的示例 URL，请将其包装在反引号中：

```markdown
Markdown 短链接的示例为：`Markdown/foo/Markdown/bar.md`

查询示例可能为：`https://www.google.com/search?q=$TERM`
```

### 代码块

对于超过单行的代码引用，请使用围栏式代码块：

<pre>
```python
def Foo(self, bar):
  self.bar = bar
```
</pre>

#### 声明语言

最佳实践是显式声明语言，以便语法突出显示器和下一个编辑器都不必猜测。

#### 使用围栏式代码块而不是缩进式代码块

四个空格的缩进也被解释为代码块。但是，我们强烈建议对所有代码块使用围栏。

缩进的代码块有时在源中看起来更干净，但它们有几个缺点：

*   你无法指定语言。某些 Markdown 功能与语言说明符相关联。
*   代码块的开头和结尾不明确。
*   缩进的代码块在代码搜索中更难搜索。

```markdown
你将需要运行：

    bazel run :thing -- --foo

然后：

    bazel run :another_thing -- --bar

再次：

    bazel run :yet_again -- --baz
```

#### 转义换行符

由于大多数命令行代码段都旨在直接复制并粘贴到终端中，因此最佳实践是转义任何换行符。在行尾使用单个反斜杠：

<pre>
```shell
$ bazel run :target -- --flag --foo=longlonglonglonglongvalue \
  --bar=anotherlonglonglonglonglonglonglonglonglonglongvalue
```
</pre>

#### 在列表中嵌套代码块

如果你需要在列表中使用代码块，请确保缩进它，以免破坏列表：

```markdown
*   项目符号。

    ```c++
    int foo;
    ```

*   下一个项目符号。
```

你还可以使用 4 个空格创建一个嵌套代码块。只需从列表缩进中额外缩进 4 个空格：

```markdown
*   项目符号。

        int foo;

*   下一个项目符号。
```

## 链接

长链接使源 Markdown 难以阅读并破坏 80 个字符的换行。**尽可能缩短你的链接**。

### 在 Markdown 中为链接使用显式路径

为 Markdown 链接使用显式路径。例如：

```markdown
[...](/path/to/other/markdown/page.md)
```

你不需要使用整个限定 URL：

```markdown
[...](https://bad-full-url.example.com/path/to/other/markdown/page.md)
```

### 避免使用相对路径，除非在同一目录下

相对路径在同一目录下是相当安全的。例如：

```markdown
[...](other-page-in-same-dir.md)
[...](/path/to/another/dir/other-page.md)
```

如果需要使用 `../` 指定其他目录，请避免使用相对链接：

```markdown
[...](../../bad/path/to/another/dir/other-page.md)
```

### 使用信息丰富的 Markdown 链接标题

Markdown 链接语法允许你设置链接标题。明智地使用它。用户通常不阅读文档；他们扫描文档。

链接引人注目。但是，将你的链接标题设置为“此处”、“链接”或简单地复制目标 URL 并不能告诉匆忙的读者任何信息，并且是浪费空间：

```markdown
不要这样做。

有关更多信息，请参阅 Markdown 指南：[链接](markdown.md)，或查看
风格指南[此处](style.md)。

查看典型的测试结果：
[https://example.com/foo/bar](https://example.com/foo/bar)。
```

相反，自然地编写句子，然后返回并用链接包装最合适的短语：

```markdown
有关更多信息，请参阅 [Markdown 指南](markdown.md)，或查看
[风格指南](style.md)。

查看
[典型的测试结果](https://example.com/foo/bar)。
```

### 引用

对于长链接或图像 URL，你可能希望将链接使用与链接定义分开，如下所示：

<!-- 已知错误：我们在此处使用零宽度不间断空格 (U+FEFF) 以防止 -->
<!-- 引用链接在代码块中呈现。-->

```markdown
请参阅 [Markdown 风格指南][style]，其中包含使文档更具可读性的建议。

[style]: http://Markdown/corp/Markdown/docs/reference/style.md
```

#### 长链接使用引用链接

如果链接的长度会影响周围文本的可读性（如果它是内联的），请使用引用链接。引用链接使在源文本中更难看到链接的目标，并添加了额外的语法。

在此示例中，引用链接的使用不合适，因为链接不够长，不会破坏文本的流程：

```markdown
不要这样做。

[风格指南][style_guide]说，除非必须，否则不要使用引用链接。

[style_guide]: https://google.com/Markdown-style
```

只需将其内联即可：

```markdown
https://google.com/Markdown-style 说，除非必须，否则不要使用引用链接。
```

在此示例中，链接目标足够长，可以使用引用链接：

```markdown
[风格指南]说，除非必须，否则不要使用引用链接。

[style guide]: https://docs.google.com/document/d/13HQBxfhCwx8lVRuN2Wf6poqvAfVeEXmFVcawP5I6B3c/edit
```

在表格中更频繁地使用引用链接。保持表格内容简短尤为重要，因为 Markdown 不提供在单元格表格中跨多行断开文本的功能，并且较小的表格更易于阅读。

例如，此表格的可读性因内联链接而降低：

```markdown
不要这样做。

站点                                                             | 描述
---------------------------------------------------------------- | -----------------------
[站点 1](http://google.com/excessively/long/path/example_site_1) | 这是示例站点 1。
[站点 2](http://google.com/excessively/long/path/example_site_2) | 这是示例站点 2。
```

相反，使用引用链接来保持行长度可管理：

```markdown
站点     | 描述
-------- | -----------------------
[站点 1] | 这是示例站点 1。
[站点 2] | 这是示例站点 2。

[站点 1]: http://google.com/excessively/long/path/example_site_1
[站点 2]: http://google.com/excessively/long/path/example_site_2
```

#### 使用引用链接减少重复

当在文档中多次引用相同的链接目标时，请考虑使用引用链接以减少重复。

#### 在首次使用后定义引用链接

我们建议将引用链接定义放在下一个标题之前，即它们首次使用的部分末尾。如果你的编辑器对它们应该放在哪里有自己的看法，请不要与它作斗争；工具总是赢。

我们将“部分”定义为两个标题之间的所有文本。将引用链接视为脚注，并将当前部分视为当前页面。

这种安排使得在源视图中轻松找到链接目标，同时保持文本的流程不受干扰。在具有大量引用链接的长文档中，它还可以防止文件底部的“脚注过载”，这使得难以挑选出相关的链接目标。

此规则有一个例外：在多个部分中使用的引用链接定义应放在文档的末尾。这可以避免在更新或移动部分时出现悬空链接。

在以下示例中，引用定义远离其初始使用，这使得文档更难阅读：

```markdown
# 糟糕文档的标题

一些带有 [链接][link_def] 的文本。

一些带有相同 [链接][link_def] 的更多文本。

## 标题 2

... 大量文本 ...

## 标题 3

一些使用 [different_link][different_link_def] 的更多文本。

[link_def]: http://reallyreallyreallylonglink.com
[different_link_def]: http://differentreallyreallylonglink.com
```

相反，将其放在首次使用后的标题之前：

```markdown
# 标题

一些带有 [链接][link_def] 的文本。

一些带有相同 [链接][link_def] 的更多文本。

[link_def]: http://reallyreallyreallylonglink.com

## 标题 2

... 大量文本 ...

## 标题 3

一些使用 [different_link][different_link_def] 的更多文本。

[different_link_def]: http://differentreallyreallylonglink.com
```

## 图片

请参阅 [图像语法](https://gerrit.googlesource.com/gitiles/+/HEAD/Documentation/markdown.md#Images)。

谨慎使用图像，并首选简单的屏幕截图。本指南围绕着这样一种理念设计：纯文本使用户能够更快地进行交流，减少读者的分心和作者的拖延。但是，有时显示你的意思非常有帮助。

*   当 *显示* 读者某些内容比 *描述* 它更容易时，请使用图像。例如，使用图像通常比使用文本更容易解释如何导航 UI。
*   确保提供适当的文本来描述你的图像。没有视力的读者无法看到你的图像，仍然需要理解内容！请参阅下面的 alt 文本最佳实践。

## 表格

在表格有意义时使用它们：用于呈现需要快速扫描的表格数据。

当你的数据可以轻松地以列表形式呈现时，请避免使用表格。列表在 Markdown 中更容易编写和阅读。

例如：

```markdown
不要这样做

水果  | 指标      | 生长在 | 急性曲率    | 属性                                                                                                  | 备注
------ | ------------ | -------- | ------------------ | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------
苹果  | 非常受欢迎 | 树木    |                    | [多汁](http://cs/SomeReallyReallyReallyReallyReallyReallyReallyReallyLongQuery)，坚硬，甜美               | 苹果让医生远离。
香蕉 | 非常受欢迎 | 树木    | 平均 16 度 | [方便](http://cs/SomeDifferentReallyReallyReallyReallyReallyReallyReallyReallyLongQuery)，柔软，甜美 | 与流行的看法相反，大多数猿类更喜欢芒果。你不喜欢吗？请参阅 [设计文档][banana_v2]，了解 bananiels 的最新热点。
```

此表说明了一些典型问题：

*   **分布不佳**：几列在行之间没有差异，并且某些单元格为空。这通常表明你的数据可能无法从表格显示中受益。

*   **不平衡的维度**：相对于列，行数很少。当此比率在任一方向上不平衡时，表格几乎只是文本的非灵活格式。

*   某些单元格中的**漫无边际的散文**。表格应该一目了然地讲述一个简洁的故事。

[列表](#lists) 和子标题有时足以呈现相同的信息。让我们以列表形式查看此数据：

```markdown
## 水果

两种类型都非常受欢迎、甜美，并且生长在树上。

### 苹果

*   [多汁](http://SomeReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyReallyLongURL)
*   坚硬

苹果让医生远离。

### 香蕉

*   [方便](http://cs/SomeDifferentReallyReallyReallyReallyReallyReallyReallyReallyLongQuery)
*   柔软
*   平均 16 度急性曲率。

与流行的看法相反，大多数猿类更喜欢芒果。你不喜欢吗？

请参阅 [设计文档][banana_v2]，了解 bananiels 的最新热点。
```

列表形式更宽敞，因此可以说读者在这种情况下更容易找到她感兴趣的内容。

但是，有时表格是最佳选择。当你拥有：

*   跨两个维度的相对均匀的数据分布。
*   许多具有不同属性的并行项目。

在这些情况下，表格格式正是你所需要的。事实上，紧凑的表格可以提高可读性：

```markdown
交通工具        | 受益者     | 优点
---------------- | -------------- | -----------------------------------------------
燕子          | 椰子       | [未装载时速度快][airspeed]
自行车          | 格尔奇小姐     | [防风雨][tornado_proofing]
X-34 陆地飞车 | 爱抱怨的农场男孩 | [便宜][tosche_station]，因为 X-38 已经问世

[airspeed]: http://google3/airspeed.h
[tornado_proofing]: http://google3/kansas/
[tosche_station]: http://google3/power_converter.h
```

请注意，[引用链接](#reference-links) 用于保持表格单元格的可管理性。

## 强烈建议使用 Markdown 而不是 HTML

请尽可能首选标准 Markdown 语法，并避免使用 HTML 黑客。如果你似乎无法完成你想要的事情，请重新考虑你是否真的需要它。除了 [大型表格](#tables) 之外，Markdown 已经满足了几乎所有需求。

每一段 HTML 黑客都会降低我们 Markdown 语料库的可读性和可移植性。这反过来又限制了与其他工具集成的有用性，这些工具可能会将源呈现为纯文本或呈现它。请参阅 [哲学](philosophy.md)。

Gitiles 不呈现 HTML。
