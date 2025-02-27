# Google C# 风格指南

本风格指南适用于 Google 内部开发的 C# 代码，并且是 Google C# 代码的默认风格。它做出的风格选择与 Google 的其他语言风格保持一致，例如 Google C++ 风格和 Google Java 风格。

## 格式化指南

### 命名规则

命名规则遵循 [Microsoft 的 C# 命名指南](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines)。在 Microsoft 的命名指南未指定的情况下（例如私有和局部变量），规则取自 [CoreFX C# 编码指南](https://github.com/dotnet/runtime/blob/HEAD/docs/coding-guidelines/coding-style.md)。

规则摘要：

#### 代码

*   类、方法、枚举、公共字段、公共属性的名称，命名空间：`PascalCase`。
*   局部变量、参数的名称：`camelCase`。
*   私有、受保护、内部和受保护内部字段和属性的名称：`_camelCase`。
*   命名约定不受 `const`、`static`、`readonly` 等修饰符的影响。
*   对于大小写，一个“单词”是指任何没有内部空格的内容，包括缩写。例如，`MyRpc` 而不是 ~~`MyRPC`~~。
*   接口名称以 `I` 开头，例如 `IInterface`。

#### 文件

*   文件名和目录名使用 `PascalCase`，例如 `MyFile.cs`。
*   尽可能使文件名与文件中主要类的名称相同，例如 `MyClass.cs`。
*   一般情况下，建议每个文件包含一个核心类。

### 组织

*   修饰符按以下顺序排列：`public protected internal private new abstract virtual override sealed static readonly extern unsafe volatile async`。
*   `using` 声明放在顶部，在任何命名空间之前。`using` 导入顺序按字母顺序排列，但 `System` 导入始终放在最前面。
*   类成员排序：
    *   按以下顺序对类成员进行分组：
        *   嵌套类、枚举、委托和事件。
        *   静态、常量和只读字段。
        *   字段和属性。
        *   构造函数和终结器。
        *   方法。
    *   在每个组内，元素应按以下顺序排列：
        *   公共。
        *   内部。
        *   受保护内部。
        *   受保护。
        *   私有。
    *   尽可能将接口实现分组在一起。

### 空白规则

从 Google Java 风格发展而来。

*   每行最多一个语句。
*   每条语句最多一个赋值。
*   缩进为 2 个空格，不使用制表符。
*   列限制：100。
*   不要在左大括号前换行。
*   不要在右大括号和 `else` 之间换行。
*   即使可选，也要使用大括号。
*   在 `if`/`for`/`while` 等之后，以及逗号之后使用空格。
*   在左括号后和右括号前不使用空格。
*   一元运算符和其操作数之间不使用空格。所有其他运算符和其每个操作数之间使用一个空格。
*   换行规则从 Google C++ 风格指南发展而来，并对 Microsoft 的 C# 格式化工具进行了少量修改以保持兼容性：
    *   一般情况下，换行继续时缩进 4 个空格。
    *   带有大括号的换行（例如列表初始化、lambda、对象初始化等）不视为继续。
    *   对于函数定义和调用，如果参数不能在一行内全部显示，应将其分成多行，每个后续行与第一个参数对齐。如果没有足够的空间，可以将参数放在后续行上，并使用 4 个空格缩进。下面的代码示例说明了这一点。

### 示例

```c#
using System;                                       // `using` 放在顶部，命名空间之外。

namespace MyNamespace {                             // 命名空间使用 PascalCase。
                                                    // 命名空间后缩进。
  public interface IMyInterface {                   // 接口以 'I' 开头
    public int Calculate(float value, float exp);   // 方法使用 PascalCase
                                                    // ...并在逗号后使用空格。
  }

  public enum MyEnum {                              // 枚举使用 PascalCase。
    Yes,                                            // 枚举项使用 PascalCase。
    No,
  }

  public class MyClass {                            // 类使用 PascalCase。
    public int Foo = 0;                             // 公共成员变量使用 PascalCase。
    public bool NoCounting = false;                 // 鼓励使用字段初始化器。
    private class Results {
      public int NumNegativeResults = 0;
      public int NumPositiveResults = 0;
    }
    private Results _results;                       // 私有成员变量使用 _camelCase。
    public static int NumTimesCalled = 0;
    private const int _bar = 100;                   // const 不影响命名约定。
    private int[] _someTable = {                    // 容器初始化器使用 2 个空格缩进。
      2, 3, 4,                                      // 2 个空格缩进。
    }

    public MyClass() {
      _results = new Results {
        NumNegativeResults = 1,                     // 对象初始化器使用 2 个空格缩进。
        NumPositiveResults = 1,                     // 2 个空格缩进。
      };
    }

    public int CalculateValue(int mulNumber) {      // 左大括号前不换行。
      var resultValue = Foo * mulNumber;            // 局部变量使用 camelCase。
      NumTimesCalled++;
      Foo += _bar;

      if (!NoCounting) {                            // 一元运算符后不使用空格，'if' 后使用空格。
        if (resultValue < 0) {                      // 即使可选，也使用大括号，比较运算符周围使用空格。
          _results.NumNegativeResults++;
        } else if (resultValue > 0) {               // 右大括号和 else 之间不换行。
          _results.NumPositiveResults++;
        }
      }

      return resultValue;
    }

    public void ExpressionBodies() {
      // 对于简单的 lambda，尽可能在一行内完成，不需要括号或大括号。
      Func<int, int> increment = x => x + 1;

      // 右大括号与包含左大括号的行的第一个字符对齐。
      Func<int, int, long> difference1 = (x, y) => {
        long diff = (long)x - y;
        return diff >= 0 ? diff : -diff;
      };

      // 如果在继续换行后定义，缩进整个主体。
      Func<int, int, long> difference2 =
          (x, y) => {
            long diff = (long)x - y;
            return diff >= 0 ? diff : -diff;
          };

      // 内联 lambda 参数也遵循这些规则。如果参数中包含 lambda，首选在参数组前添加换行。
      CallWithDelegate(
          (x, y) => {
            long diff = (long)x - y;
            return diff >= 0 ? diff : -diff;
          });
    }

    void DoNothing() {}                             // 空块可以简洁。

    // 如果可能，通过与第一个参数对齐来换行。
    void AVeryLongFunctionNameThatCausesLineWrappingProblems(int longArgumentName,
                                                             int p1, int p2) {}

    // 如果与第一个参数对齐的参数行不适合，或者难以阅读，将所有参数换行并使用 4 个空格缩进。
    void AnotherLongFunctionNameThatCausesLineWrappingProblems(
        int longArgumentName, int longArgumentName2, int longArgumentName3) {}

    void CallingLongFunctionName() {
      int veryLongArgumentName = 1234;
      int shortArg = 1;
      // 如果可能，通过与第一个参数对齐来换行。
      AnotherLongFunctionNameThatCausesLineWrappingProblems(shortArg, shortArg,
                                                            veryLongArgumentName);
      // 如果与第一个参数对齐的参数行不适合，或者难以阅读，将所有参数换行并使用 4 个空格缩进。
      AnotherLongFunctionNameThatCausesLineWrappingProblems(
          veryLongArgumentName, veryLongArgumentName, veryLongArgumentName);
    }
  }
}
```

## C# 编码指南

### 常量

*   可以使用 `const` 的变量和字段应始终使用 `const`。
*   如果不能使用 `const`，`readonly` 可以是一个合适的替代方案。
*   首选命名常量而不是魔法数字。

### IEnumerable vs IList vs IReadOnlyList

*   对于输入，尽可能使用最严格的集合类型，例如在方法输入中使用 `IReadOnlyCollection` / `IReadOnlyList` / `IEnumerable`，当输入应为不可变时。
*   对于输出，如果将返回的容器的所有权传递给所有者，首选 `IList` 而不是 `IEnumerable`。如果不转移所有权，首选最严格的选项。

### 生成器 vs 容器

*   使用您的最佳判断，考虑以下几点：
    *   生成器代码通常比填充容器的代码可读性差。
    *   如果结果将被惰性处理，生成器代码可能更高效，例如当不需要所有结果时。
    *   通过 `ToList()` 直接转换为容器的生成器代码将比直接填充容器的性能更差。
    *   多次调用的生成器代码将比多次迭代容器的速度慢得多。

### 属性样式

*   对于单行只读属性，尽可能使用表达式主体属性 (`=>`)。
*   对于其他情况，使用旧的 `{ get; set; }` 语法。

### 表达式主体语法

例如：

```c#
int SomeProperty => _someProperty
```

*   在 lambda 和属性中谨慎使用表达式主体语法。
*   不要在方法定义上使用。这将在 C# 7 发布时进行审查，该版本大量使用此语法。
*   与方法和其他范围代码块一样，将右大括号与包含左大括号的行的第一个字符对齐。请参阅示例代码。

### 结构和类：

*   结构与类非常不同：

    *   结构总是按值传递和返回。
    *   为返回的结构的成员赋值不会修改原始值 - 例如，`transform.position.x = 10` 不会将变换的 `position.x` 设置为 10；这里的 `position` 是一个按值返回 `Vector3` 的属性，因此这只是设置了原始值的副本的 x 参数。

*   几乎总是使用类。

*   当类型可以像其他值类型一样处理时考虑使用结构 - 例如，如果类型的实例较小且通常是短暂的，或者通常嵌入在其他对象中。好的例子包括 Vector3、Quaternion 和 Bounds。

*   请注意，此指导可能会因团队而异，例如，性能问题可能需要使用结构。

### Lambda vs 命名方法

*   如果 lambda 非平凡（例如，除了声明之外有几个语句），或者在多个地方重用，它可能应该是一个命名方法。

### 字段初始化器

*   一般鼓励使用字段初始化器。

### 扩展方法

*   只有在原始类的源不可用，或者更改源不可行时，才使用扩展方法。
*   只有在添加的功能是适合添加到原始类的源的“核心”通用功能时，才使用扩展方法。
    *   注意 - 如果我们有被扩展类的源，并且原始类的维护者不希望添加该功能，建议不使用扩展方法。
*   只能将扩展方法放入到处可用的核心库中 - 仅在某些代码中可用的扩展将成为可读性问题。
*   请注意，使用扩展方法总是会使代码变得模糊，因此倾向于不添加它们。

### ref 和 out

*   使用 `out` 用于不是输入的返回值。
*   在方法定义中，将 `out` 参数放在所有其他参数之后。
*   `ref` 应在需要修改输入时谨慎使用。
*   不要将 `ref` 用作传递结构的优化。
*   不要使用 `ref` 将可修改的容器传递给方法。只有在需要用完全不同的容器实例替换提供的容器时才需要 `ref`。

### LINQ

*   一般来说，首选单行 LINQ 调用和命令式代码，而不是长链的 LINQ。混合命令式代码和大量链式 LINQ 通常难以阅读。
*   首选成员扩展方法而不是 SQL 风格的 LINQ 关键字 - 例如，首选 `myList.Where(x)` 而不是 `myList where x`。
*   避免对超过单个语句的任何内容使用 `Container.ForEach(...)`。

### 数组 vs 列表

*   一般来说，对于公共变量、属性和返回类型，首选 `List<>` 而不是数组（请记住上面关于 `IList` / `IEnumerable` / `IReadOnlyList` 的指导）。
*   当容器的大小可以更改时，首选 `List<>`。
*   当容器的大小在构造时固定且已知时，首选数组。
*   对于多维数组，首选数组。
*   注意：
    *   数组和 `List<>` 都表示线性、连续的容器。
    *   类似于 C++ 中的数组与 `std::vector`，数组具有固定容量，而 `List<>` 可以添加。
    *   在某些情况下，数组的性能更高，但在一般情况下，`List<>` 更灵活。

### 文件夹和文件位置

*   与项目保持一致。
*   尽可能首选扁平结构。

### 使用元组作为返回类型

*   一般来说，首选命名类类型而不是 `Tuple<>`，特别是在返回复杂类型时。

### 字符串插值 vs `String.Format()` vs `String.Concat` vs `operator+`

*   一般来说，使用最易读的方式，特别是对于日志和断言消息。
*   请注意，链式 `operator+` 连接将更慢并导致显著的内存消耗。
*   如果性能是一个问题，对于多次字符串连接，`StringBuilder` 将更快。

### `using`

*   一般来说，不要使用 `using` 别名长类型名称。通常这是一个将 `Tuple<>` 转换为类的信号。
    *   例如，`using RecordList = List<Tuple<int, float>>` 应该改为命名类。
*   请注意，`using` 语句仅在文件范围内有效，因此用途有限。类型别名对外部用户不可用。

### 对象初始化器语法

例如：

```c#
var x = new SomeClass {
  Property1 = value1,
  Property2 = value2,
};
```

*   对象初始化器语法适用于“纯旧数据”类型。
*   避免对具有构造函数的类或结构使用此语法。
*   如果跨多行拆分，缩进一个块级别。

### 命名空间命名

*   一般来说，命名空间不应超过 2 级深度。
*   不要强制文件/文件夹布局与命名空间匹配。
*   对于共享库/模块代码，使用命名空间。对于叶子“应用程序”代码，例如 `unity_app`，不需要命名空间。
*   新顶级命名空间名称必须是全局唯一且可识别的。

### 结构的默认值/空返回

*   首选返回一个“成功”布尔值和一个结构 `out` 值。
*   在性能不是问题且结果代码显著更可读的情况下（例如，链式空条件运算符与深度嵌套的 if 语句），可接受的结构是可空的。
*   注意：

    *   可空结构方便，但强化了 Google 倾向于避免的“空表示失败”模式。我们将在未来调查一个 `StatusOr` 等效物，如果有足够的需求。

### 在迭代时从容器中移除

C#（像许多其他语言一样）没有提供在迭代时从容器中移除项目的明显机制。有几种选择：

*   如果只需要移除满足某些条件的项目，推荐使用 `someList.RemoveAll(somePredicate)`。
*   如果在迭代中需要执行其他工作，`RemoveAll` 可能不足以满足需求。一个常见的替代模式是在循环外创建一个新容器，在新容器中插入要保留的项目，并在迭代结束时用新容器替换原始容器。

### 调用委托

*   在调用委托时，使用 `Invoke()` 并使用空条件运算符 - 例如，`SomeDelegate?.Invoke()`。这清楚地标记了调用点为“正在调用的委托”。空检查简洁且对线程竞争条件具有鲁棒性。

### `var` 关键字

*   如果 `var` 有助于通过避免嘈杂、明显或不重要的类型名称来提高可读性，则鼓励使用 `var`。
*   鼓励：

    *   当类型明显时 - 例如，`var apple = new Apple();`，或 `var request = Factory.Create<HttpRequest>();`
    *   对于仅直接传递给其他方法的临时变量 - 例如，`var item = GetItem(); ProcessItem(item);`

*   不鼓励：

    *   当处理基本类型时 - 例如，`var success = true;`
    *   当处理编译器解析的内置数字类型时 - 例如，`var number = 12 * ReturnsFloat();`
    *   当用户显然会从知道类型中受益时 - 例如，`var listOfItems = GetList();`

### 属性

*   属性应出现在与其关联的字段、属性或方法的上方一行，并通过换行与成员分隔。
*   多个属性应通过换行分隔。这使得添加和删除属性更容易，并确保每个属性易于搜索。

### 参数命名

源自 Google C++ 风格指南。

当函数参数的含义不明显时，请考虑以下补救措施之一：

*   如果参数是字面常量，并且在多个函数调用中以相同的方式使用，以至于隐式假设它们是相同的，请使用命名常量来明确此约束，并保证其成立。
*   考虑更改函数签名，将 `bool` 参数替换为 `enum` 参数。这将使参数值自描述。
*   用命名变量替换大型或复杂的嵌套表达式。
*   考虑使用 [命名参数](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/named-and-optional-arguments) 来澄清调用点的参数含义。
*   对于具有多个配置选项的函数，考虑定义一个单一类或结构来保存所有选项，并传递该选项的实例。这种方法有几个优点。选项在调用点按名称引用，这澄清了它们的含义。它还减少了函数参数数量，使函数调用更易读和编写。作为额外的好处，调用点在添加另一个选项时无需更改。

考虑以下示例：

```c#
// 不好 - 这些参数是什么？
DecimalNumber product = CalculateProduct(values, 7, false, null);
```

与：

```c#
// 好
ProductOptions options = new ProductOptions();
options.PrecisionDecimals = 7;
options.UseCache = CacheUsage.DontUseCache;
DecimalNumber product = CalculateProduct(values, options, completionDelegate: null);
```