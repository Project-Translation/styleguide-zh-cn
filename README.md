# Google 风格指南

每个主要的开源项目都有自己的风格指南：一套关于如何为该项目编写代码的约定（有时是任意的）。当一个大型代码库中的所有代码都采用一致的风格时，理解它会变得更加容易。

“风格”涵盖了很多方面，从“变量名使用驼峰命名法”到“永远不要使用全局变量”再到“永远不要使用异常”。这个项目（[google/styleguide](https://project-translation.github.io/styleguide-zh-cn/)）链接到我们用于 Google 代码的风格指南。如果您正在修改起源于 Google 的项目，您可能会被指向此页面以查看适用于该项目的风格指南。

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

这个项目还包含 [google-c-style.el][emacs]，一个用于 Google 风格的 Emacs 设置文件。

我们曾经托管 cpplint 工具，但我们停止了内部更新的公开。开源社区已经分叉了该项目，因此鼓励用户使用 https://github.com/cpplint/cpplint。

如果您的项目要求您创建一个新的 XML 文档格式，[XML 文档格式风格指南][xml] 可能会有所帮助。除了实际的风格规则外，它还包含关于设计您自己的格式与适应现有格式的建议，关于 XML 实例文档格式的建议，以及关于元素与属性的建议。

这个项目中的风格指南在 CC-By 3.0 许可下发布，该许可鼓励您分享这些文档。有关更多详细信息，请参见 [https://creativecommons.org/licenses/by/3.0/][ccl]。

以下 Google 风格指南位于此项目之外：

*  [Effective Dart][dart]
*  [Kotlin 风格指南][kotlin]

由于项目主要在 [VCS] 中维护，编写好的提交消息对项目的长期健康非常重要。请参考 [如何编写 Git 提交消息](https://cbea.ms/git-commit/) 作为一个优秀的资源。虽然它明确提到了 Git [SCM]，但其原则适用于任何系统，许多 Git 约定很容易转换到其他系统。

## 贡献

除了少数例外，这些风格指南是 Google 内部风格指南的副本，以帮助在 Google 拥有的和起源的开源项目上工作的开发者。对风格指南的更改首先在内部风格指南中进行，最终复制到此处找到的版本中。**不接受外部贡献。**拉取请求定期无评论关闭。

人们可以使用 GitHub 跟踪器[提交问题][gh-tracker]。提出问题、基于技术优点证明更改或指出明显错误的问题可能会得到一些回应，并且理论上可能导致更改，但我们主要是为 Google 的内部需求进行优化。

<a rel="license" href="https://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/3.0/88x31.png" /></a>

[cpp]: https://jqknono.github.io/styleguide/cppguide.html
[csharp]: https://jqknono.github.io/styleguide/csharp-style.html
[swift]: https://jqknono.github.io/swift/
[objc]: objcguide.md
[gh-tracker]: https://github.com/google/styleguide/issues
[go]: go/
[java]: https://jqknono.github.io/styleguide/javaguide.html
[json]: https://jqknono.github.io/styleguide/jsoncstyleguide.xml
[kotlin]: https://developer.android.com/kotlin/style-guide
[py]: https://jqknono.github.io/styleguide/pyguide.html
[r]: https://jqknono.github.io/styleguide/Rguide.html
[sh]: https://jqknono.github.io/styleguide/shellguide.html
[htmlcss]: https://jqknono.github.io/styleguide/htmlcssguide.html
[js]: https://jqknono.github.io/styleguide/jsguide.html
[markdown]: https://jqknono.github.io/styleguide/docguide/style.html
[ts]: https://jqknono.github.io/styleguide/tsguide.html
[angular]: https://jqknono.github.io/styleguide/angularjs-google-style.html
[cl]: https://jqknono.github.io/styleguide/lispguide.xml
[vim]: https://jqknono.github.io/styleguide/vimscriptguide.xml
[emacs]: https://raw.githubusercontent.com/google/styleguide/gh-pages/google-c-style.el
[xml]: https://jqknono.github.io/styleguide/xmlstyle.html
[dart]: https://www.dartlang.org/guides/language/effective-dart
[ccl]: https://creativecommons.org/licenses/by/3.0/
[SCM]: https://en.wikipedia.org/wiki/Source_control_management
[VCS]: https://en.wikipedia.org/wiki/Version_control_system
