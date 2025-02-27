# Go 风格指南

https://jqknono.github.io/styleguide/go

[概述](index) | [指南](guide) | [决策](decisions) |
[最佳实践](best-practices)

<!--

-->

{% raw %}

<a id="about"></a>

## 关于

Go 风格指南及配套文档旨在整理当前编写可读且符合 Go 语言习惯的最佳方法。 遵守风格指南并非绝对要求，这些文档也永远不会详尽无遗。 我们的目的是最大限度地减少编写可读 Go 代码时的猜测，以便 Go 语言的新手可以避免常见的错误。 风格指南还有助于统一 Google 中任何审查 Go 代码的人员所提供的风格指导。

文档            | 链接                                                  | 主要受众    | [规范性] | [权威性]
------------------- | ----------------------------------------------------- | ------------------- | ----------- | -----------
**风格指南**     | https://jqknono.github.io/styleguide/go/guide          | 所有人            | 是         | 是
**风格决策** | https://jqknono.github.io/styleguide/go/decisions      | 可读性导师 | 是         | 否
**最佳实践**  | https://jqknono.github.io/styleguide/go/best-practices | 任何感兴趣的人   | 否          | 否

[规范性]: #normative
[权威性]: #canonical

<a id="docs"></a>

### 文档

1.  **[风格指南](https://jqknono.github.io/styleguide/go/guide)** 概述了 Google 中 Go 风格的基础。 本文档是权威性的，是风格决策和最佳实践中建议的基础。

1.  **[风格决策](https://jqknono.github.io/styleguide/go/decisions)** 是一份更详细的文档，总结了关于特定风格点的决策，并在适当的情况下讨论了决策背后的原因。

    这些决策可能会根据新数据、新语言特性、新库或新兴模式而偶尔发生变化，但不期望 Google 的单个 Go 程序员能够及时了解本文档。

1.  **[最佳实践](https://jqknono.github.io/styleguide/go/best-practices)** 记录了一些随着时间推移而演变的模式，这些模式可以解决常见问题，易于阅读，并且能够满足代码维护的需要。

    这些最佳实践不是权威性的，但鼓励 Google 的 Go 程序员尽可能使用它们，以保持代码库的统一性和一致性。

这些文档旨在：

*   就权衡替代风格的一组原则达成一致
*   整理已确定的 Go 风格问题
*   记录 Go 语言习惯用法并提供权威示例
*   记录各种风格决策的优缺点
*   帮助最大限度地减少 Go 可读性审查中的意外情况
*   帮助可读性导师使用一致的术语和指导

这些文档**不**旨在：

*   成为可在可读性审查中给出的评论的详尽列表
*   列出每个人都应该记住并始终遵循的所有规则
*   取代在使用语言特性和风格时的良好判断
*   证明为了消除风格差异而进行的大规模更改是合理的

不同的 Go 程序员之间以及不同团队的代码库之间总是会存在差异。 但是，我们的代码库尽可能保持一致，这符合 Google 和 Alphabet 的最大利益。（有关一致性的更多信息，请参见 [指南](guide#consistency)。）为此，您可以随意进行风格改进，但无需吹毛求疵地挑出您发现的每个违反风格指南的行为。 特别是，这些文档可能会随着时间的推移而发生变化，但这并不是导致现有代码库中产生额外变动的原因；使用最新的最佳实践编写新代码并在一段时间内解决附近的问题就足够了。

重要的是要认识到，风格问题本质上是个人化的，并且总是存在固有的权衡。 这些文档中的大部分指导都是主观的，但就像 `gofmt` 一样，它们提供的统一性具有重要价值。 因此，如果没有经过适当的讨论，风格建议将不会被更改，即使 Google 的 Go 程序员可能不同意，也鼓励他们遵循风格指南。

<a id="definitions"></a>

## 定义

以下词语在整个风格文档中使用，定义如下：

*   **权威性**：建立规定性和持久性规则
    <a id="canonical"></a>

    在这些文档中，“权威性”用于描述被认为是所有代码（旧的和新的）都应遵循的标准，并且预计不会随着时间的推移而发生重大变化。 权威性文档中的原则应被作者和审查者理解，因此权威性文档中包含的所有内容都必须达到很高的标准。 因此，权威性文档通常较短，并且规定的风格要素少于非权威性文档。

    https://jqknono.github.io/styleguide/go#canonical

*   **规范性**：旨在建立一致性 <a id="normative"></a>

    在这些文档中，“规范性”用于描述 Go 代码审查者使用的一致同意的风格要素，以便建议、术语和理由保持一致。 这些要素可能会随着时间的推移而发生变化，这些文档将反映这些变化，以便审查者可以保持一致和最新。 Go 代码的作者不需要熟悉规范性文档，但审查者在可读性审查中经常会将这些文档用作参考。

    https://jqknono.github.io/styleguide/go#normative

*   **符合语言习惯**：常见且熟悉 <a id="idiomatic"></a>

    在这些文档中，“符合语言习惯”用于指代 Go 代码中普遍存在的事物，并且已成为易于识别的熟悉模式。 一般来说，如果符合语言习惯的模式和不符合语言习惯的模式在上下文中服务于相同的目的，则应首选符合语言习惯的模式，因为读者会最熟悉这种模式。

    https://jqknono.github.io/styleguide/go#idiomatic

<a id="references"></a>

## 补充参考

本指南假定读者熟悉 [Effective Go]，因为它为整个 Go 社区的 Go 代码提供了共同的基准。

以下是一些额外的资源，供那些希望自学 Go 风格的人以及希望在其审查中提供更多可链接上下文的审查者使用。 Go 可读性流程的参与者不需要熟悉这些资源，但它们可能会作为可读性审查中的上下文出现。

[Effective Go]: https://go.dev/doc/effective_go

**外部参考**

*   [Go 语言规范](https://go.dev/ref/spec)
*   [Go FAQ](https://go.dev/doc/faq)
*   [Go 内存模型](https://go.dev/ref/mem)
*   [Go 数据结构](https://research.swtch.com/godata)
*   [Go 接口](https://research.swtch.com/interfaces)
*   [Go 谚语](https://go-proverbs.github.io/)

*   <a id="gotip"></a> Go Tip Episodes - 敬请期待。

*   <a id="unit-testing-practices"></a> 单元测试实践 - 敬请期待。

**相关的“厕所上的测试”文章**

*   [TotT：标识符命名][tott-431]
*   [TotT：测试状态与测试交互][tott-281]
*   [TotT：有效测试][tott-324]
*   [TotT：风险驱动的测试][tott-329]
*   [TotT：变更检测器测试被认为是有害的][tott-350]

[tott-431]: https://testing.googleblog.com/2017/10/code-health-identifiernamingpostforworl.html
[tott-281]: https://testing.googleblog.com/2013/03/testing-on-toilet-testing-state-vs.html
[tott-324]: https://testing.googleblog.com/2014/05/testing-on-toilet-effective-testing.html
[tott-329]: https://testing.googleblog.com/2014/05/testing-on-toilet-risk-driven-testing.html
[tott-350]: https://testing.googleblog.com/2015/01/testing-on-toilet-change-detector-tests.html

**其他外部著作**

*   [Go 和教条](https://research.swtch.com/dogma)
*   [少即是指数级的多](https://commandcenter.blogspot.com/2012/06/less-is-exponentially-more.html)
*   [Esmerelda 的想象力](https://commandcenter.blogspot.com/2011/12/esmereldas-imagination.html)
*   [用于解析的正则表达式](https://commandcenter.blogspot.com/2011/08/regular-expressions-in-lexing-and.html)
*   [Gofmt 的风格不是任何人的最爱，但 Gofmt 是每个人的最爱](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=8m43s)
    (YouTube)

<!--

-->

{% endraw %}
