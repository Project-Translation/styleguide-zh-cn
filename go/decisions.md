<!--* toc_depth: 3 *-->

# Go 风格决策

https://jqknono.github.io/styleguide/go/decisions

[概览](index) | [指南](guide) | [决策](decisions) |
[最佳实践](best-practices)

<!--

-->

{% raw %}

**注意：** 这是概述 Google Go 风格的一系列文档的一部分。本文档是**[规范性](index#normative)但非[权威性](index#canonical)**的，并且从属于[核心风格指南](guide)。有关更多信息，请参见[概览](index#about)。

<a id="about"></a>

## 关于

本文档包含旨在统一并提供标准指导、解释和示例的风格决策，这些决策由 Go 可读性导师提供。

本文档**并非详尽无遗**，并将随时间增长。在[核心风格指南](guide)与此处提供的建议相矛盾的情况下，**风格指南优先**，本文档应相应更新。

有关完整的 Go 风格文档集，请参见[概览](https://jqknono.github.io/styleguide/go#about)。

以下部分已从风格决策移至指南的其他部分：

*   **混合大小写**：参见 [guide#mixed-caps](guide#mixed-caps)
    <a id="mixed-caps"></a>

*   **格式化**：参见 [guide#formatting](guide#formatting)
    <a id="formatting"></a>

*   **行长度**：参见 [guide#line-length](guide#line-length)
    <a id="line-length"></a>

<a id="naming"></a>

## 命名

有关命名的总体指导，请参见[核心风格指南](guide#naming)中的命名部分。以下部分对命名中的特定领域提供了进一步的澄清。

<a id="underscores"></a>

### 下划线

Go 中的名称通常不应包含下划线。此原则有三个例外：

1.  仅由生成代码导入的包名可以包含下划线。有关如何选择多词包名的更多详细信息，请参见[包名](#package-names)。
1.  `*_test.go` 文件中的测试、基准测试和示例函数名称可以包含下划线。
1.  与操作系统或 cgo 交互的低级库可以重用标识符，如 [`syscall`] 中所做的那样。这在大多数代码库中预计会非常罕见。

[`syscall`]: https://pkg.go.dev/syscall#pkg-constants

<a id="package-names"></a>

### 包名

<a id="TOC-PackageNames"></a>

Go 包名应简短且仅包含小写字母。由多个单词组成的包名应保持不间断的小写形式。例如，包 [`tabwriter`] 的名称不是 `tabWriter`、`TabWriter` 或 `tab_writer`。

避免选择可能被常用本地变量名称[遮蔽]的包名。例如，`usercount` 比 `count` 更适合作为包名，因为 `count` 是常用的变量名称。

Go 包名不应包含下划线。如果您需要导入一个名称中包含下划线的包（通常来自生成或第三方代码），则必须在导入时将其重命名为适合在 Go 代码中使用的名称。

例外情况是，仅由生成代码导入的包名可以包含下划线。具体示例包括：

*   使用 `_test` 后缀作为外部测试包，例如集成测试

*   使用 `_test` 后缀用于[包级文档示例](https://go.dev/blog/examples)

[`tabwriter`]: https://pkg.go.dev/text/tabwriter
[shadowed]: best-practices#shadowing

避免使用如 `util`、`utility`、`common`、`helper` 等无信息量的包名。有关更多关于[所谓的“实用程序包”](best-practices#util-packages)的信息，请参见。

当导入的包被重命名时（例如 `import foopb "path/to/foo_go_proto"`），包的本地名称必须遵守上述规则，因为本地名称决定了文件中如何引用包中的符号。如果某个导入在多个文件中被重命名，特别是在相同或附近的包中，应尽可能使用相同的本地名称以保持一致性。

<!--#include file="/go/g3doc/style/includes/special-name-exception.md"-->

另见：[Go 博客关于包名的文章](https://go.dev/blog/package-names)。

<a id="receiver-names"></a>
### 接收者名称

<a id="TOC-ReceiverNames"></a>

[接收者]变量名称必须是：

*   简短（通常为一到两个字母长）
*   类型本身的缩写
*   对该类型的每个接收者一致应用

长名称                   | 更好的名称
--------------------------- | -------------------------
`func (tray Tray)`          | `func (t Tray)`
`func (info *ResearchInfo)` | `func (ri *ResearchInfo)`
`func (this *ReportWriter)` | `func (w *ReportWriter)`
`func (self *Scanner)`      | `func (s *Scanner)`

[接收者]: https://golang.org/ref/spec#Method_declarations

<a id="constant-names"></a>

### 常量名称

常量名称必须像Go中的所有其他名称一样使用[混合大小写]。([导出]常量以大写字母开头，而未导出的常量以小写字母开头。)即使这打破了其他语言中的惯例，这也适用。常量名称不应是其值的衍生物，而应解释该值所表示的含义。

```go
// 好的：
const MaxPacketSize = 512

const (
    ExecuteBit = 1 << iota
    WriteBit
    ReadBit
)
```

[混合大小写]: guide#mixed-caps
[导出]: https://tour.golang.org/basics/3

不要使用非混合大小写的常量名称或带有`K`前缀的常量。

```go
// 坏的：
const MAX_PACKET_SIZE = 512
const kMaxBufferSize = 1024
const KMaxUsersPergroup = 500
```

根据常量的角色而不是其值来命名常量。如果一个常量除了其值之外没有其他角色，那么定义它为常量是没有必要的。

```go
// 坏的：
const Twelve = 12

const (
    UserNameColumn = "username"
    GroupColumn    = "group"
)
```

<!--#include file="/go/g3doc/style/includes/special-name-exception.md"-->

<a id="initialisms"></a>

### 首字母缩写词

<a id="TOC-Initialisms"></a>

名称中的首字母缩写词或缩写词（例如，`URL`和`NATO`）应具有相同的大小写。`URL`应显示为`URL`或`url`（如`urlPony`，或`URLPony`），而不是`Url`。作为一般规则，标识符（例如，`ID`和`DB`）也应类似于其在英语散文中的使用方式进行大写。

*   在包含多个首字母缩写词的名称中（例如`XMLAPI`，因为它包含`XML`和`API`），给定首字母缩写词内的每个字母应具有相同的大小写，但名称中的每个首字母缩写词不需要具有相同的大小写。
*   在包含小写字母的首字母缩写词的名称中（例如`DDoS`，`iOS`，`gRPC`），首字母缩写词应如标准散文中所示，除非您需要为了[导出性]而更改第一个字母。在这些情况下，整个首字母缩写词应具有相同的大小写（例如`ddos`，`IOS`，`GRPC`）。

[导出性]: https://golang.org/ref/spec#Exported_identifiers

<!-- 保持此表窄。如果必须变宽，请替换为列表。 -->

英语用法 | 范围      | 正确  | 错误
------------- | ---------- | -------- | --------------------------------------
XML API       | 导出   | `XMLAPI` | `XmlApi`, `XMLApi`, `XmlAPI`, `XMLapi`
XML API       | 未导出 | `xmlAPI` | `xmlapi`, `xmlApi`
iOS           | 导出   | `IOS`    | `Ios`, `IoS`
iOS           | 未导出 | `iOS`    | `ios`
gRPC          | 导出   | `GRPC`   | `Grpc`
gRPC          | 未导出 | `gRPC`   | `grpc`
DDoS          | 导出   | `DDoS`   | `DDOS`, `Ddos`
DDoS          | 未导出 | `ddos`   | `dDoS`, `dDOS`
ID            | 导出   | `ID`     | `Id`
ID            | 未导出 | `id`     | `iD`
DB            | 导出   | `DB`     | `Db`
DB            | 未导出 | `db`     | `dB`
Txn           | 导出   | `Txn`    | `TXN`

<!--#include file="/go/g3doc/style/includes/special-name-exception.md"-->

<a id="getters"></a>

### 获取器

<a id="TOC-Getters"></a>

函数和方法名称不应使用`Get`或`get`前缀，除非底层概念使用“get”这个词（例如，HTTP GET）。最好直接以名词开头，例如使用`Counts`而不是`GetCounts`。

如果函数涉及执行复杂计算或执行远程调用，可以使用`Compute`或`Fetch`等不同的词来代替`Get`，以便让读者清楚函数调用可能需要时间，并且可能会阻塞或失败。

<!--#include file="/go/g3doc/style/includes/special-name-exception.md"-->

<a id="variable-names"></a>
### 变量命名

<a id="TOC-VariableNames"></a>

一般来说，变量名的长度应与其作用域的大小成正比，与在该作用域内使用的次数成反比。在文件作用域内创建的变量可能需要多个单词，而在单个内部块作用域内的变量可能只需要一个单词，甚至只需一两个字符，以保持代码清晰，避免多余信息。

以下是一个大致的基准。这些数字指导原则并非严格规则。应根据上下文、[清晰度]和[简洁性]来判断。

*   小作用域是指执行一两个小操作的范围，约1-7行。
*   中等作用域是指几个小操作或一个大操作，约8-15行。
*   大作用域是指一个或几个大操作，约15-25行。
*   非常大的作用域是指跨越一页以上的内容（例如，超过25行）。

[清晰度]: guide#clarity
[简洁性]: guide#concision

在小作用域内可能非常清晰的名称（例如，计数器的`c`）在较大作用域内可能不足，需要澄清以提醒读者其在代码中较远处的用途。在有许多变量或变量代表相似值或概念的作用域中，可能需要比作用域建议的更长的变量名。

概念的具体性也有助于保持变量名的简洁。例如，假设只使用一个数据库，通常保留给非常小作用域的简短变量名如`db`，即使作用域很大，也可能仍然非常清晰。在这种情况下，根据作用域的大小，单词`database`可能是可以接受的，但由于`db`是单词的常见缩写，且很少有其他解释，因此不需要。

本地变量的名称应反映其内容及其在当前上下文中的使用方式，而不是值的来源。例如，最佳的本地变量名通常与结构体或协议缓冲区字段名不同。

一般来说：

*   单词名称如`count`或`options`是一个好的起点。
*   可以添加额外的单词来区分相似的名称，例如`userCount`和`projectCount`。
*   不要为了节省打字时间而简单地删除字母。例如，`Sandbox`比`Sbx`更受欢迎，特别是对于导出的名称。
*   从大多数变量名中省略[类型和类型类似的词]。
    *   对于数字，`userCount`比`numUsers`或`usersInt`更好的名称。
    *   对于切片，`users`比`userSlice`更好的名称。
    *   如果作用域内有两个版本的值，可以包含类型类似的限定词，例如，你可能将输入存储在`ageString`中，并使用`age`表示解析后的值。
*   省略从[周围上下文]中明显的词。例如，在实现`UserCount`方法时，名为`userCount`的本地变量可能是多余的；`count`、`users`甚至`c`同样易读。

[类型和类型类似的词]: #repetitive-with-type
[周围上下文]: #repetitive-in-context

<a id="v"></a>

#### 单字母变量名

单字母变量名可以作为减少[重复](#repetition)的有用工具，但也可能使代码不必要地模糊。将其使用限制在全词显而易见且使用全词会显得重复的情况下。

一般来说：

*   对于[方法接收器变量]，首选一个字母或两个字母的名称。
*   使用常见类型的熟悉变量名通常很有帮助：
    *   `r`用于`io.Reader`或`*http.Request`
    *   `w`用于`io.Writer`或`http.ResponseWriter`
*   单字母标识符作为整数循环变量是可以接受的，特别是作为索引（例如，`i`）和坐标（例如，`x`和`y`）。
*   当作用域较短时，缩写可以作为循环标识符，例如`for _, n := range nodes { ... }`。

[方法接收器变量]: #receiver-names

<a id="repetition"></a>
### 重复

<!--
注意事项给未来的编辑者：

不要使用“结巴”这个词来指代名称重复的情况。
-->

Go源代码应避免不必要的重复。常见的重复来源是重复的名称，这些名称通常包含不必要的词语或重复其上下文或类型。如果同一或相似的代码段在相近的位置多次出现，代码本身也可能是不必要的重复。

重复命名可以有多种形式，包括：

<a id="repetitive-with-package"></a>

#### 包名与导出符号名称

在命名导出符号时，包名在包外始终是可见的，因此应减少或消除两者之间的冗余信息。如果一个包只导出一种类型，并且该类型以包名命名，则构造函数的标准名称是`New`，如果需要的话。

> **示例：** 重复名称 -> 更好的名称
>
> *   `widget.NewWidget` -> `widget.New`
> *   `widget.NewWidgetWithName` -> `widget.NewWithName`
> *   `db.LoadFromDatabase` -> `db.Load`
> *   `goatteleportutil.CountGoatsTeleported` -> `gtutil.CountGoatsTeleported`
>     或 `goatteleport.Count`
> *   `myteampb.MyTeamMethodRequest` -> `mtpb.MyTeamMethodRequest` 或
>     `myteampb.MethodRequest`

<a id="repetitive-with-type"></a>

#### 变量名与类型

编译器总是知道变量的类型，在大多数情况下，读者通过变量的使用方式也能清楚地知道变量的类型。只有当变量的值在同一作用域内出现两次时，才有必要澄清变量的类型。

重复名称               | 更好的名称
--------------------- | ------------------
`var numUsers int`    | `var users int`
`var nameString string` | `var name string`
`var primaryProject *Project` | `var primary *Project`

如果值以多种形式出现，可以通过添加额外的词语如`raw`和`parsed`，或使用底层表示来澄清：

```go
// 好：
limitStr := r.FormValue("limit")
limit, err := strconv.Atoi(limitStr)
```

```go
// 好：
limitRaw := r.FormValue("limit")
limit, err := strconv.Atoi(limitRaw)
```

<a id="repetitive-in-context"></a>

#### 外部上下文与本地名称

包含周围上下文信息的名称通常会产生额外的噪音而无益。包名、方法名、类型名、函数名、导入路径，甚至文件名都可以提供上下文，自动限定其中的所有名称。

```go
// 坏：
// 在包 "ads/targeting/revenue/reporting" 中
type AdsTargetingRevenueReport struct{}

func (p *Project) ProjectName() string
```

```go
// 好：
// 在包 "ads/targeting/revenue/reporting" 中
type Report struct{}

func (p *Project) Name() string
```

```go
// 坏：
// 在包 "sqldb" 中
type DBConnection struct{}
```

```go
// 好：
// 在包 "sqldb" 中
type Connection struct{}
```

```go
// 坏：
// 在包 "ads/targeting" 中
func Process(in *pb.FooProto) *Report {
    adsTargetingID := in.GetAdsTargetingID()
}
```

```go
// 好：
// 在包 "ads/targeting" 中
func Process(in *pb.FooProto) *Report {
    id := in.GetAdsTargetingID()
}
```

一般来说，应该在符号使用者的上下文中评估重复性。例如，以下代码中有很多名称在某些情况下可能没问题，但在上下文中是冗余的：

```go
// 坏：
func (db *DB) UserCount() (userCount int, err error) {
    var userCountInt64 int64
    if dbLoadError := db.LoadFromDatabase("count(distinct users)", &userCountInt64); dbLoadError != nil {
        return 0, fmt.Errorf("failed to load user count: %s", dbLoadError)
    }
    userCount = int(userCountInt64)
    return userCount, nil
}
```

相反，从上下文或使用中明显的信息通常可以省略：

```go
// 好：
func (db *DB) UserCount() (int, error) {
    var count int64
    if err := db.Load("count(distinct users)", &count); err != nil {
        return 0, fmt.Errorf("failed to load user count: %s", err)
    }
    return int(count), nil
}
```

<a id="commentary"></a>
## 注释

关于注释的惯例（包括注释什么、使用什么风格、如何提供可运行的示例等）旨在支持阅读公共API文档的体验。有关更多信息，请参阅[有效的Go](http://golang.org/doc/effective_go.html#commentary)。

最佳实践文档中关于[文档惯例]的部分对此进行了进一步讨论。

**最佳实践：** 在开发和代码审查期间使用[文档预览]来查看文档和可运行示例是否有用，以及它们是否以您期望的方式呈现。

**提示：** Godoc 使用很少的特殊格式；列表和代码片段通常应缩进以避免换行。除了缩进外，一般应避免使用装饰。

[文档预览]: best-practices#documentation-preview
[文档惯例]: best-practices#documentation-conventions

<a id="comment-line-length"></a>

### 注释行长度

确保注释即使在窄屏上也能从源码中读取。

当注释过长时，建议将其包装成多行单行注释。尽可能以80列宽的终端为目标，但这不是硬性规定；Go语言中注释没有固定的行长度限制。例如，标准库通常根据标点符号来断行，这有时会使单行长度接近60-70个字符。

现有代码中有很多注释长度超过80个字符的例子。这条指导原则不应被用作在可读性审查中更改此类代码的理由（参见[一致性](guide#consistency)），但鼓励团队在其他重构过程中机会性地更新注释以遵循此指导原则。此指导原则的主要目标是确保所有Go可读性导师在提出建议时做出相同的推荐。

有关注释的更多信息，请参阅[Go博客上的这篇关于文档的文章]。

[Go博客上的这篇关于文档的文章]: https://blog.golang.org/godoc-documenting-go-code

```text
# 好：
// 这是一个注释段落。
// 在Godoc中，单行长度并不重要；
// 但选择换行使得在窄屏上易于阅读。
//
// 不要太担心长URL：
// https://supercalifragilisticexpialidocious.example.com:8080/Animalia/Chordata/Mammalia/Rodentia/Geomyoidea/Geomyidae/
//
// 同样，如果您有其他信息因过多的换行而变得不便，
// 请根据您的判断，如果有助于而不是妨碍，包含一个长行。
```

避免在小屏幕上反复换行的注释，这会给读者带来不好的体验。

```text
# 坏：
// 这是一个注释段落。单行长度在Godoc中并不重要，
// 但选择换行会在窄屏或代码审查中造成参差不齐的行，
// 这可能会很烦人，尤其是在会反复换行的注释块中。
//
// 不要太担心长URL：
// https://supercalifragilisticexpialidocious.example.com:8080/Animalia/Chordata/Mammalia/Rodentia/Geomyoidea/Geomyidae/
```

<a id="doc-comments"></a>

### 文档注释

<a id="TOC-DocComments"></a>

所有顶级导出名称必须有文档注释，行为或含义不明显的未导出类型或函数声明也应如此。这些注释应为[完整句子]，并以所描述对象的名称开头。可以在名称前加上冠词（“a”, “an”, “the”）以使其读起来更自然。

```go
// 好：
// Request表示运行命令的请求。
type Request struct { ...

// Encode将req的JSON编码写入w。
func Encode(w io.Writer, req *Request) { ...
```

文档注释会出现在[Godoc](https://pkg.go.dev/)中，并被IDE显示，因此应为使用该包的任何人编写。

[完整句子]: #comment-sentences

文档注释适用于后续的符号，或者如果出现在结构体中，则适用于字段组。

```go
// 好：
// Options配置组管理服务。
type Options struct {
    // 一般设置：
    Name  string
    Group *FooGroup

    // 依赖：
    DB *sql.DB

    // 自定义：
    LargeGroupThreshold int // 可选；默认值：10
    MinimumMembers      int // 可选；默认值：2
}
```

**最佳实践：** 如果您为未导出的代码编写文档注释，请遵循与导出代码相同的习惯（即以未导出名称开头）。这样在稍后导出时，只需在注释和代码中将未导出名称替换为新导出的名称即可。
### 注释句子

<a id="TOC-CommentSentences"></a>

完整句子的注释应像标准英语句子一样大写和标点符号。（例外情况是，如果句子开头是一个未大写的标识符名称，并且其他部分清晰明了，那么这样做是可以的。这种情况最好只在段落开头使用。）

句子片段形式的注释对标点符号或大写没有这样的要求。

[文档注释] 应始终是完整句子，因此应始终大写并标点。简单的行尾注释（特别是对于结构体字段）可以是简单的短语，假设字段名称是主语。

```go
// 好：
// Server 处理从莎士比亚作品集中提供引用的服务。
type Server struct {
    // BaseDir 指向存储莎士比亚作品的基础目录。
    //
    // 预期的目录结构如下：
    //   {BaseDir}/manifest.json
    //   {BaseDir}/{name}/{name}-part{number}.txt
    BaseDir string

    WelcomeMessage  string // 用户登录时显示
    ProtocolVersion string // 与传入请求进行检查
    PageLength      int    // 打印时每页的行数（可选；默认值：20）
}
```

[文档注释]: #doc-comments

<a id="examples"></a>

### 示例

<a id="TOC-Examples"></a>

包应清楚地记录其预期用法。尽量提供一个[可运行的示例]；示例会在 Godoc 中显示。可运行的示例应放在测试文件中，而不是生产源文件中。参见此示例（[Godoc]，[源码]）。

[可运行的示例]: http://blog.golang.org/examples
[Godoc]: https://pkg.go.dev/time#example-Duration
[源码]: https://cs.opensource.google/go/go/+/HEAD:src/time/example_test.go

如果无法提供可运行的示例，可以在代码注释中提供示例代码。与注释中的其他代码和命令行片段一样，它应遵循标准格式约定。

<a id="named-result-parameters"></a>

### 命名结果参数

<a id="TOC-NamedResultParameters"></a>

在命名参数时，要考虑函数签名在 Godoc 中的显示方式。函数本身的名称和结果参数的类型通常已经足够清晰。

```go
// 好：
func (n *Node) Parent1() *Node
func (n *Node) Parent2() (*Node, error)
```

如果一个函数返回两个或更多相同类型的参数，添加名称可能会有帮助。

```go
// 好：
func (n *Node) Children() (left, right *Node, err error)
```

如果调用者必须对特定的结果参数采取行动，命名它们可以帮助提示该行动是什么：

```go
// 好：
// WithTimeout 返回一个上下文，该上下文将在从现在起不迟于 d 持续时间内被取消。
//
// 调用者必须在不再需要上下文时安排调用返回的取消函数，以防止资源泄漏。
func WithTimeout(parent Context, d time.Duration) (ctx Context, cancel func())
```

在上面的代码中，取消是一个调用者必须采取的特定行动。然而，如果结果参数仅写成 `(Context, func())`，那么“取消函数”的含义将不清楚。

当名称导致[不必要的重复](#repetitive-with-type)时，不要使用命名结果参数。

```go
// 坏：
func (n *Node) Parent1() (node *Node)
func (n *Node) Parent2() (node *Node, err error)
```

不要为了避免在函数内部声明变量而命名结果参数。这种做法会导致 API 不必要的冗长，而代价只是实现上略微简洁。

[裸返回] 只在小函数中是可以接受的。一旦是中等大小的函数，就要明确返回值。同样，不要仅仅因为它允许你使用裸返回而命名结果参数。[清晰度](guide#clarity)始终比在函数中节省几行代码更重要。

如果结果参数的值必须在延迟闭包中更改，命名结果参数始终是可以接受的。

> **提示：** 在函数签名中，类型通常比名称更清晰。[GoTip #38: 函数作为命名类型] 演示了这一点。
>
> 在上面的 [`WithTimeout`] 中，实际代码使用了 [`CancelFunc`] 而不是结果参数列表中的原始 `func()`，并且几乎不需要努力就能进行文档化。

[裸返回]: https://tour.golang.org/basics/7
[GoTip #38: 函数作为命名类型]: https://jqknono.github.io/styleguide/go/index.html#gotip
[`WithTimeout`]: https://pkg.go.dev/context#WithTimeout
[`CancelFunc`]: https://pkg.go.dev/context#CancelFunc

<a id="package-comments"></a>
### 包注释

<a id="TOC-PackageComments"></a>

包注释必须紧接在包声明之前，且注释与包名之间没有空行。示例：

```go
// 良好：
// 包 math 提供了基本常量和数学函数。
//
// 此包不保证跨架构的位相同结果。
package math
```

每个包只能有一个包注释。如果一个包由多个文件组成，则其中一个文件应包含包注释。

`main` 包的注释形式略有不同，`go_binary` 规则在 BUILD 文件中的名称将代替包名。

```go
// 良好：
// seed_generator 命令是一个从一组 JSON 研究配置生成 Finch 种子文件的工具。
package main
```

只要二进制文件的名称与 BUILD 文件中所写的完全一致，其他风格的注释也是可以的。当二进制名称是第一个词时，即使它与命令行调用的拼写不完全匹配，也必须大写。

```go
// 良好：
// 二进制文件 seed_generator ...
// 命令 seed_generator ...
// 程序 seed_generator ...
// seed_generator 命令 ...
// seed_generator 程序 ...
// Seed_generator ...
```

提示：

*   示例命令行调用和 API 使用情况可以作为有用的文档。对于 Godoc 格式化，缩进包含代码的注释行。

*   如果没有明显的主要文件，或者包注释异常长，可以将文档注释放在名为 `doc.go` 的文件中，该文件仅包含注释和包声明。

*   可以使用多行注释代替多个单行注释。这主要在文档包含可能从源文件复制和粘贴的部分时有用，例如二进制文件的示例命令行和模板示例。

    ```go
    // 良好：
    /*
    seed_generator 命令是一个从一组 JSON 研究配置生成 Finch 种子文件的工具。

        seed_generator *.json | base64 > finch-seed.base64
    */
    package template
    ```

*   针对维护者的注释，如果适用于整个文件，通常放在导入声明之后。这些注释不会在 Godoc 中显示，并且不受上述包注释规则的约束。

<a id="imports"></a>

## 导入

<a id="TOC-Imports"></a>

<a id="import-renaming"></a>

### 导入重命名

只有在导入名称与其他导入发生冲突时，才应重命名导入。（由此推论，[良好的包名](#package-names)不应需要重命名。）在名称冲突的情况下，优先重命名最本地或项目特定的导入。包的本地名称（别名）必须遵循[关于包命名的指导](#package-names)，包括禁止使用下划线和大写字母。

生成的协议缓冲区包必须重命名以去除名称中的下划线，并且它们的别名必须带有 `pb` 后缀。有关更多信息，请参见[proto 和存根最佳实践]。

[proto 和存根最佳实践]: best-practices#import-protos

```go
// 良好：
import (
    fspb "path/to/package/foo_service_go_proto"
)
```

对于包名没有有用识别信息的导入（例如 `package v1`），应重命名以包含前一个路径组件。重命名必须与导入同一包的其他本地文件一致，并且可以包括版本号。

**注意：** 优先将包重命名为符合[良好的包名](#package-names)，但对于供应商目录中的包，这通常不可行。

```go
// 良好：
import (
    core "github.com/kubernetes/api/core/v1"
    meta "github.com/kubernetes/apimachinery/pkg/apis/meta/v1beta1"
)
```

如果您需要导入一个包，其名称与您想要使用的常见本地变量名称（例如 `url`，`ssh`）发生冲突，并且您希望重命名该包，首选的方式是使用 `pkg` 后缀（例如 `urlpkg`）。请注意，可以用本地变量遮蔽包；只有在这样的变量在作用域内时仍需要使用该包时，才需要进行此重命名。

<a id="import-grouping"></a>
### 导入分组

导入应按以下两组组织：

*   标准库包

*   其他（项目和供应商）包

```go
// 良好：
package main

import (
    "fmt"
    "hash/adler32"
    "os"

    "github.com/dsnet/compress/flate"
    "golang.org/x/text/encoding"
    "google.golang.org/protobuf/proto"
    foopb "myproj/foo/proto/proto"
    _ "myproj/rpc/protocols/dial"
    _ "myproj/security/auth/authhooks"
)
```

如果您希望将项目包分成多个组是可以接受的，只要这些组具有某种意义。常见的理由包括：

*   重命名的导入
*   为了其副作用而导入的包

示例：

```go
// 良好：
package main

import (
    "fmt"
    "hash/adler32"
    "os"


    "github.com/dsnet/compress/flate"
    "golang.org/x/text/encoding"
    "google.golang.org/protobuf/proto"

    foopb "myproj/foo/proto/proto"

    _ "myproj/rpc/protocols/dial"
    _ "myproj/security/auth/authhooks"
)
```

**注意：** 维护可选组 - 超出标准库和Google导入之间强制分离所需的分组 - 不被[goimports]工具支持。额外的导入子组需要作者和审阅者共同注意，以保持一致的状态。

[goimports]: golang.org/x/tools/cmd/goimports

同时是AppEngine应用的Google程序应为AppEngine导入设置单独的组。

Gofmt负责按导入路径对每个组进行排序。然而，它不会自动将导入分成组。流行的[goimports]工具结合了Gofmt和导入管理，根据上述决策将导入分组。它允许完全由[goimports]管理导入排列，但在文件修订时，其导入列表必须保持内部一致。

<a id="import-blank"></a>

### 导入“空白”（`import _`）

<a id="TOC-ImportBlank"></a>

仅为了其副作用而导入的包（使用语法`import _ "package"`）只能在主包中导入，或者在需要它们的测试中导入。

此类包的一些示例包括：

*   [time/tzdata](https://pkg.go.dev/time/tzdata)

*   在图像处理代码中的[image/jpeg](https://pkg.go.dev/image/jpeg)

避免在库包中使用空白导入，即使库间接依赖它们。将副作用导入限制在主包中有助于控制依赖关系，并使编写依赖不同导入的测试成为可能，而不会发生冲突或浪费构建成本。

以下是此规则的唯一例外：

*   您可以使用空白导入来绕过[nogo静态检查器]中禁止导入的检查。

*   在使用`//go:embed`编译器指令的源文件中，您可以使用[embed](https://pkg.go.dev/embed)包的空白导入。

**提示：** 如果您创建了一个在生产中间接依赖副作用导入的库包，请记录预期的使用方式。

[nogo静态检查器]: https://github.com/bazelbuild/rules_go/blob/master/go/nogo.rst

<a id="import-dot"></a>

### 导入“点”（`import .`）

<a id="TOC-ImportDot"></a>

`import .`形式是一种语言特性，允许将从另一个包导出的标识符引入当前包而无需限定。有关更多信息，请参阅[语言规范](https://go.dev/ref/spec#Import_declarations)。

在Google代码库中**不要**使用此功能；它使得难以判断功能来自何处。

```go
// 不好：
package foo_test

import (
    "bar/testutil" // 还导入了 "foo"
    . "foo"
)

var myThing = Bar() // Bar 在包 foo 中定义；无需限定。
```

```go
// 良好：
package foo_test

import (
    "bar/testutil" // 还导入了 "foo"
    "foo"
)

var myThing = foo.Bar()
```

<a id="errors"></a>

## 错误

<a id="returning-errors"></a>
### 返回错误

<a id="TOC-ReturningErrors"></a>

使用 `error` 来表示一个函数可能会失败。按照惯例，`error` 是最后一个结果参数。

```go
// 好：
func Good() error { /* ... */ }
```

返回 `nil` 错误是表示一个可能失败的操作成功的惯用方法。如果一个函数返回错误，调用者必须将所有非错误返回值视为未指定的，除非另有明确说明。通常，非错误返回值是它们的零值，但不能假设这一点。

```go
// 好：
func GoodLookup() (*Result, error) {
    // ...
    if err != nil {
        return nil, err
    }
    return res, nil
}
```

返回错误的导出函数应使用 `error` 类型返回它们。具体错误类型容易出现细微的错误：一个具体的 `nil` 指针可能会被包装成一个接口，从而变成一个非 `nil` 值（参见 [Go FAQ 关于此主题的条目][nil error]）。

```go
// 坏：
func Bad() *os.PathError { /*...*/ }
```

**提示**：接受 `context.Context` 参数的函数通常应返回一个 `error`，以便调用者可以确定函数运行时上下文是否被取消。

[nil error]: https://golang.org/doc/faq#nil_error

<a id="error-strings"></a>

### 错误字符串

<a id="TOC-ErrorStrings"></a>

错误字符串不应大写（除非以导出名称、专有名词或首字母缩写词开头），也不应以标点符号结尾。这是因为错误字符串通常在打印给用户之前出现在其他上下文中。

```go
// 坏：
err := fmt.Errorf("Something bad happened.")
```

```go
// 好：
err := fmt.Errorf("something bad happened")
```

另一方面，完整显示消息的样式（日志、测试失败、API 响应或其他用户界面）取决于具体情况，但通常应大写。

```go
// 好：
log.Infof("Operation aborted: %v", err)
log.Errorf("Operation aborted: %v", err)
t.Errorf("Op(%q) failed unexpectedly; err=%v", args, err)
```

<a id="handle-errors"></a>

### 处理错误

<a id="TOC-HandleErrors"></a>

遇到错误的代码应有意选择如何处理它。通常不应使用 `_` 变量丢弃错误。如果一个函数返回错误，请执行以下操作之一：

*   立即处理并解决错误。
*   将错误返回给调用者。
*   在特殊情况下，调用 [`log.Fatal`] 或（如果绝对必要）`panic`。

**注意：** `log.Fatalf` 不是标准库日志。参见 [#logging]。

在极少数情况下，忽略或丢弃错误是合适的（例如对 [`(*bytes.Buffer).Write`] 的调用，该调用被记录为永远不会失败），应附带注释解释为什么这样做是安全的。

```go
// 好：
var b *bytes.Buffer

n, _ := b.Write(p) // 永远不会返回非 nil 错误
```

有关错误处理的更多讨论和示例，请参见 [Effective Go](http://golang.org/doc/effective_go.html#errors) 和 [最佳实践](best-practices.md#error-handling)。

[`(*bytes.Buffer).Write`]: https://pkg.go.dev/bytes#Buffer.Write

<a id="in-band-errors"></a>
### 带内错误

<a id="TOC-In-Band-Errors"></a>

在C语言及类似语言中，函数返回-1、null或空字符串来表示错误或缺少结果的情况很常见。这被称为带内错误处理。

```go
// 不好：
// Lookup返回key的值，如果key没有映射则返回-1。
func Lookup(key string) int
```

如果没有检查带内错误值，可能会导致错误并将错误归咎于错误的函数。

```go
// 不好：
// 以下代码返回Parse对输入值失败的错误，
// 但实际上是由于missingKey没有映射而失败。
return Parse(Lookup(missingKey))
```

Go语言支持多返回值提供了一种更好的解决方案（参见[Effective Go关于多返回值的部分]）。函数不应要求客户端检查带内错误值，而应返回一个额外的值来指示其它返回值是否有效。这个返回值可以是错误或在不需要解释时使用布尔值，并且应为最后一个返回值。

```go
// 好：
// Lookup返回key的值，如果key没有映射则ok=false。
func Lookup(key string) (value string, ok bool)
```

这种API可以防止调用者错误地编写`Parse(Lookup(key))`，因为`Lookup(key)`有两个输出，这会导致编译时错误。

以这种方式返回错误可以鼓励更健壮和明确的错误处理：

```go
// 好：
value, ok := Lookup(key)
if !ok {
    return fmt.Errorf("没有值为%q", key)
}
return Parse(value)
```

标准库中的一些函数，如`strings`包中的函数，返回带内错误值。这大大简化了字符串操作代码，但需要程序员更加勤勉。一般来说，Google代码库中的Go代码应为错误返回额外的值。

[Effective Go关于多返回值的部分]: http://golang.org/doc/effective_go.html#multiple-returns

<a id="indent-error-flow"></a>

### 缩进错误流

<a id="TOC-IndentErrorFlow"></a>

在继续执行代码的其余部分之前处理错误。这通过让读者快速找到正常路径来提高代码的可读性。同样的逻辑适用于任何测试条件然后以终止条件（例如`return`、`panic`、`log.Fatal`）结束的块。

如果未满足终止条件，运行的代码应出现在`if`块之后，并且不应在`else`子句中缩进。

```go
// 好：
if err != nil {
    // 错误处理
    return // 或continue等
}
// 正常代码
```

```go
// 不好：
if err != nil {
    // 错误处理
} else {
    // 由于缩进看起来不正常的正常代码
}
```

> **提示：** 如果你使用一个变量超过几行代码，一般不值得使用带初始化的`if`风格。在这些情况下，通常最好将声明移出并使用标准的`if`语句：
>
> ```go
> // 好：
> x, err := f()
> if err != nil {
>   // 错误处理
>   return
> }
> // 使用x的多行代码
> ```
>
> ```go
> // 不好：
> if x, err := f(); err != nil {
>   // 错误处理
>   return
> } else {
>   // 使用x的多行代码
> }
> ```

有关更多详细信息，请参见[Go提示#1：视线]和[TotT：通过减少嵌套来降低代码复杂性](https://testing.googleblog.com/2017/06/code-health-reduce-nesting-reduce.html)。

[Go提示#1：视线]: https://jqknono.github.io/styleguide/go/index.html#gotip

<a id="language"></a>

## 语言

<a id="literal-formatting"></a>
### 字面量格式化

Go 语言拥有一个异常强大的[复合字面量语法]，通过这种语法，可以在一个表达式中表达深层嵌套的复杂值。在可能的情况下，应该使用这种字面量语法来代替逐字段构建值。`gofmt` 对字面量的格式化通常相当不错，但为了保持这些字面量的可读性和可维护性，还有一些额外的规则。

[复合字面量语法]: https://golang.org/ref/spec#Composite_literals

<a id="literal-field-names"></a>

#### 字段名称

对于在当前包之外定义的类型，结构体字面量必须指定**字段名称**。

*   包含来自其他包的类型的字段名称。

    ```go
    // 好：
    // https://pkg.go.dev/encoding/csv#Reader
    r := csv.Reader{
      Comma: ',',
      Comment: '#',
      FieldsPerRecord: 4,
    }
    ```

    结构体中字段的位置和完整的字段集（这两者在省略字段名称时都需要正确）通常不被认为是结构体公共 API 的一部分；指定字段名称是为了避免不必要的耦合。

    ```go
    // 坏：
    r := csv.Reader{',', '#', 4, false, false, false, false}
    ```

*   对于包内定义的类型，字段名称是可选的。

    ```go
    // 好：
    okay := Type{42}
    also := internalType{4, 2}
    ```

    如果这样做能使代码更清晰，仍然应该使用字段名称，这也是非常常见的做法。例如，对于具有大量字段的结构体，几乎总是应该使用字段名称进行初始化。

    <!-- TODO: 这里可能需要一个更好的例子，不需要很多字段。 -->

    ```go
    // 好：
    okay := StructWithLotsOfFields{
      field1: 1,
      field2: "two",
      field3: 3.14,
      field4: true,
    }
    ```

<a id="literal-matching-braces"></a>

#### 匹配的大括号

大括号对的关闭部分应该始终出现在与打开大括号相同缩进的行上。一行字面量必然具有此属性。当字面量跨越多行时，保持此属性可以使字面量的大括号匹配与函数和 `if` 语句等常见的 Go 语法结构的大括号匹配保持一致。

在这一领域最常见的错误是将关闭大括号放在多行结构体字面量中的一个值的同一行上。在这些情况下，线应以逗号结束，关闭大括号应出现在下一行。

```go
// 好：
good := []*Type{{Key: "value"}}
```

```go
// 好：
good := []*Type{
    {Key: "multi"},
    {Key: "line"},
}
```

```go
// 坏：
bad := []*Type{
    {Key: "multi"},
    {Key: "line"}}
```

```go
// 坏：
bad := []*Type{
    {
        Key: "value"},
}
```

<a id="literal-cuddled-braces"></a>

#### 紧挨的大括号

对于切片和数组字面量，只有在以下两个条件都满足时，才允许在大括号之间省略空格（即“紧挨”它们）。

*   [缩进匹配](#literal-matching-braces)
*   内部值也是字面量或 proto 构建器（即不是变量或其他表达式）

```go
// 好：
good := []*Type{
    { // 不紧挨
        Field: "value",
    },
    {
        Field: "value",
    },
}
```

```go
// 好：
good := []*Type{{ // 正确地紧挨
    Field: "value",
}, {
    Field: "value",
}}
```

```go
// 好：
good := []*Type{
    first, // 不能紧挨
    {Field: "second"},
}
```

```go
// 好：
okay := []*pb.Type{pb.Type_builder{
    Field: "first", // Proto 构建器可以紧挨以节省垂直空间
}.Build(), pb.Type_builder{
    Field: "second",
}.Build()}
```

```go
// 坏：
bad := []*Type{
    first,
    {
        Field: "second",
    }}
```

<a id="literal-repeated-type-names"></a>

#### 重复的类型名称

在切片和映射字面量中可以省略重复的类型名称。这有助于减少混乱。重复类型名称的合理场合是处理项目中不常见的复杂类型时，或者当重复的类型名称位于相距较远的行上时，可以提醒读者上下文。

```go
// 好：
good := []*Type{
    {A: 42},
    {A: 43},
}
```

```go
// 坏：
repetitive := []*Type{
    &Type{A: 42},
    &Type{A: 43},
}
```

```go
// 好：
good := map[Type1]*Type2{
    {A: 1}: {B: 2},
    {A: 3}: {B: 4},
}
```

```go
// 坏：
```go
repetitive := map[Type1]*Type2{
    Type1{A: 1}: &Type2{B: 2},
    Type1{A: 3}: &Type2{B: 4},
}
```

**提示：** 如果你想在结构体字面量中去除重复的类型名称，可以运行 `gofmt -s`。

<a id="literal-zero-value-fields"></a>

#### 零值字段

当不会因此失去清晰度时，可以从结构体字面量中省略零值字段。

设计良好的API通常会使用零值构造来增强可读性。例如，从下面的结构体中省略三个零值字段，可以突出唯一被指定的选项。

[零值]: https://golang.org/ref/spec#The_zero_value

```go
// 不好：
import (
  "github.com/golang/leveldb"
  "github.com/golang/leveldb/db"
)

ldb := leveldb.Open("/my/table", &db.Options{
    BlockSize: 1<<16,
    ErrorIfDBExists: true,

    // 这些字段都是它们的零值。
    BlockRestartInterval: 0,
    Comparer: nil,
    Compression: nil,
    FileSystem: nil,
    FilterPolicy: nil,
    MaxOpenFiles: 0,
    WriteBufferSize: 0,
    VerifyChecksums: false,
})
```

```go
// 好：
import (
  "github.com/golang/leveldb"
  "github.com/golang/leveldb/db"
)

ldb := leveldb.Open("/my/table", &db.Options{
    BlockSize: 1<<16,
    ErrorIfDBExists: true,
})
```

表驱动测试中的结构体通常会从[显式字段名称]中受益，特别是当测试结构体不简单时。这允许作者在所讨论的字段与测试用例无关时完全省略零值字段。例如，成功的测试用例应该省略任何与错误或失败相关的字段。在需要零值来理解测试用例的情况下，例如测试零值或 `nil` 输入时，应指定字段名称。

[显式字段名称]: #literal-field-names

**简洁**

```go
tests := []struct {
    input      string
    wantPieces []string
    wantErr    error
}{
    {
        input:      "1.2.3.4",
        wantPieces: []string{"1", "2", "3", "4"},
    },
    {
        input:   "hostname",
        wantErr: ErrBadHostname,
    },
}
```

**显式**

```go
tests := []struct {
    input    string
    wantIPv4 bool
    wantIPv6 bool
    wantErr  bool
}{
    {
        input:    "1.2.3.4",
        wantIPv4: true,
        wantIPv6: false,
    },
    {
        input:    "1:2::3:4",
        wantIPv4: false,
        wantIPv6: true,
    },
    {
        input:    "hostname",
        wantIPv4: false,
        wantIPv6: false,
        wantErr:  true,
    },
}
```

<a id="nil-slices"></a>
### 空切片

对于大多数用途，`nil` 和空切片在功能上没有区别。内置函数如 `len` 和 `cap` 在 `nil` 切片上的行为符合预期。

```go
// 正确：
import "fmt"

var s []int         // nil

fmt.Println(s)      // []
fmt.Println(len(s)) // 0
fmt.Println(cap(s)) // 0
for range s {...}   // 无操作

s = append(s, 42)
fmt.Println(s)      // [42]
```

如果您声明一个空切片作为局部变量（特别是如果它可能是返回值的来源），建议使用 `nil` 初始化，以减少调用者出错的风险。

```go
// 正确：
var t []string
```

```go
// 错误：
t := []string{}
```

不要创建需要客户端区分 `nil` 和空切片的 API。

```go
// 正确：
// Ping 向其目标发送 ping。
// 返回成功响应的主机。
func Ping(hosts []string) ([]string, error) { ... }
```

```go
// 错误：
// Ping 向其目标发送 ping 并返回成功响应的主机列表。
// 如果输入为空，则可能为空。
// nil 表示发生了系统错误。
func Ping(hosts []string) []string { ... }
```

在设计接口时，避免区分 `nil` 切片和非 `nil` 的零长度切片，因为这可能导致细微的编程错误。通常通过使用 `len` 来检查是否为空，而不是 `== nil` 来实现这一点。

此实现接受 `nil` 和零长度切片作为“空”：

```go
// 正确：
// describeInts 使用给定的前缀描述 s，除非 s 为空。
func describeInts(prefix string, s []int) {
    if len(s) == 0 {
        return
    }
    fmt.Println(prefix, s)
}
```

而不是依赖于作为 API 的一部分的这种区分：

```go
// 错误：
func maybeInts() []int { /* ... */ }

// describeInts 使用给定的前缀描述 s；传递 nil 以完全跳过。
func describeInts(prefix string, s []int) {
  // 此函数的行为会根据 maybeInts() 在“空”情况下的返回值（nil 或 []int{}）而意外改变。
  if s == nil {
    return
  }
  fmt.Println(prefix, s)
}

describeInts("Here are some ints:", maybeInts())
```

有关进一步讨论，请参见[带内错误](#in-band-errors)。

### 缩进混淆

如果引入换行会使剩余的行与缩进的代码块对齐，请避免引入换行。如果这是不可避免的，请留一个空格以将块中的代码与换行的行分开。

```go
// 错误：
if longCondition1 && longCondition2 &&
    // 条件 3 和 4 与 if 内的代码具有相同的缩进。
    longCondition3 && longCondition4 {
    log.Info("all conditions met")
}
```

有关具体指南和示例，请参见以下部分：

*   [函数格式化](#func-formatting)
*   [条件和循环](#conditional-formatting)
*   [字面量格式化](#literal-formatting)
### 函数格式化

函数或方法声明的签名应保持在单行上，以避免[缩进混淆](#indentation-confusion)。

函数参数列表可能会使Go源文件中的一些行变得很长。然而，它们在缩进变化之前，因此很难以一种不会使后续行看起来像是函数体的一部分的方式来断行，这会造成混淆：

```go
// 错误：
func (r *SomeType) SomeLongFunctionName(foo1, foo2, foo3 string,
    foo4, foo5, foo6 int) {
    foo7 := bar(foo1)
    // ...
}
```

请参阅[最佳实践](best-practices#funcargs)，了解一些缩短原本会有许多参数的函数调用位置的选项。

通常可以通过提取局部变量来缩短行长度。

```go
// 正确：
local := helper(some, parameters, here)
good := foo.Call(list, of, parameters, local)
```

同样，函数和方法调用不应仅基于行长度来分隔。

```go
// 正确：
good := foo.Call(long, list, of, parameters, all, on, one, line)
```

```go
// 错误：
bad := foo.Call(long, list, of, parameters,
    with, arbitrary, line, breaks)
```

尽可能避免为特定的函数参数添加内联注释。相反，应使用[选项结构](best-practices#option-structure)或在函数文档中添加更多细节。

```go
// 正确：
good := server.New(ctx, server.Options{Port: 42})
```

```go
// 错误：
bad := server.New(
    ctx,
    42, // Port
)
```

如果API无法更改，或者如果本地调用不常见（无论调用是否过长），只要有助于理解调用，总是可以添加换行。

```go
// 正确：
canvas.RenderCube(cube,
    x0, y0, z0,
    x0, y0, z1,
    x0, y1, z0,
    x0, y1, z1,
    x1, y0, z0,
    x1, y0, z1,
    x1, y1, z0,
    x1, y1, z1,
)
```

请注意，上述示例中的行不是在特定列边界处换行，而是基于坐标三元组分组。

函数内的长字符串字面量不应为了行长度而断行。对于包含此类字符串的函数，可以在字符串格式后添加换行符，并在下一行或后续行提供参数。关于换行符应放在何处的决定，最好基于输入的语义分组，而不是纯粹基于行长度。

```go
// 正确：
log.Warningf("Database key (%q, %d, %q) incompatible in transaction started by (%q, %d, %q)",
    currentCustomer, currentOffset, currentKey,
    txCustomer, txOffset, txKey)
```

```go
// 错误：
log.Warningf("Database key (%q, %d, %q) incompatible in"+
    " transaction started by (%q, %d, %q)",
    currentCustomer, currentOffset, currentKey, txCustomer,
    txOffset, txKey)
```

<a id="conditional-formatting"></a>
### 条件语句和循环

`if` 语句不应换行；多行的 `if` 子句可能会导致[缩进混淆](#indentation-confusion)。

```go
// 错误：
// 第二个 if 语句与 if 块内的代码对齐，导致缩进混淆。
if db.CurrentStatusIs(db.InTransaction) &&
    db.ValuesEqual(db.TransactionKey(), row.Key()) {
    return db.Errorf(db.TransactionError, "查询失败：行 (%v)：键与事务键不匹配", row)
}
```

如果不需要短路行为，可以直接提取布尔操作数：

```go
// 正确：
inTransaction := db.CurrentStatusIs(db.InTransaction)
keysMatch := db.ValuesEqual(db.TransactionKey(), row.Key())
if inTransaction && keysMatch {
    return db.Error(db.TransactionError, "查询失败：行 (%v)：键与事务键不匹配", row)
}
```

还可能有其他可以提取的局部变量，特别是如果条件语句已经重复：

```go
// 正确：
uid := user.GetUniqueUserID()
if db.UserIsAdmin(uid) || db.UserHasPermission(uid, perms.ViewServerConfig) || db.UserHasPermission(uid, perms.CreateGroup) {
    // ...
}
```

```go
// 错误：
if db.UserIsAdmin(user.GetUniqueUserID()) || db.UserHasPermission(user.GetUniqueUserID(), perms.ViewServerConfig) || db.UserHasPermission(user.GetUniqueUserID(), perms.CreateGroup) {
    // ...
}
```

包含闭包或多行结构体字面量的 `if` 语句应确保[大括号匹配](#literal-matching-braces)，以避免[缩进混淆](#indentation-confusion)。

```go
// 正确：
if err := db.RunInTransaction(func(tx *db.TX) error {
    return tx.Execute(userUpdate, x, y, z)
}); err != nil {
    return fmt.Errorf("用户更新失败：%s", err)
}
```

```go
// 正确：
if _, err := client.Update(ctx, &upb.UserUpdateRequest{
    ID:   userID,
    User: user,
}); err != nil {
    return fmt.Errorf("用户更新失败：%s", err)
}
```

同样，不要尝试在 `for` 语句中插入人为的换行。如果没有优雅的重构方法，可以让行保持较长：

```go
// 正确：
for i, max := 0, collection.Size(); i < max && !collection.HasPendingWriters(); i++ {
    // ...
}
```

通常情况下，还是有办法的：

```go
// 正确：
for i, max := 0, collection.Size(); i < max; i++ {
    if collection.HasPendingWriters() {
        break
    }
    // ...
}
```

`switch` 和 `case` 语句也应保持在单行上。

```go
// 正确：
switch good := db.TransactionStatus(); good {
case db.TransactionStarting, db.TransactionActive, db.TransactionWaiting:
    // ...
case db.TransactionCommitted, db.NoTransaction:
    // ...
default:
    // ...
}
```

```go
// 错误：
switch bad := db.TransactionStatus(); bad {
case db.TransactionStarting,
    db.TransactionActive,
    db.TransactionWaiting:
    // ...
case db.TransactionCommitted,
    db.NoTransaction:
    // ...
default:
    // ...
}
```

如果行过长，应缩进所有 case，并用空行分隔，以避免[缩进混淆](#indentation-confusion)：

```go
// 正确：
switch db.TransactionStatus() {
case
    db.TransactionStarting,
    db.TransactionActive,
    db.TransactionWaiting,
    db.TransactionCommitted:

    // ...
case db.NoTransaction:
    // ...
default:
    // ...
}
```

在条件语句中比较变量和常量时，应将变量值放在等号运算符的左侧：

```go
// 正确：
if result == "foo" {
  // ...
}
```

而不是较不清晰的表达方式，即常量在前（["尤达式条件"](https://en.wikipedia.org/wiki/Yoda_conditions)）：

```go
// 错误：
if "foo" == result {
  // ...
}
```

<a id="copying"></a>
### 复制

<a id="TOC-Copying"></a>

为了避免意外的别名和类似的错误，在从另一个包复制结构体时要小心。例如，同步对象如 `sync.Mutex` 不能被复制。

`bytes.Buffer` 类型包含一个 `[]byte` 切片，并且作为小字符串的优化，它可能引用一个小的字节数组。如果你复制了一个 `Buffer`，复制中的切片可能与原始中的数组别名，导致后续方法调用产生意外的效果。

一般来说，如果类型 `T` 的方法与指针类型 `*T` 相关联，则不要复制类型 `T` 的值。

```go
// 错误：
b1 := bytes.Buffer{}
b2 := b1
```

调用接收值的方法可能会隐藏复制。当你编写 API 时，如果你的结构体包含不应被复制的字段，你通常应该接收和返回指针类型。

这些是可以接受的：

```go
// 正确：
type Record struct {
  buf bytes.Buffer
  // 其他字段省略
}

func New() *Record {...}

func (r *Record) Process(...) {...}

func Consumer(r *Record) {...}
```

但这些通常是错误的：

```go
// 错误：
type Record struct {
  buf bytes.Buffer
  // 其他字段省略
}

func (r Record) Process(...) {...} // 复制了 r.buf

func Consumer(r Record) {...} // 复制了 r.buf
```

这些指导原则也适用于复制 `sync.Mutex`。

<a id="dont-panic"></a>

### 不要恐慌

<a id="TOC-Don-t-Panic"></a>

不要在正常的错误处理中使用 `panic`。相反，使用 `error` 和多个返回值。参见 [Effective Go 关于错误的部分]。

在 `package main` 和初始化代码中，对于应该终止程序的错误（例如，无效配置），可以考虑使用 [`log.Exit`，因为在许多情况下，堆栈跟踪对读者没有帮助。请注意，[`log.Exit`] 会调用 [`os.Exit`，任何延迟函数都不会被执行。

对于表示“不可能”条件的错误，即在代码审查和/或测试期间应始终被捕获的错误，一个函数可以合理地返回一个错误或调用 [`log.Fatal`]。

另见 [何时可以接受恐慌](best-practices.md#when-to-panic)。

**注意：** `log.Fatalf` 不是标准库日志。参见 [#logging]。

[Effective Go 关于错误的部分]: http://golang.org/doc/effective_go.html#errors
[`os.Exit`]: https://pkg.go.dev/os#Exit

<a id="must-functions"></a>
### 必须函数

设置在失败时停止程序的辅助函数应遵循命名约定 `MustXYZ`（或 `mustXYZ`）。一般来说，它们应该只在程序启动的早期调用，而不是在用户输入等需要使用常规 Go 错误处理的地方调用。

这种情况通常出现在仅在[包初始化时](https://golang.org/ref/spec#Package_initialization)调用的函数，用于初始化包级变量（例如 [template.Must](https://golang.org/pkg/text/template/#Must) 和 [regexp.MustCompile](https://golang.org/pkg/regexp/#MustCompile)）。

```go
// 良好：
func MustParse(version string) *Version {
    v, err := Parse(version)
    if err != nil {
        panic(fmt.Sprintf("MustParse(%q) = _, %v", version, err))
    }
    return v
}

// 包级“常量”。如果我们想使用 `Parse`，我们将不得不将值设置在 `init` 中。
var DefaultVersion = MustParse("1.2.3")
```

相同的约定也可用于测试辅助函数，这些函数只会停止当前测试（使用 `t.Fatal`）。这种辅助函数在创建测试值时通常很方便，例如在[表驱动测试](#table-driven-tests)的结构字段中，因为返回错误的函数不能直接赋值给结构字段。

```go
// 良好：
func mustMarshalAny(t *testing.T, m proto.Message) *anypb.Any {
  t.Helper()
  any, err := anypb.New(m)
  if err != nil {
    t.Fatalf("mustMarshalAny(t, m) = %v; want %v", err, nil)
  }
  return any
}

func TestCreateObject(t *testing.T) {
  tests := []struct{
    desc string
    data *anypb.Any
  }{
    {
      desc: "我的测试用例",
      // 直接在表驱动测试用例中创建值。
      data: mustMarshalAny(t, mypb.Object{}),
    },
    // ...
  }
  // ...
}
```

在这两种情况下，这种模式的价值在于辅助函数可以在“值”上下文中调用。这些辅助函数不应在难以确保错误会被捕获的地方调用，或者在应该[检查](#handle-errors)错误的上下文中调用（例如，在许多请求处理程序中）。对于常量输入，这允许测试轻松确保 `Must` 参数是格式良好的，对于非常量输入，它允许测试验证错误是否被[正确处理或传播](best-practices#error-handling)。

在测试中使用 `Must` 函数时，它们通常应被[标记为测试辅助函数](#mark-test-helpers)，并在错误时调用 `t.Fatal`（有关使用此方法的更多考虑，请参阅[测试辅助函数中的错误处理](best-practices#test-helper-error-handling)）。

当[普通错误处理](best-practices#error-handling)是可能的（包括通过一些重构）时，不应使用它们：

```go
// 不好：
func Version(o *servicepb.Object) (*version.Version, error) {
    // 返回错误而不是使用 Must 函数。
    v := version.MustParse(o.GetVersionString())
    return dealiasVersion(v)
}
```

<a id="goroutine-lifetimes"></a>
### Goroutine生命周期

<a id="TOC-GoroutineLifetimes"></a>

当你启动goroutine时，要明确它们何时或是否会退出。

goroutine可能会因为在通道发送或接收上阻塞而泄漏。即使没有其他goroutine引用该通道，垃圾回收器也不会终止一个在通道上阻塞的goroutine。

即使goroutine不会泄漏，在不再需要它们时让它们继续运行可能会导致其他难以诊断的细微问题。在已关闭的通道上发送会导致panic。

```go
// 不好：
ch := make(chan int)
ch <- 42
close(ch)
ch <- 13 // panic
```

在“结果不再需要”之后修改仍在使用的输入可能会导致数据竞争。让goroutine无限期地运行可能会导致不可预测的内存使用。

并发代码的编写应使goroutine的生命周期显而易见。通常，这意味着将与同步相关的代码限制在函数范围内，并将逻辑提取到[同步函数]中。如果并发性仍然不明显，重要的是要记录goroutine何时以及为何退出。

遵循上下文使用最佳实践的代码通常有助于明确这一点。通常使用`context.Context`来管理：

```go
// 好：
func (w *Worker) Run(ctx context.Context) error {
    var wg sync.WaitGroup
    // ...
    for item := range w.q {
        // process在上下文取消时最迟返回。
        wg.Add(1)
        go func() {
            defer wg.Done()
            process(ctx, item)
        }()
    }
    // ...
    wg.Wait()  // 防止生成的goroutine比此函数活得更久。
}
```

上述还有其他变体，使用原始信号通道如`chan struct{}`、同步变量、[条件变量][rethinking-slides]等。重要的是，goroutine的结束对后续维护者来说是显而易见的。

相比之下，以下代码对其生成的goroutine何时结束并不在意：

```go
// 不好：
func (w *Worker) Run() {
    // ...
    for item := range w.q {
        // process在完成时返回，如果有的话，可能不会干净地处理状态转换或Go程序本身的终止。
        go process(item)
    }
    // ...
}
```

这段代码看起来可能没问题，但存在几个潜在问题：

*   代码在生产环境中可能具有未定义的行为，即使操作系统释放了资源，程序也可能无法干净地终止。

*   由于代码的生命周期不确定，难以进行有意义的测试。

*   如上所述，代码可能会泄漏资源。

另见：

*   [永远不要启动一个不知道如何停止的goroutine][cheney-stop]
*   重新思考经典并发模式：[幻灯片][rethinking-slides]，[视频][rethinking-video]
*   [Go程序何时结束]
*   [文档惯例：上下文]

[同步函数]: #synchronous-functions
[cheney-stop]: https://dave.cheney.net/2016/12/22/never-start-a-goroutine-without-knowing-how-it-will-stop
[rethinking-slides]: https://drive.google.com/file/d/1nPdvhB0PutEJzdCq5ms6UI58dp50fcAN/view
[rethinking-video]: https://www.youtube.com/watch?v=5zXAHh5tJqQ
[Go程序何时结束]: https://changelog.com/gotime/165
[文档惯例：上下文]: best-practices.md#documentation-conventions-contexts

<a id="interfaces"></a>
### 接口

<a id="TOC-Interfaces"></a>

Go 接口通常应属于*使用*接口类型值的包，而不是*实现*接口类型的包。实现包应返回具体类型（通常是指针或结构体类型）。这样，在实现中添加新方法时，就不需要进行大规模的重构。更多详情请参见 [GoTip #49: 接受接口，返回具体类型]。

不要从使用接口的 API 中导出接口的[测试替身][double types]实现。相反，应设计 API，使其可以使用[真实实现][real implementation]的[公共 API][public API]进行测试。更多详情请参见 [GoTip #42: 编写测试存根]。即使无法使用真实实现，也可能不需要引入一个完全覆盖真实类型所有方法的接口；使用者可以创建一个仅包含所需方法的接口，如 [GoTip #78: 最小可行接口] 中所示。

要测试使用 Stubby RPC 客户端的包，请使用真实的客户端连接。如果测试中无法运行真实服务器，Google 的内部做法是使用内部 rpctest 包（即将推出！）获取到本地[测试替身][test double]的真实客户端连接。

不要在使用接口之前定义它们（参见 [TotT: 代码健康：消除 YAGNI 气味][tott-438]）。没有实际的使用示例，很难判断一个接口是否必要，更不用说它应该包含哪些方法了。

如果包的用户不需要为参数传递不同的类型，就不要使用接口类型参数。

不要导出包的用户不需要的接口。

**TODO:** 编写更深入的接口文档，并在此处链接。

[GoTip #42: 编写测试存根]: https://jqknono.github.io/styleguide/go/index.html#gotip
[GoTip #49: 接受接口，返回具体类型]: https://jqknono.github.io/styleguide/go/index.html#gotip
[GoTip #78: 最小可行接口]: https://jqknono.github.io/styleguide/go/index.html#gotip
[real implementation]: best-practices#use-real-transports
[public API]: https://abseil.io/resources/swe-book/html/ch12.html#test_via_public_apis
[double types]: https://abseil.io/resources/swe-book/html/ch13.html#techniques_for_using_test_doubles
[test double]: https://abseil.io/resources/swe-book/html/ch13.html#basic_concepts
[tott-438]: https://testing.googleblog.com/2017/08/code-health-eliminate-yagni-smells.html

```go
// 正确：
package consumer // consumer.go

type Thinger interface { Thing() bool }

func Foo(t Thinger) string { ... }
```

```go
// 正确：
package consumer // consumer_test.go

type fakeThinger struct{ ... }
func (t fakeThinger) Thing() bool { ... }
...
if Foo(fakeThinger{...}) == "x" { ... }
```

```go
// 错误：
package producer

type Thinger interface { Thing() bool }

type defaultThinger struct{ ... }
func (t defaultThinger) Thing() bool { ... }

func NewThinger() Thinger { return defaultThinger{ ... } }
```

```go
// 正确：
package producer

type Thinger struct{ ... }
func (t Thinger) Thing() bool { ... }

func NewThinger() Thinger { return Thinger{ ... } }
```

<a id="generics"></a>
### 泛型

泛型（正式称为“类型参数”）在满足您的业务需求时是允许使用的。在许多应用程序中，使用现有语言功能（如切片、映射、接口等）的传统方法同样有效，且不会增加复杂性，因此要警惕过早使用泛型。请参阅关于[最小机制](guide#least-mechanism)的讨论。

在引入使用泛型的导出API时，请确保其有适当的文档。强烈建议包含激励性的可运行[示例]。

不要仅仅因为您正在实现一个不关心其成员元素类型的算法或数据结构而使用泛型。如果在实践中只有一种类型被实例化，请先尝试在不使用泛型的情况下使您的代码适用于该类型。相比于去除发现不必要的抽象，稍后添加多态性会更加简单。

不要使用泛型来发明领域特定语言（DSL）。特别是，不要引入可能给读者带来重大负担的错误处理框架。相反，优先使用已建立的[错误处理](#errors)实践。在测试中，尤其要警惕引入[断言库](#assert)或导致测试失败信息较少的[框架](#useful-test-failures)。

总的来说：

*   [编写代码，不要设计类型]。这是Robert Griesemer和Ian Lance Taylor在GopherCon上的演讲内容。
*   如果您有几个类型共享一个有用的统一接口，请考虑使用该接口来建模解决方案。可能不需要使用泛型。
*   否则，与其依赖`any`类型和过多的[类型切换](https://tour.golang.org/methods/16)，不如考虑使用泛型。

另见：

*   Ian Lance Taylor的[在Go中使用泛型]的演讲

*   Go网页上的[泛型教程]

[泛型教程]: https://go.dev/doc/tutorial/generics
[类型参数]: https://go.dev/design/43651-type-parameters
[在Go中使用泛型]: https://www.youtube.com/watch?v=nr8EpUO9jhw
[编写代码，不要设计类型]: https://www.youtube.com/watch?v=Pa_e9EeCdy8&t=1250s

<a id="pass-values"></a>

### 传递值

<a id="TOC-PassValues"></a>

不要仅仅为了节省几个字节而将指针作为函数参数传递。如果一个函数在整个过程中只以`*x`的方式读取其参数`x`，那么该参数就不应该是指针。这种情况的常见实例包括传递指向字符串的指针（`*string`）或指向接口值的指针（`*io.Reader`）。在这两种情况下，值本身是固定大小的，可以直接传递。

此建议不适用于大型结构体，甚至是可能增加大小的较小结构体。特别是，协议缓冲区消息通常应通过指针而不是通过值来处理。指针类型满足`proto.Message`接口（被`proto.Marshal`、`protocmp.Transform`等接受），并且协议缓冲区消息可能相当大，并且通常会随着时间的推移而变大。

<a id="receiver-type"></a>
### 接收器类型

<a id="TOC-ReceiverType"></a>

方法接收器可以作为值或指针传递，就像它是一个普通的函数参数一样。选择两者之一取决于该方法应属于哪个方法集。

**正确性胜过速度或简洁性。** 在某些情况下，你必须使用指针值。在其他情况下，对于大型类型或作为未来扩展的预防措施，如果你对代码的增长没有很好的把握，可以选择指针，对于简单的纯旧数据则使用值。

下面的列表详细说明了每种情况：

*   如果接收器是一个切片，并且方法不会重新切片或重新分配该切片，则使用值而不是指针。

    ```go
    // 良好：
    type Buffer []byte

    func (b Buffer) Len() int { return len(b) }
    ```

*   如果方法需要修改接收器，则接收器必须是指针。

    ```go
    // 良好：
    type Counter int

    func (c *Counter) Inc() { *c++ }

    // 参见 https://pkg.go.dev/container/heap。
    type Queue []Item

    func (q *Queue) Push(x Item) { *q = append([]Item{x}, *q...) }
    ```

*   如果接收器是一个包含不能安全复制的字段的结构体，请使用指针接收器。常见的例子是 `sync.Mutex` 和其他同步类型。

    ```go
    // 良好：
    type Counter struct {
        mu    sync.Mutex
        total int
    }

    func (c *Counter) Inc() {
        c.mu.Lock()
        defer c.mu.Unlock()
        c.total++
    }
    ```

    **提示：** 检查类型的 Godoc 以获取关于是否可以安全复制的信息。

*   如果接收器是一个“大的”结构体或数组，指针接收器可能更有效。传递一个结构体相当于将它的所有字段或元素作为参数传递给方法。如果这看起来太大而无法按值传递，指针是一个不错的选择。

*   对于将调用或与其他修改接收器的函数并发运行的方法，如果这些修改不应对你的方法可见，则使用值；否则使用指针。

*   如果接收器是一个结构体或数组，其中的任何元素是指向可能被修改的事物的指针，优先使用指针接收器，以明确表明可变性的意图。

    ```go
    // 良好：
    type Counter struct {
        m *Metric
    }

    func (c *Counter) Inc() {
        c.m.Add(1)
    }
    ```

*   如果接收器是一个内置类型，如整数或字符串，且不需要修改，则使用值。

    ```go
    // 良好：
    type User string

    func (u User) String() { return string(u) }
    ```

*   如果接收器是一个映射、函数或通道，使用值而不是指针。

    ```go
    // 良好：
    // 参见 https://pkg.go.dev/net/http#Header。
    type Header map[string][]string

    func (h Header) Add(key, value string) { /* 省略 */ }
    ```

*   如果接收器是一个“小”数组或结构体，它自然是一个值类型，没有可变字段和指针，通常值接收器是正确的选择。

    ```go
    // 良好：
    // 参见 https://pkg.go.dev/time#Time。
    type Time struct { /* 省略 */ }

    func (t Time) Add(d Duration) Time { /* 省略 */ }
    ```

*   当有疑问时，使用指针接收器。

作为一般指导原则，倾向于使类型的各个方法要么都是指针方法，要么都是值方法。

**注意：** 关于将值或指针传递给函数是否会影响性能，存在很多误解。编译器可以选择将堆栈上的值的指针传递，也可以复制堆栈上的值，但在大多数情况下，这些考虑不应超过代码的可读性和正确性。当性能确实重要时，在决定一种方法优于另一种方法之前，重要的是使用现实的基准测试来分析两种方法。

<a id="switch-break"></a>
### `switch` 和 `break`

<a id="TOC-SwitchBreak"></a>

在 `switch` 子句的末尾不要使用没有目标标签的 `break` 语句；它们是多余的。与 C 和 Java 不同，Go 中的 `switch` 子句会自动中断，需要使用 `fallthrough` 语句来实现 C 风格的行为。如果你想澄清空子句的目的，请使用注释而不是 `break`。

```go
// 正确：
switch x {
case "A", "B":
    buf.WriteString(x)
case "C":
    // 在 switch 语句之外处理
default:
    return fmt.Errorf("未知值: %q", x)
}
```

```go
// 错误：
switch x {
case "A", "B":
    buf.WriteString(x)
    break // 这个 break 是多余的
case "C":
    break // 这个 break 是多余的
default:
    return fmt.Errorf("未知值: %q", x)
}
```

> **注意：** 如果 `switch` 子句位于 `for` 循环内，在 `switch` 内使用 `break` 不会退出外围的 `for` 循环。
>
> ```go
> for {
>   switch x {
>   case "A":
>      break // 退出 switch，不退出循环
>   }
> }
> ```
>
> 要退出外围循环，请在 `for` 语句上使用标签：
>
> ```go
> loop:
>   for {
>     switch x {
>     case "A":
>        break loop // 退出循环
>     }
>   }
> ```

<a id="synchronous-functions"></a>

### 同步函数

<a id="TOC-SynchronousFunctions"></a>

同步函数直接返回结果，并在返回前完成任何回调或通道操作。优先选择同步函数而不是异步函数。

同步函数将 goroutine 局限于调用内。这有助于推理它们的生命周期，并避免泄漏和数据竞争。同步函数也更易于测试，因为调用者可以传递输入并检查输出，而无需轮询或同步。

如果需要，调用者可以通过在单独的 goroutine 中调用函数来添加并发性。然而，在调用方移除不必要的并发性是相当困难的（有时是不可能的）。

另见：

*   Bryan Mills 的演讲“重新思考经典并发模式”：[幻灯片][rethinking-slides]，[视频][rethinking-video]

<a id="type-aliases"></a>

### 类型别名

<a id="TOC-TypeAliases"></a>

使用 *类型定义*，`type T1 T2`，来定义一个新类型。使用 [*类型别名*]，`type T1 = T2`，来引用现有类型而不定义新类型。类型别名很少见；它们的主要用途是帮助将包迁移到新的源代码位置。在不需要时不要使用类型别名。

[*类型别名*]: http://golang.org/ref/spec#Type_declarations

<a id="use-percent-q"></a>

### 使用 %q

<a id="TOC-UsePercentQ"></a>

Go 的格式化函数（`fmt.Printf` 等）有一个 `%q` 动词，它会在双引号内打印字符串。

```go
// 正确：
fmt.Printf("值 %q 看起来像英文文本", someText)
```

优先使用 `%q`，而不是手动使用 `%s` 做等效操作：

```go
// 错误：
fmt.Printf("值 \"%s\" 看起来像英文文本", someText)
// 避免手动用单引号包装字符串：
fmt.Printf("值 '%s' 看起来像英文文本", someText)
```

在输出可能为空或包含控制字符的输入值时，建议在面向人类的输出中使用 `%q`。很难注意到一个无声的空字符串，但 `""` 显然是空的。

<a id="use-any"></a>

### 使用 any

Go 1.18 引入了 `any` 类型作为 [别名] 到 `interface{}`。因为它是一个别名，`any` 在许多情况下与 `interface{}` 等价，并且在其他情况下可以通过显式转换轻松互换。在新代码中优先使用 `any`。

[别名]: https://go.googlesource.com/proposal/+/master/design/18130-type-alias.md

## 常用库

<a id="flags"></a>
### 标志

<a id="TOC-Flags"></a>

Google代码库中的Go程序使用了[标准`flag`包]的内部变体。它具有相似的接口，但与Google内部系统的互操作性良好。Go二进制文件中的标志名称应优先使用下划线分隔单词，尽管保存标志值的变量应遵循标准的Go命名风格（[混合大小写]）。具体来说，标志名称应使用蛇形命名法，而变量名称应使用相应的驼峰命名法。

```go
// 正确：
var (
    pollInterval = flag.Duration("poll_interval", time.Minute, "用于轮询的时间间隔。")
)
```

```go
// 错误：
var (
    poll_interval = flag.Int("pollIntervalSeconds", 60, "用于轮询的时间间隔，单位为秒。")
)
```

标志只能在`package main`或等效位置定义。

通用包应使用Go API进行配置，而不是通过命令行接口进行配置；不要让导入库作为副作用导出新的标志。也就是说，优先使用显式的函数参数或结构体字段赋值，或者在最严格的审查下极少使用导出的全局变量。在极少数需要打破此规则的情况下，标志名称必须清楚地表明它配置的包。

如果你的标志是全局变量，请将它们放在导入部分之后的独立`var`组中。

关于创建带有子命令的[复杂CLI]的最佳实践有更多的讨论。

另见：

*   [每周提示#45：避免使用标志，尤其是在库代码中][totw-45]
*   [Go提示#10：配置结构体和标志](https://jqknono.github.io/styleguide/go/index.html#gotip)
*   [Go提示#80：依赖注入原则](https://jqknono.github.io/styleguide/go/index.html#gotip)

[标准`flag`包]: https://golang.org/pkg/flag/
[混合大小写]: guide#mixed-caps
[复杂CLI]: best-practices#complex-clis
[totw-45]: https://abseil.io/tips/45

<a id="logging"></a>

### 日志记录

Google代码库中的Go程序使用了标准[`log`]包的变体。它具有相似但更强大的接口，并且与Google内部系统的互操作性良好。这个库的开源版本作为[包`glog`]可用，开源Google项目可以使用它，但本指南始终将其称为`log`。

**注意：**对于异常程序退出，此库使用`log.Fatal`来终止并提供堆栈跟踪，使用`log.Exit`来停止但不提供堆栈跟踪。标准库中没有`log.Panic`函数。

**提示：**`log.Info(v)`等同于`log.Infof("%v", v)`，其他日志级别也是如此。当没有格式化需求时，优先使用非格式化版本。

另见：

*   关于[记录错误](best-practices#error-logging)和[自定义详细级别](best-practices#vlog)的最佳实践
*   何时以及如何使用日志包来[停止程序](best-practices#checks-and-panics)

[`log`]: https://pkg.go.dev/log
[`log/slog`]: https://pkg.go.dev/log/slog
[包`glog`]: https://pkg.go.dev/github.com/golang/glog
[`log.Exit`]: https://pkg.go.dev/github.com/golang/glog#Exit
[`log.Fatal`]: https://pkg.go.dev/github.com/golang/glog#Fatal

<a id="contexts"></a>
### 上下文

<a id="TOC-Contexts"></a>

[`context.Context`] 类型的值在 API 和进程边界之间传递安全凭证、跟踪信息、截止时间和取消信号。与 Google 代码库中使用线程本地存储的 C++ 和 Java 不同，Go 程序会显式地将上下文沿着从传入的 RPC 和 HTTP 请求到传出请求的整个函数调用链传递。

[`context.Context`]: https://pkg.go.dev/context

当传递给函数或方法时，`context.Context` 始终是第一个参数。

```go
func F(ctx context.Context /* 其他参数 */) {}
```

例外情况包括：

*   在 HTTP 处理程序中，上下文来自 [`req.Context()`](https://pkg.go.dev/net/http#Request.Context)。
*   在流式 RPC 方法中，上下文来自流。

    使用 gRPC 流的代码从生成的服务器类型中的 `Context()` 方法访问上下文，该类型实现了 `grpc.ServerStream`。参见 [gRPC 生成代码文档](https://grpc.io/docs/languages/go/generated-code/)。

*   在入口点函数中（参见下面的示例），使用 [`context.Background()`](https://pkg.go.dev/context/#Background)。

    *   在二进制目标中：`main`
    *   在通用代码和库中：`init`
    *   在测试中：`TestXXX`, `BenchmarkXXX`, `FuzzXXX`

> **注意**：在调用链中间的代码很少需要使用 `context.Background()` 创建自己的基础上下文。除非是错误的上下文，否则总是优先从调用者那里获取上下文。
>
> 您可能会遇到服务器库（Google 的 Go 服务器框架中 Stubby、gRPC 或 HTTP 的实现），这些库会为每个请求构建一个新的上下文对象。这些上下文会立即从传入请求中填充信息，以便在传递给请求处理程序时，上下文的附加值已经从客户端调用者跨网络边界传播到它。此外，这些上下文的生命周期与请求的生命周期相关联：当请求完成时，上下文会被取消。
>
> 除非您正在实现服务器框架，否则在库代码中不应使用 `context.Background()` 创建上下文。相反，如果有现有上下文可用，优先使用下文提到的上下文分离。如果您认为在入口点函数之外确实需要 `context.Background()`，在实施之前请与 Google Go 风格邮件列表讨论。

`context.Context` 在函数中首先出现的惯例也适用于测试辅助函数。

```go
// 正确：
func readTestFile(ctx context.Context, t *testing.T, path string) string {}
```

不要在结构类型中添加上下文成员。相反，为需要传递上下文的类型上的每个方法添加上下文参数。唯一的例外是那些签名必须匹配标准库或 Google 控制之外的第三方库中的接口的方法。这种情况非常罕见，在实施和可读性审查之前应与 Google Go 风格邮件列表讨论。

Google 代码库中必须启动在父上下文取消后仍可运行的后台操作的代码可以使用内部包进行分离。请关注 [issue #40221](https://github.com/golang/go/issues/40221)，了解开源替代方案的讨论。

由于上下文是不可变的，将同一个上下文传递给多个共享相同截止时间、取消信号、凭证、父跟踪等的调用是可以的。

另见：

*   [上下文和结构]

[上下文和结构]: https://go.dev/blog/context-and-structs

<a id="custom-contexts"></a>

#### 自定义上下文

不要创建自定义上下文类型或在函数签名中使用 `context.Context` 之外的接口。此规则没有例外。

想象一下，如果每个团队都有自定义上下文。包 `p` 到包 `q` 的每次函数调用都必须确定如何将 `p.Context` 转换为 `q.Context`，对于所有包 `p` 和 `q` 的组合。这对人类来说不切实际且容易出错，并且使得添加上下文参数的自动重构几乎不可能。

如果您有应用程序数据需要传递，请将其放在参数中、接收器中、全局变量中，或者如果它确实属于那里，则放在 `Context` 值中。创建自己的上下文类型是不可接受的，因为这会破坏 Go 团队使 Go 程序在生产中正常工作的能力。

<a id="crypto-rand"></a>
### crypto/rand

<a id="TOC-CryptoRand"></a>

不要使用 `math/rand` 包来生成密钥，即使是临时使用的也不行。如果未播种，生成器完全可预测。如果使用 `time.Nanoseconds()` 播种，熵只有几比特。相反，应该使用 `crypto/rand` 的 Reader，如果需要文本，可以输出为十六进制或 base64。

```go
// 正确做法：
import (
    "crypto/rand"
    // "encoding/base64"
    // "encoding/hex"
    "fmt"

    // ...
)

func Key() string {
    buf := make([]byte, 16)
    if _, err := rand.Read(buf); err != nil {
        log.Fatalf("随机数耗尽，这不应该发生：%v", err)
    }
    return fmt.Sprintf("%x", buf)
    // 或者 hex.EncodeToString(buf)
    // 或者 base64.StdEncoding.EncodeToString(buf)
}
```

**注意：** `log.Fatalf` 不是标准库的 log。参见 [#logging]。

<a id="useful-test-failures"></a>

## 有用的测试失败

<a id="TOC-UsefulTestFailures"></a>

应该能够在不阅读测试源码的情况下诊断测试失败。测试应该以有帮助的信息失败，详细说明：

*   导致失败的原因
*   导致错误的输入
*   实际结果
*   期望的结果

实现这一目标的具体约定如下所述。

<a id="assert"></a>

### 断言库

<a id="TOC-Assert"></a>

不要创建“断言库”作为测试的辅助工具。

断言库是尝试将验证和测试中失败消息的生成结合起来的库（尽管同样的陷阱也可能适用于其他测试辅助工具）。关于测试辅助工具和断言库之间的区别，请参见[最佳实践](best-practices#test-functions)。

```go
// 错误做法：
var obj BlogPost

assert.IsNotNil(t, "obj", obj)
assert.StringEq(t, "obj.Type", obj.Type, "blogPost")
assert.IntEq(t, "obj.Comments", obj.Comments, 2)
assert.StringNotEq(t, "obj.Body", obj.Body, "")
```

断言库往往会提前终止测试（如果 `assert` 调用 `t.Fatalf` 或 `panic`），或者省略有关测试正确部分的相关信息：

```go
// 错误做法：
package assert

func IsNotNil(t *testing.T, name string, val any) {
    if val == nil {
        t.Fatalf("数据 %s = nil，期望非 nil", name)
    }
}

func StringEq(t *testing.T, name, got, want string) {
    if got != want {
        t.Fatalf("数据 %s = %q，期望 %q", name, got, want)
    }
}
```

复杂的断言函数通常不会提供[有用的失败消息]和测试函数中存在的上下文。过多的断言函数和库会导致开发者体验碎片化：我应该使用哪个断言库，它应该输出什么样的格式等？碎片化会产生不必要的混乱，尤其是对库维护者和大规模变更的作者来说，他们负责修复潜在的下游中断。不要创建用于测试的特定领域语言，而是使用 Go 本身。

断言库通常会分离出比较和等式检查。优先使用标准库，如 [`cmp`] 和 [`fmt`]：

```go
// 正确做法：
var got BlogPost

want := BlogPost{
    Comments: 2,
    Body:     "Hello, world!",
}

if !cmp.Equal(got, want) {
    t.Errorf("博客文章 = %v，期望 = %v", got, want)
}
```

对于更特定领域的比较辅助工具，优先返回一个值或错误，这些值或错误可以在测试的失败消息中使用，而不是传递 `*testing.T` 并调用其错误报告方法：

```go
// 正确做法：
func postLength(p BlogPost) int { return len(p.Body) }

func TestBlogPost_VeritableRant(t *testing.T) {
    post := BlogPost{Body: "I am Gunnery Sergeant Hartman, your senior drill instructor."}

    if got, want := postLength(post), 60; got != want {
        t.Errorf("文章长度 = %v，期望 %v", got, want)
    }
}
```

**最佳实践：** 如果 `postLength` 非平凡，那么直接测试它是有意义的，独立于使用它的任何测试。

另见：

*   [等式比较和差异](#types-of-equality)
*   [打印差异](#print-diffs)
*   关于测试辅助工具和断言辅助工具之间的区别，请参见[最佳实践](best-practices#test-functions)

[有用的失败消息]: #useful-test-failures
[`fmt`]: https://golang.org/pkg/fmt/
[标记测试辅助工具]: #mark-test-helpers

<a id="identify-the-function"></a>
### 识别函数

在大多数测试中，失败消息应包含失败函数的名称，即使从测试函数的名称中看起来很明显。具体来说，你的失败消息应为 `YourFunc(%v) = %v, want %v`，而不是仅仅 `got %v, want %v`。

<a id="identify-the-input"></a>

### 识别输入

在大多数测试中，如果输入较短，失败消息应包含函数输入。如果输入的相关属性不明显（例如，因为输入较大或不透明），你应该用描述正在测试的内容来命名你的测试用例，并在错误消息中打印该描述。

<a id="got-before-want"></a>

### 先显示实际值再显示期望值

测试输出应在打印期望值之前包含函数返回的实际值。打印测试输出的标准格式为 `YourFunc(%v) = %v, want %v`。在你会写“实际”和“期望”的地方，分别优先使用“got”和“want”这两个词。

对于差异，方向性不太明显，因此包含一个键来帮助解释失败是很重要的。参见[打印差异的部分]。无论你在失败消息中使用哪种差异顺序，你都应该在失败消息中明确指出，因为现有代码关于顺序是不一致的。

[打印差异的部分]: #print-diffs

<a id="compare-full-structures"></a>

### 完整结构比较

如果你的函数返回一个结构体（或任何具有多个字段的数据类型，如切片、数组和映射），避免编写手动逐字段比较结构体的测试代码。相反，构造你期望函数返回的数据，并使用[深度比较]直接进行比较。

**注意：** 如果你的数据包含模糊测试意图的无关字段，则不适用此规则。

如果你的结构体需要进行近似（或等价类型的语义）相等比较，或者它包含无法进行相等比较的字段（例如，如果其中一个字段是 `io.Reader`），调整 [`cmp.Diff`] 或 [`cmp.Equal`] 比较，使用 [`cmpopts`] 选项如 [`cmpopts.IgnoreInterfaces`] 可能满足你的需求（[示例](https://play.golang.org/p/vrCUNVfxsvF)）。

如果你的函数返回多个返回值，你不需要在比较之前将它们包装在结构体中。只需单独比较返回值并打印它们。

```go
// 良好：
val, multi, tail, err := strconv.UnquoteChar(`\"Fran & Freddie's Diner\"`, '"')
if err != nil {
  t.Fatalf(...)
}
if val != `"` {
  t.Errorf(...)
}
if multi {
  t.Errorf(...)
}
if tail != `Fran & Freddie's Diner"` {
  t.Errorf(...)
}
```

[深度比较]: #types-of-equality
[`cmpopts`]: https://pkg.go.dev/github.com/google/go-cmp/cmp/cmpopts
[`cmpopts.IgnoreInterfaces`]: https://pkg.go.dev/github.com/google/go-cmp/cmp/cmpopts#IgnoreInterfaces

<a id="compare-stable-results"></a>

### 比较稳定结果

避免比较可能依赖于你不拥有的包的输出稳定性的结果。相反，测试应基于语义相关且对依赖变化具有抵抗力的稳定信息进行比较。对于返回格式化字符串或序列化字节的功能，通常不能假设输出是稳定的。

例如，[`json.Marshal`] 可能会更改（过去也曾更改过）它发出的特定字节。如果 `json` 包更改了它序列化字节的方式，则对 JSON 字符串执行字符串相等性的测试可能会失败。相反，更robust的测试将解析 JSON 字符串的内容，并确保它在语义上与某个预期的数据结构等价。

[`json.Marshal`]: https://golang.org/pkg/encoding/json/#Marshal

<a id="keep-going"></a>
### 继续进行

测试应该尽可能长时间地继续进行，即使在失败之后也是如此，以便在一次运行中打印出所有失败的检查。这样，修复失败测试的开发人员在修复每个错误后就不必重新运行测试来查找下一个错误。

在报告不匹配时，优先使用 `t.Error` 而不是 `t.Fatal`。在比较函数输出的多个不同属性时，对每项比较使用 `t.Error`。

调用 `t.Fatal` 主要用于报告意外的错误条件，当后续的比较失败没有意义时。

对于表驱动测试，考虑使用子测试，并使用 `t.Fatal` 而不是 `t.Error` 和 `continue`。另见 [GoTip #25: 子测试：让你的测试更精简](https://jqknono.github.io/styleguide/go/index.html#gotip)。

**最佳实践：** 关于何时应使用 `t.Fatal` 的更多讨论，请参见[最佳实践](best-practices#t-fatal)。

<a id="types-of-equality"></a>

### 平等比较和差异

`==` 运算符使用[语言定义的比较]评估平等。标量值（数字、布尔值等）基于其值进行比较，但只有某些结构体和接口可以以这种方式进行比较。指针的比较基于它们是否指向同一个变量，而不是基于它们指向的值的平等。

[`cmp`] 包可以比较 `==` 无法适当处理的更复杂的数据结构，例如切片。使用 [`cmp.Equal`] 进行平等比较，使用 [`cmp.Diff`] 获取对象之间的人类可读的差异。

```go
// 良好：
want := &Doc{
    Type:     "blogPost",
    Comments: 2,
    Body:     "This is the post body.",
    Authors:  []string{"isaac", "albert", "emmy"},
}
if !cmp.Equal(got, want) {
    t.Errorf("AddPost() = %+v, want %+v", got, want)
}
```

作为通用比较库，`cmp` 可能不知道如何比较某些类型。例如，只有在传递了 [`protocmp.Transform`] 选项时，它才能比较协议缓冲区消息。

<!-- 此处 want 和 got 的顺序是经过深思熟虑的。参见 #print-diffs 中的评论。 -->

```go
// 良好：
if diff := cmp.Diff(want, got, protocmp.Transform()); diff != "" {
    t.Errorf("Foo() 返回的 protobuf 消息中有意外的差异 (-want +got):\n%s", diff)
}
```

虽然 `cmp` 包不是 Go 标准库的一部分，但它由 Go 团队维护，并且应该随着时间的推移产生稳定的平等结果。它是用户可配置的，应该能满足大多数比较需求。

[语言定义的比较]: http://golang.org/ref/spec#Comparison_operators
[`cmp`]: https://pkg.go.dev/github.com/google/go-cmp/cmp
[`cmp.Equal`]: https://pkg.go.dev/github.com/google/go-cmp/cmp#Equal
[`cmp.Diff`]: https://pkg.go.dev/github.com/google/go-cmp/cmp#Diff
[`protocmp.Transform`]: https://pkg.go.dev/google.golang.org/protobuf/testing/protocmp#Transform

现有代码可能使用以下较旧的库，并且为了保持一致性可以继续使用它们：

*   [`pretty`] 生成美观的差异报告。然而，它非常刻意地将具有相同视觉表示的值视为相等。特别是，`pretty` 不会捕捉到 nil 切片和空切片之间的差异，不会对具有相同字段的不同接口实现敏感，并且可以使用嵌套的映射作为与结构体值进行比较的基础。它还会在生成差异之前将整个值序列化为字符串，因此不适合比较大型值。默认情况下，它比较未导出的字段，这使得它对依赖项中实现细节的变化敏感。因此，不适合在 protobuf 消息上使用 `pretty`。

[`pretty`]: https://pkg.go.dev/github.com/kylelemons/godebug/pretty

对于新代码，优先使用 `cmp`，并且值得考虑在实际可行的情况下更新旧代码以使用 `cmp`。

旧代码可能使用标准库 `reflect.DeepEqual` 函数来比较复杂结构。`reflect.DeepEqual` 不应用于检查平等，因为它对未导出的字段和其他实现细节的变化敏感。使用 `reflect.DeepEqual` 的代码应更新为上述库之一。

**注意：** `cmp` 包是为测试而设计的，而不是用于生产环境。因此，当它怀疑比较执行不正确时，可能会引发恐慌，以向用户提供如何改进测试以减少脆弱性的指导。鉴于 `cmp` 容易引发恐慌的倾向，它不适合用于生产环境中的代码，因为意外的恐慌可能是致命的。

<a id="level-of-detail"></a>
### 详细程度

适用于大多数 Go 测试的常规失败消息是 `YourFunc(%v) = %v, 期望 %v`。然而，有些情况下可能需要更多或更少的细节：

*   执行复杂交互的测试也应该描述这些交互。例如，如果同一个 `YourFunc` 被多次调用，需指出是哪次调用导致测试失败。如果了解系统的任何额外状态很重要，请在失败输出中包含这些信息（至少在日志中包含）。
*   如果数据是一个包含大量样板代码的复杂结构体，只在消息中描述重要部分是可以接受的，但不要过度隐藏数据。
*   设置失败不需要同样的详细程度。如果测试辅助函数填充 Spanner 表但 Spanner 宕机了，你可能不需要包含你打算存储在数据库中的测试输入。`t.Fatalf("设置：无法设置测试数据库：%s", err)` 通常足以解决问题。

**提示：** 在开发过程中触发你的失败模式。查看失败消息的外观，以及维护者是否能有效处理失败。

有一些技术可以清晰地重现测试输入和输出：

*   在打印字符串数据时，[`%q` 通常很有用](#use-percent-q)，以强调该值的重要性，并更容易发现错误值。
*   在打印（小型）结构体时，`%+v` 可能比 `%v` 更有用。
*   当验证较大值失败时，[打印差异](#print-diffs) 可以更容易理解失败。

<a id="print-diffs"></a>

### 打印差异

如果你的函数返回大量输出，那么当测试失败时，阅读失败消息的人可能很难找到差异。不要同时打印返回值和期望值，而是生成一个差异。

对于这种值计算差异，首选 `cmp.Diff`，特别是对于新测试和新代码，但也可以使用其他工具。参见[平等类型]以了解每种函数的优缺点。

*   [`cmp.Diff`]

*   [`pretty.Compare`]

你可以使用 [`diff`] 包来比较多行字符串或字符串列表。你可以将其作为构建其他类型差异的基石。

[平等类型]: #types-of-equality
[`diff`]: https://pkg.go.dev/github.com/kylelemons/godebug/diff
[`pretty.Compare`]: https://pkg.go.dev/github.com/kylelemons/godebug/pretty#Compare

在你的失败消息中添加一些文本，解释差异的方向。

<!--
这些示例中 want 和 got 的反转顺序是故意的，因为这是 Google 代码库中普遍的顺序。不采取立场使用哪种顺序也是故意的，因为没有共识哪种是“最易读的。”

-->

*   当你使用 `cmp`、`pretty` 和 `diff` 包时，像 `diff (-want +got)` 这样的表达很好（如果你将 `(want, got)` 传递给函数），因为你添加到格式字符串中的 `-` 和 `+` 将与差异行开头的实际 `-` 和 `+` 相匹配。如果你将 `(got, want)` 传递给你的函数，正确的键应该是 `(-got +want)`。

*   `messagediff` 包使用不同的输出格式，因此当你使用它时，消息 `diff (want -> got)` 是合适的（如果你将 `(want, got)` 传递给函数），因为箭头的方向将与“修改”行中的箭头方向匹配。

差异将跨多行，因此在打印差异之前，你应该打印一个换行符。

<a id="test-error-semantics"></a>
### 测试错误语义

当单元测试执行字符串比较或使用普通的 `cmp` 来检查特定输入是否返回特定类型的错误时，如果这些错误消息在未来被重新措辞，你可能会发现你的测试变得脆弱。由于这有可能使你的单元测试变成一个变更检测器（参见 [TotT: 变更检测器测试被认为是有害的][tott-350]），不要使用字符串比较来检查你的函数返回的错误类型。然而，允许使用字符串比较来检查来自被测试包的错误消息是否满足某些属性，例如，包含参数名称。

Go 中的错误值通常有一个面向人类的组件和一个用于语义控制流的组件。测试应该只测试可以可靠观察到的语义信息，而不是用于人类调试的显示信息，因为这些信息往往容易在未来发生变化。关于构建具有语义意义的错误的指导，请参见[关于错误的最佳实践](best-practices#error-handling)。如果一个错误来自你无法控制的依赖，并且其语义信息不足，请考虑向所有者提交一个错误报告以帮助改进 API，而不是依赖于解析错误消息。

在单元测试中，通常只关心是否发生了错误。如果是这样，那么只测试错误是否在你期望错误时为非 nil 就足够了。如果你想测试错误在语义上是否与其他错误匹配，请考虑使用 [`errors.Is`] 或带有 [`cmpopts.EquateErrors`] 的 `cmp`。

> **注意：** 如果一个测试使用了 [`cmpopts.EquateErrors`] 但其所有 `wantErr` 值要么是 `nil` 要么是 `cmpopts.AnyError`，那么使用 `cmp` 就是[不必要的机制](guide#least-mechanism)。通过将 `want` 字段简化为 `bool` 来简化代码。然后你可以使用简单的 `!=` 比较。
>
> ```go
> // 良好：
> err := f(test.input)
> gotErr := err != nil
> if gotErr != test.wantErr {
>     t.Errorf("f(%q) = %v, 期望错误存在 = %v", test.input, err, test.wantErr)
> }
> ```

另见
[GoTip #13: 为检查设计错误](https://jqknono.github.io/styleguide/go/index.html#gotip)。

[tott-350]: https://testing.googleblog.com/2015/01/testing-on-toilet-change-detector-tests.html
[`cmpopts.EquateErrors`]: https://pkg.go.dev/github.com/google/go-cmp/cmp/cmpopts#EquateErrors
[`errors.Is`]: https://pkg.go.dev/errors#Is

<a id="test-structure"></a>

## 测试结构

<a id="subtests"></a>
### 子测试

标准 Go 测试库提供了一种[定义子测试]的功能。这允许在设置和清理、控制并行性以及测试过滤方面具有灵活性。子测试可能很有用（特别是对于表驱动测试），但使用它们并非强制性的。另见 [Go 博客关于子测试的文章](https://blog.golang.org/subtests)。

子测试不应依赖于其他用例的执行来获得成功或初始状态，因为子测试应能够使用 `go test -run` 标志或 Bazel [测试过滤]表达式单独运行。

[定义子测试]: https://pkg.go.dev/testing#hdr-Subtests_and_Sub_benchmarks
[测试过滤]: https://bazel.build/docs/user-manual#test-filter

<a id="subtest-names"></a>

#### 子测试名称

为子测试命名时，应使其在测试输出中易于阅读，并且在命令行上对使用测试过滤的用户有用。当您使用 `t.Run` 创建子测试时，第一个参数用作测试的描述性名称。为了确保测试结果对阅读日志的人类可读，请选择在转义后仍然有用且可读的子测试名称。将子测试名称更多地视为函数标识符而不是散文描述。测试运行器会将空格替换为下划线，并转义非打印字符。如果您的测试数据受益于更长的描述，请考虑将描述放在单独的字段中（可能使用 `t.Log` 打印或与失败消息一起显示）。

子测试可以使用 [Go 测试运行器]或 Bazel [测试过滤]的标志单独运行，因此请选择描述性名称，同时也易于输入。

> **警告：** 在子测试名称中使用斜杠字符特别不友好，因为它们对测试过滤具有[特殊含义]。
>
> > ```sh
> > # 不好：
> > # 假设 TestTime 和 t.Run("America/New_York", ...)
> > bazel test :mytest --test_filter="Time/New_York"    # 什么都不运行！
> > bazel test :mytest --test_filter="Time//New_York"   # 正确，但笨拙。
> > ```

为了[识别函数的输入]，请将它们包含在测试的失败消息中，这样它们就不会被测试运行器转义。

```go
// 好：
func TestTranslate(t *testing.T) {
    data := []struct {
        name, desc, srcLang, dstLang, srcText, wantDstText string
    }{
        {
            name:        "hu=en_bug-1234",
            desc:        "bug 1234 后的回归测试。联系人：cleese",
            srcLang:     "hu",
            srcText:     "cigarettát és egy öngyújtót kérek",
            dstLang:     "en",
            wantDstText: "cigarettes and a lighter please",
        }, // ...
    }
    for _, d := range data {
        t.Run(d.name, func(t *testing.T) {
            got := Translate(d.srcLang, d.dstLang, d.srcText)
            if got != d.wantDstText {
                t.Errorf("%s\nTranslate(%q, %q, %q) = %q, want %q",
                    d.desc, d.srcLang, d.dstLang, d.srcText, got, d.wantDstText)
            }
        })
    }
}
```

以下是一些应避免的示例：

```go
// 不好：
// 太啰嗦了。
t.Run("检查没有提到划伤的唱片或气垫船", ...)
// 斜杠在命令行上会引起问题。
t.Run("AM/PM 混淆", ...)
```

另见 [Go 提示 #117：子测试名称](https://jqknono.github.io/styleguide/go/index.html#gotip)。

[Go 测试运行器]: https://golang.org/cmd/go/#hdr-Testing_flags
[识别函数的输入]: #identify-the-input
[特殊含义]: https://blog.golang.org/subtests#:~:text=Perhaps%20a%20bit,match%20any%20tests

<a id="table-driven-tests"></a>
### 表驱动测试

当许多不同的测试用例可以使用相似的测试逻辑进行测试时，请使用表驱动测试。

*   当测试函数的实际输出是否等于预期输出时。例如，`fmt.Sprintf` 的许多[测试]或下面的最小代码片段。
*   当测试函数的输出是否始终符合同一组不变量时。例如，`net.Dial` 的[测试]。

[测试]: https://cs.opensource.google/go/go/+/master:src/fmt/fmt_test.go
[测试]: https://cs.opensource.google/go/go/+/master:src/net/dial_test.go;l=318;drc=5b606a9d2b7649532fe25794fa6b99bd24e7697c

这是表驱动测试的最小结构。如果需要，您可以使用不同的名称或添加额外的功能，如子测试或设置和清理函数。始终牢记[有用的测试失败](#有用的测试失败)。

```go
// 良好：
func TestCompare(t *testing.T) {
    compareTests := []struct {
        a, b string
        want int
    }{
        {"", "", 0},
        {"a", "", 1},
        {"", "a", -1},
        {"abc", "abc", 0},
        {"ab", "abc", -1},
        {"abc", "ab", 1},
        {"x", "ab", 1},
        {"ab", "x", -1},
        {"x", "a", 1},
        {"b", "x", -1},
        // 测试 runtime·memeq 的分块实现
        {"abcdefgh", "abcdefgh", 0},
        {"abcdefghi", "abcdefghi", 0},
        {"abcdefghi", "abcdefghj", -1},
    }

    for _, test := range compareTests {
        got := Compare(test.a, test.b)
        if got != test.want {
            t.Errorf("Compare(%q, %q) = %v, want %v", test.a, test.b, got, test.want)
        }
    }
}
```

**注意**：上面的示例中的失败消息符合[识别函数](#识别函数)和[识别输入](#识别输入)的指导。无需[按行号识别](#表测试识别行)。

当某些测试用例需要使用与其他测试用例不同的逻辑进行检查时，编写多个测试函数更为合适，如[GoTip #50: 不相关的表测试]中所解释的。当表中的每个条目都有自己的不同条件逻辑来检查每个输出的输入时，测试代码的逻辑可能会变得难以理解。如果测试用例具有不同的逻辑但相同的设置，则在单个测试函数中使用一系列[子测试](#子测试)可能是有意义的。

您可以将表驱动测试与多个测试函数结合使用。例如，当测试函数的输出完全匹配预期输出，并且函数对无效输入返回非nil错误时，编写两个独立的表驱动测试函数是最佳方法：一个用于正常的非错误输出，一个用于错误输出。

[GoTip #50: 不相关的表测试]: https://jqknono.github.io/styleguide/go/index.html#gotip

<a id="表测试数据驱动"></a>

#### 数据驱动测试用例

表测试的行有时会变得复杂，行值决定测试用例内部的条件行为。测试用例之间的重复带来的额外清晰度对于可读性是必要的。

```go
// 良好：
type decodeCase struct {
    name   string
    input  string
    output string
    err    error
}

func TestDecode(t *testing.T) {
    // setupCodex 很慢，因为它为测试创建了一个真实的 Codex。
    codex := setupCodex(t)

    var tests []decodeCase // 为了简洁，省略了行

    for _, test := range tests {
        t.Run(test.name, func(t *testing.T) {
            output, err := Decode(test.input, codex)
            if got, want := output, test.output; got != want {
                t.Errorf("Decode(%q) = %v, want %v", test.input, got, want)
            }
            if got, want := err, test.err; !cmp.Equal(got, want) {
                t.Errorf("Decode(%q) err %q, want %q", test.input, got, want)
            }
        })
    }
}

func TestDecodeWithFake(t *testing.T) {
    // fakeCodex 是真实 Codex 的快速近似。
    codex := newFakeCodex()

    var tests []decodeCase // 为了简洁，省略了行

    for _, test := range tests {
        t.Run(test.name, func(t *testing.T) {
            output, err := Decode(test.input, codex)
            if got, want := output, test.output; got != want {
                t.Errorf("Decode(%q) = %v, want %v", test.input, got, want)
            }
        })
    }
}
```
```go
if got, want := err, test.err; !cmp.Equal(got, want) {
    t.Errorf("Decode(%q) err %q, want %q", test.input, got, want)
}
})
}
}

在下面的反例中，请注意在案例设置中区分每种测试用例使用的`Codex`类型是多么困难。（高亮部分违反了[TotT: Data Driven Traps!][tott-97]中的建议。）

```go
// 不好：
type decodeCase struct {
  name   string
  input  string
  codex  testCodex
  output string
  err    error
}

type testCodex int

const (
  fake testCodex = iota
  prod
)

func TestDecode(t *testing.T) {
  var tests []decodeCase // 为了简洁，省略了行

  for _, test := tests {
    t.Run(test.name, func(t *testing.T) {
      var codex Codex
      switch test.codex {
      case fake:
        codex = newFakeCodex()
      case prod:
        codex = setupCodex(t)
      default:
        t.Fatalf("未知代码类型: %v", codex)
      }
      output, err := Decode(test.input, codex)
      if got, want := output, test.output; got != want {
        t.Errorf("Decode(%q) = %q, want %q", test.input, got, want)
      }
      if got, want := err, test.err; !cmp.Equal(got, want) {
        t.Errorf("Decode(%q) err %q, want %q", test.input, got, want)
      }
    })
  }
}
```

[tott-97]: https://testing.googleblog.com/2008/09/tott-data-driven-traps.html

<a id="table-tests-identifying-the-row"></a>

#### 识别行

不要使用测试表中测试的索引来代替命名你的测试或打印输入。没有人愿意为了找出哪个测试用例失败而浏览你的测试表并计算条目。

```go
// 不好：
tests := []struct {
    input, want string
}{
    {"hello", "HELLO"},
    {"wORld", "WORLD"},
}
for i, d := range tests {
    if strings.ToUpper(d.input) != d.want {
        t.Errorf("在案例 #%d 上失败", i)
    }
}
```

在你的测试结构中添加测试描述，并在失败消息中打印它。使用子测试时，你的子测试名称应该能够有效地识别行。

**重要：** 即使`t.Run`限定了输出和执行，你也必须始终[识别输入]。表测试行的名称必须遵循[子测试命名]指导。

[identify the input]: #identify-the-input
[subtest naming]: #subtest-names

<a id="mark-test-helpers"></a>

### 测试助手

测试助手是一个执行设置或清理任务的函数。测试助手中发生的所有失败都应该是环境的失败（不是被测试代码的失败）——例如，当测试数据库无法启动，因为这台机器上没有更多的可用端口。

如果你传递了一个`*testing.T`，请调用[`t.Helper`]以将测试助手中的失败归因于调用助手的行。这个参数应该放在[上下文](#contexts)参数之后（如果存在），以及任何剩余参数之前。

```go
// 好：
func TestSomeFunction(t *testing.T) {
    golden := readFile(t, "testdata/golden-result.txt")
    // ... 对golden进行测试 ...
}

// readFile返回数据文件的内容。
// 它必须只在启动测试的同一个goroutine中调用。
func readFile(t *testing.T, filename string) string {
    t.Helper()
    contents, err := runfiles.ReadFile(filename)
    if err != nil {
        t.Fatal(err)
    }
    return string(contents)
}
```

当这种模式模糊了测试失败与导致失败的条件之间的联系时，请不要使用它。特别是，关于[断言库](#assert)的指导仍然适用，[`t.Helper`]不应该用于实现这样的库。

**提示：** 有关测试助手和断言助手之间区别的更多信息，请参阅[最佳实践](best-practices#test-functions)。

尽管上述内容提到了`*testing.T`，但对于基准测试和模糊测试助手，大部分建议仍然相同。

[`t.Helper`]: https://pkg.go.dev/testing#T.Helper

<a id="test-package"></a>

### 测试包

<a id="TOC-TestPackage"></a>

<a id="test-same-package"></a>

#### 同一包中的测试

测试可以定义在与被测试代码相同的包中。

要在同一包中编写测试：

*   将测试放在`foo_test.go`文件中
*   对测试文件使用`package foo`
*   不要显式导入要测试的包

```build
```markdown
# 良好：
go_library(
    name = "foo",
    srcs = ["foo.go"],
    deps = [
        ...
    ],
)

go_test(
    name = "foo_test",
    size = "small",
    srcs = ["foo_test.go"],
    library = ":foo",
    deps = [
        ...
    ],
)
```

同一个包中的测试可以访问包中的未导出标识符。这可能有助于提高测试覆盖率并使测试更加简洁。请注意，测试中声明的任何[示例]在用户代码中所需的包名将有所不同。

[`library`]: https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/rules.md#go_library
[示例]: #examples

<a id="test-different-package"></a>

#### 不同包中的测试

将测试定义在与被测试代码相同的包中并不总是合适或可能的。在这些情况下，请使用带有 `_test` 后缀的包名。这是对[包名](#package-names)“不使用下划线”规则的例外。例如：

*   如果集成测试没有明显所属的库

    ```go
    // 良好：
    package gmailintegration_test

    import "testing"
    ```

*   如果在同一包中定义测试会导致循环依赖

    ```go
    // 良好：
    package fireworks_test

    import (
      "fireworks"
      "fireworkstestutil" // fireworkstestutil 也导入 fireworks
    )
    ```

<a id="use-package-testing"></a>

### 使用 `testing` 包

Go 标准库提供了 [`testing` 包]。这是 Google 代码库中 Go 代码唯一允许的测试框架。特别是，[断言库](#assert)和第三方测试框架是不允许的。

`testing` 包为编写良好的测试提供了一套最小但完整的功能：

*   顶级测试
*   基准测试
*   [可运行示例](https://blog.golang.org/examples)
*   子测试
*   日志记录
*   失败和致命失败

这些功能设计为与核心语言特性（如[复合字面量]和[带初始化器的 if]语法）协同工作，使测试作者能够编写[清晰、可读和可维护的测试]。

[`testing` 包]: https://pkg.go.dev/testing
[复合字面量]: https://go.dev/ref/spec#Composite_literals
[带初始化器的 if]: https://go.dev/ref/spec#If_statements

<a id="non-decisions"></a>

## 非决策

风格指南无法对所有事项列出积极的规定，也无法列出所有它不提供意见的事项。尽管如此，以下是一些可读性社区之前讨论过但未达成共识的事项。

*   **使用零值初始化局部变量**。`var i int` 和 `i := 0` 是等价的。另见[初始化最佳实践]。
*   **空复合字面量与 `new` 或 `make`**。`&File{}` 和 `new(File)` 是等价的。`map[string]bool{}` 和 `make(map[string]bool)` 也是等价的。另见[复合声明最佳实践]。
*   **cmp.Diff 调用中的 got, want 参数顺序**。保持本地一致，并在失败消息中[包含图例](#print-diffs)。
*   **非格式化字符串上的 `errors.New` 与 `fmt.Errorf`**。`errors.New("foo")` 和 `fmt.Errorf("foo")` 可以互换使用。

如果在特殊情况下再次出现这些问题，可读性导师可能会提出可选的评论，但一般来说，作者可以自由选择在给定情况下喜欢的风格。

自然，如果风格指南未涵盖的任何内容需要更多讨论，作者欢迎提出问题——无论是在具体的审查中，还是在内部消息板上。

[复合声明最佳实践]: https://jqknono.github.io/styleguide/go/best-practices#vardeclcomposite
[初始化最佳实践]: https://jqknono.github.io/styleguide/go/best-practices#vardeclinitialization

<!--

-->

{% endraw %}
```