# Google 风格指南

每个主要的开源项目都有自己的风格指南：一套关于如何为该项目编写代码的约定（有时是任意的）。当一个大型代码库中的所有代码都采用一致的风格时，理解它会变得更加容易。

“风格”涵盖了很多方面，从“变量名使用驼峰命名法”到“绝不使用全局变量”再到“绝不使用异常”。这个项目（[google/styleguide](https://github.com/google/styleguide)）链接到我们用于 Google 代码的风格指南。如果您正在修改源自 Google 的项目，您可能会被指向此页面以查看适用于该项目的风格指南。

*   [AngularJS 风格指南][angular]
*   [Common Lisp 风格指南][cl]
*   [C++ 风格指南][cpp]
*   [C# 风格指南][csharp]
*   [Go 风格指南][go]
*   [HTML/CSS 风格指南][htmlcss]
*   [JavaScript 风格指南][js]
*   [Java 风格指南][java]
*   [JSON 风格指南][json]
*   [Markdown 风格指南][markdown]
*   [Objective-C 风格指南][objc]
*   [Python 风格指南][py]
*   [R 风格指南][r]
*   [Shell 风格指南][sh]
*   [Swift 风格指南][swift]
*   [TypeScript 风格指南][ts]
*   [Vim 脚本风格指南][vim]

此项目还包含 [google-c-style.el][emacs]，这是用于 Google 风格的 Emacs 设置文件。

我们曾经托管 cpplint 工具，但我们停止了内部更新的公开。开源社区已经分叉了该项目，因此用户被鼓励使用 https://github.com/cpplint/cpplint。

如果您的项目要求您创建一个新的 XML 文档格式，[XML 文档格式风格指南][xml] 可能会有所帮助。除了实际的风格规则外，它还包含关于设计您自己的格式与适应现有格式的建议，关于 XML 实例文档格式的建议，以及关于元素与属性的建议。

此项目中的风格指南在 CC-By 3.0 许可下发布，该许可鼓励您分享这些文档。请参阅 [https://creativecommons.org/licenses/by/3.0/][ccl] 以获取更多详细信息。

以下 Google 风格指南位于此项目之外：

*  [有效的 Dart][dart]
*  [Kotlin 风格指南][kotlin]

由于项目主要在 [VCS] 中维护，编写好的提交消息对项目的长期健康至关重要。请参考 [如何编写 Git 提交消息](https://cbea.ms/git-commit/) 作为一个优秀的资源。虽然它明确提到了 Git [SCM]，但其原则适用于任何系统，并且许多 Git 约定很容易转换到其他系统上。
## 贡献

除了少数例外，这些风格指南是谷歌内部风格指南的副本，旨在帮助开发者处理谷歌拥有和发起的开源项目。风格指南的更改首先在内部风格指南中进行，最终会复制到此处找到的版本中。**不接受外部贡献。**拉取请求通常会在没有评论的情况下被关闭。

人们可以使用 [GitHub 跟踪器][gh-tracker] 提交 [问题][gh-tracker]。提出问题、基于技术优势证明更改的合理性，或指出明显错误的问题可能会得到一些回应，并且理论上可能导致更改，但我们主要是针对谷歌的内部需求进行优化。

<a rel="license" href="https://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/3.0/88x31.png" /></a>

[cpp]: https://google.github.io/styleguide/cppguide.html
[csharp]: https://google.github.io/styleguide/csharp-style.html
[swift]: https://google.github.io/swift/
[objc]: objcguide.md
[gh-tracker]: https://github.com/google/styleguide/issues
[go]: go/
[java]: https://google.github.io/styleguide/javaguide.html
[json]: https://google.github.io/styleguide/jsoncstyleguide.xml
[kotlin]: https://developer.android.com/kotlin/style-guide
[py]: https://google.github.io/styleguide/pyguide.html
[r]: https://google.github.io/styleguide/Rguide.html
[sh]: https://google.github.io/styleguide/shellguide.html
[htmlcss]: https://google.github.io/styleguide/htmlcssguide.html
[js]: https://google.github.io/styleguide/jsguide.html
[markdown]: https://google.github.io/styleguide/docguide/style.html
[ts]: https://google.github.io/styleguide/tsguide.html
[angular]: https://google.github.io/styleguide/angularjs-google-style.html
[cl]: https://google.github.io/styleguide/lispguide.xml
[vim]: https://google.github.io/styleguide/vimscriptguide.xml
[emacs]: https://raw.githubusercontent.com/google/styleguide/gh-pages/google-c-style.el
[xml]: https://google.github.io/styleguide/xmlstyle.html
[dart]: https://www.dartlang.org/guides/language/effective-dart
[ccl]: https://creativecommons.org/licenses/by/3.0/
[SCM]: https://en.wikipedia.org/wiki/Source_control_management
[VCS]: https://en.wikipedia.org/wiki/Version_control_system