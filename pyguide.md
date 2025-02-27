<!--
作者：
在外部文本中请优先使用 GitHub 风格的 Markdown。
详情请见 README.md。
-->
# Google Python 风格指南

<!-- markdown="1" 是 GitHub Pages 正确渲染目录所必需的。 -->

<details markdown="1">
  <summary>目录</summary>

-   [1 背景](#s1-background)
-   [2 Python 语言规则](#s2-python-language-rules)
    *   [2.1 Lint](#s2.1-lint)
    *   [2.2 导入](#s2.2-imports)
    *   [2.3 包](#s2.3-packages)
    *   [2.4 异常](#s2.4-exceptions)
    *   [2.5 可变全局状态](#s2.5-global-variables)
    *   [2.6 嵌套/局部/内部类和函数](#s2.6-nested)
    *   [2.7 列表解析与生成器表达式](#s2.7-comprehensions)
    *   [2.8 默认迭代器和操作符](#s2.8-default-iterators-and-operators)
    *   [2.9 生成器](#s2.9-generators)
    *   [2.10 Lambda 函数](#s2.10-lambda-functions)
    *   [2.11 条件表达式](#s2.11-conditional-expressions)
    *   [2.12 默认参数值](#s2.12-default-argument-values)
    *   [2.13 属性](#s2.13-properties)
    *   [2.14 True/False 评估](#s2.14-truefalse-evaluations)
    *   [2.16 词法作用域](#s2.16-lexical-scoping)
    *   [2.17 函数和方法装饰器](#s2.17-function-and-method-decorators)
    *   [2.18 线程](#s2.18-threading)
    *   [2.19 高级特性](#s2.19-power-features)
    *   [2.20 现代 Python：从 __future__ 导入](#s2.20-modern-python)
    *   [2.21 类型注解代码](#s2.21-type-annotated-code)
-   [3 Python 风格规则](#s3-python-style-rules)
    *   [3.1 分号](#s3.1-semicolons)
    *   [3.2 行长度](#s3.2-line-length)
    *   [3.3 括号](#s3.3-parentheses)
    *   [3.4 缩进](#s3.4-indentation)
        +   [3.4.1 序列项的尾随逗号？](#s3.4.1-trailing-commas)
    *   [3.5 空行](#s3.5-blank-lines)
    *   [3.6 空格](#s3.6-whitespace)
    *   [3.7 Shebang 行](#s3.7-shebang-line)
    *   [3.8 注释和文档字符串](#s3.8-comments-and-docstrings)
        +   [3.8.1 文档字符串](#s3.8.1-comments-in-doc-strings)
        +   [3.8.2 模块](#s3.8.2-comments-in-modules)
        +   [3.8.2.1 测试模块](#s3.8.2.1-test-modules)
        +   [3.8.3 函数和方法](#s3.8.3-functions-and-methods)
        +   [3.8.3.1 重写方法](#s3.8.3.1-overridden-methods)
        +   [3.8.4 类](#s3.8.4-comments-in-classes)
        +   [3.8.5 块和内联注释](#s3.8.5-block-and-inline-comments)
        +   [3.8.6 标点符号、拼写和语法](#s3.8.6-punctuation-spelling-and-grammar)
    *   [3.10 字符串](#s3.10-strings)
        +   [3.10.1 日志记录](#s3.10.1-logging)
        +   [3.10.2 错误消息](#s3.10.2-error-messages)
    *   [3.11 文件、套接字及类似有状态资源](#s3.11-files-sockets-closeables)
    *   [3.12 TODO 注释](#s3.12-todo-comments)
    *   [3.13 导入格式](#s3.13-imports-formatting)
    *   [3.14 语句](#s3.14-statements)
    *   [3.15 访问器](#s3.15-accessors)
    *   [3.16 命名](#s3.16-naming)
        +   [3.16.1 应避免的名称](#s3.16.1-names-to-avoid)
        +   [3.16.2 命名约定](#s3.16.2-naming-conventions)
        +   [3.16.3 文件命名](#s3.16.3-file-naming)
        +   [3.16.4 源自 Guido 建议的指导原则](#s3.16.4-guidelines-derived-from-guidos-recommendations)
    *   [3.17 主函数](#s3.17-main)
    *   [3.18 函数长度](#s3.18-function-length)
    *   [3.19 类型注解](#s3.19-type-annotations)
        +   [3.19.1 通用规则](#s3.19.1-general-rules)
        +   [3.19.2 换行](#s3.19.2-line-breaking)
        +   [3.19.3 前向声明](#s3.19.3-forward-declarations)
        +   [3.19.4 默认值](#s3.19.4-default-values)
        +   [3.19.5 NoneType](#s3.19.5-nonetype)
        +   [3.19.6 类型别名](#s3.19.6-type-aliases)
        +   [3.19.7 忽略类型](#s3.19.7-ignoring-types)
        +   [3.19.8 变量类型](#s3.19.8-typing-variables)
        +   [3.19.9 元组与列表](#s3.19.9-tuples-vs-lists)
        +   [3.19.10 类型变量](#s3.19.10-typevars)
        +   [3.19.11 字符串类型](#s3.19.11-string-types)
</details>
+   [3.19.12 用于类型注解的导入](#s3.19.12-imports-for-typing)
+   [3.19.13 条件导入](#s3.19.13-conditional-imports)
+   [3.19.14 循环依赖](#s3.19.14-circular-dependencies)
+   [3.19.15 泛型](#s3.19.15-generics)
+   [3.19.16 构建依赖](#s3.19.16-build-dependencies)
-   [4 结束语](#4-parting-words)

</details>

<a id="s1-background"></a>
<a id="1-background"></a>

<a id="background"></a>
## 1 背景 

Python 是 Google 使用的主要动态语言。本风格指南列出了 Python 程序的 *应做与不应做* 清单。

为了帮助您正确格式化代码，我们创建了一个 [Vim 设置文件](google_python_style.vim)。对于 Emacs，默认设置应该没问题。

许多团队使用 [Black](https://github.com/psf/black) 或 [Pyink](https://github.com/google/pyink) 自动格式化工具，以避免在格式上争论不休。


<a id="s2-python-language-rules"></a>
<a id="2-python-language-rules"></a>

<a id="python-language-rules"></a>
## 2 Python 语言规则 

<a id="s2.1-lint"></a>
<a id="21-lint"></a>

<a id="lint"></a>
### 2.1 Lint 

使用此 [pylintrc](https://google.github.io/styleguide/pylintrc) 运行 `pylint` 检查您的代码。

<a id="s2.1.1-definition"></a>
<a id="211-definition"></a>

<a id="lint-definition"></a>
#### 2.1.1 定义 

`pylint` 是一个用于查找 Python 源代码中的错误和风格问题的工具。它能发现通常由编译器在像 C 和 C++ 这样不太动态的语言中捕获的问题。由于 Python 的动态特性，一些警告可能不准确；然而，虚假警告应该相当少见。

<a id="s2.1.2-pros"></a>
<a id="212-pros"></a>

<a id="lint-pros"></a>
#### 2.1.2 优点 

捕捉容易错过的错误，如拼写错误、使用变量前未赋值等。

<a id="s2.1.3-cons"></a>
<a id="213-cons"></a>

<a id="lint-cons"></a>
#### 2.1.3 缺点 

`pylint` 并非完美。为了利用它，有时我们需要绕过它，抑制其警告或修复它。

<a id="s2.1.4-decision"></a>
<a id="214-decision"></a>

<a id="lint-decision"></a>
#### 2.1.4 决定 

确保在您的代码上运行 `pylint`。

如果警告不恰当，请抑制警告，以免其他问题被隐藏。要抑制警告，您可以设置行级注释：

```python
def do_PUT(self):  # WSGI 名称，因此 pylint: disable=invalid-name
  ...
```

`pylint` 警告都由符号名称标识（如 `empty-docstring`），Google 特定的警告以 `g-` 开头。

如果抑制的原因从符号名称中不清楚，请添加解释。

以这种方式抑制有助于我们轻松搜索抑制并重新审视它们。

您可以通过以下命令获取 `pylint` 警告列表：

```shell
pylint --list-msgs
```

要获取特定消息的更多信息，请使用：

```shell
pylint --help-msg=invalid-name
```

优先使用 `pylint: disable`，而不是已废弃的旧形式 `pylint: disable-msg`。

可以通过在函数开始处删除变量来抑制未使用参数警告。始终包含一个解释您为何删除它的注释。“未使用。”就足够了。例如：

```python
def viking_cafe_order(spam: str, beans: str, eggs: str | None = None) -> str:
    del beans, eggs  # 维京人不使用。
    return spam + spam + spam
```

其他常见的抑制此警告的方式包括使用 '`_`' 作为未使用参数的标识符，或在参数名前加上 '`unused_`'，或将它们赋值给 '`_`'。这些形式被允许，但不再鼓励。这些会破坏按名称传递参数的调用者，并且不强制参数实际上未被使用。

<a id="s2.2-imports"></a>
<a id="22-imports"></a>

<a id="imports"></a>
### 2.2 导入

仅对包和模块使用 `import` 语句，而不对单个类型、类或函数使用。

<a id="s2.2.1-definition"></a>
<a id="221-definition"></a>

<a id="imports-definition"></a>
#### 2.2.1 定义

用于在不同模块之间共享代码的可重用性机制。

<a id="s2.2.2-pros"></a>
<a id="222-pros"></a>

<a id="imports-pros"></a>
#### 2.2.2 优点

命名空间管理约定简单。每种标识符的来源以一致的方式指示；`x.Obj` 表示对象 `Obj` 在模块 `x` 中定义。

<a id="s2.2.3-cons"></a>
<a id="223-cons"></a>

<a id="imports-cons"></a>
#### 2.2.3 缺点

模块名称仍可能发生冲突。有些模块名称过长，使用不便。

<a id="s2.2.4-decision"></a>
<a id="224-decision"></a>

<a id="imports-decision"></a>
#### 2.2.4 决策

*   使用 `import x` 来导入包和模块。
*   使用 `from x import y`，其中 `x` 是包前缀，`y` 是没有前缀的模块名称。
*   在以下任何情况下使用 `from x import y as z`：
    -   需要导入两个名为 `y` 的模块。
    -   `y` 与当前模块中定义的顶级名称冲突。
    -   `y` 与公共 API 的一部分常用参数名称冲突（例如，`features`）。
    -   `y` 名称过长，使用不便。
    -   `y` 在代码上下文中过于通用（例如，`from storage.file_system import options as fs_options`）。
*   仅当 `z` 是标准缩写时使用 `import y as z`（例如，`import numpy as np`）。

例如，模块 `sound.effects.echo` 可以按以下方式导入：

```python
from sound.effects import echo
...
echo.EchoFilter(input, output, delay=0.7, atten=4)
```

在导入时不要使用相对名称。即使模块在同一个包中，也要使用完整的包名称。这有助于防止意外地导入同一个包两次。

<a id="imports-exemptions"></a>
##### 2.2.4.1 例外情况

此规则的例外情况包括：

*   使用以下模块中的符号来支持静态分析和类型检查：
    *   [`typing` 模块](#typing-imports)
    *   [`collections.abc` 模块](#typing-imports)
    *   [`typing_extensions` 模块](https://github.com/python/typing_extensions/blob/main/README.md)
*   [six.moves 模块](https://six.readthedocs.io/#module-six.moves)的重定向。

<a id="s2.3-packages"></a>
<a id="23-packages"></a>

<a id="packages"></a>
### 2.3 包

使用模块的完整路径名称来导入每个模块。

<a id="s2.3.1-pros"></a>
<a id="231-pros"></a>

<a id="packages-pros"></a>
#### 2.3.1 优点

避免由于模块搜索路径与作者预期不符而导致的模块名称冲突或错误导入。使查找模块变得更容易。

<a id="s2.3.2-cons"></a>
<a id="232-cons"></a>

<a id="packages-cons"></a>
#### 2.3.2 缺点

使代码部署变得更加困难，因为需要复制包层次结构。但在现代部署机制下这不是真正的问题。

<a id="s2.3.3-decision"></a>
<a id="233-decision"></a>

<a id="packages-decision"></a>
#### 2.3.3 决策

所有新代码应通过其完整的包名称来导入每个模块。

导入应如下进行：

```python
Yes:
  # 在代码中使用完整名称引用 absl.flags（冗长）。
  import absl.flags
  from doctor.who import jodie

  _FOO = absl.flags.DEFINE_string(...)
```

```python
Yes:
  # 在代码中仅使用模块名称引用 flags（常见）。
  from absl import flags
  from doctor.who import jodie

  _FOO = flags.DEFINE_string(...)
```

*(假设此文件位于 `doctor/who/` 目录中，且 `jodie.py` 也存在于该目录)*

```python
No:
  # 不清楚作者想要导入哪个模块以及将导入什么。实际的导入行为依赖于控制 sys.path 的外部因素。
  # 作者打算导入哪个可能的 jodie 模块？
  import jodie
```

不应假设主二进制文件所在的目录在 `sys.path` 中，尽管在某些环境中会发生这种情况。因此，代码应假设 `import jodie` 指的是名为 `jodie` 的第三方或顶级包，而不是本地 `jodie.py`。

<a id="s2.4-exceptions"></a>
<a id="24-exceptions"></a>

<a id="exceptions"></a>
### 2.4 异常

允许使用异常，但必须谨慎使用。

<a id="s2.4.1-definition"></a>
<a id="241-definition"></a>

<a id="exceptions-definition"></a>
#### 2.4.1 定义

异常是一种打破正常控制流程以处理错误或其他异常情况的手段。

<a id="s2.4.2-pros"></a>
<a id="242-pros"></a>

<a id="exceptions-pros"></a>
#### 2.4.2 优点

正常操作代码的控制流程不会被错误处理代码所干扰。它还允许在特定条件发生时跳过多个框架，例如，从N个嵌套函数中一步返回，而不是必须通过传递错误代码。

<a id="s2.4.3-cons"></a>
<a id="243-cons"></a>

<a id="exceptions-cons"></a>
#### 2.4.3 缺点

可能会导致控制流程混乱。在进行库调用时容易遗漏错误情况。

<a id="s2.4.4-decision"></a>
<a id="244-decision"></a>

<a id="exceptions-decision"></a>
#### 2.4.4 决策

异常必须遵循某些条件：

-   在合理的情况下使用内置的异常类。例如，引发 `ValueError` 来指示编程错误，如违反前置条件，这可能在验证函数参数时发生。

-   不要用 `assert` 语句代替条件语句或验证前置条件。它们不得是应用程序逻辑的关键。一种试金石是，`assert` 可以被移除而不会破坏代码。`assert` 条件语句
    [不保证](https://docs.python.org/3/reference/simple_stmts.html#the-assert-statement)
    被评估。对于基于 [pytest](https://pytest.org) 的测试，`assert` 是可以的，并且期望用于验证期望。例如：

    
    ```python
    Yes:
      def connect_to_next_port(self, minimum: int) -> int:
        """连接到下一个可用端口。

        参数:
          minimum: 大于或等于 1024 的端口值。

        返回:
          新的最小端口。

        引发:
          ConnectionError: 如果没有找到可用端口。
        """
        if minimum < 1024:
          # 注意，此处引发 ValueError 并未在文档字符串的 "引发:" 部分中提及，因为不适合保证这种特定行为反应到 API 误用。
          raise ValueError(f'最小端口必须至少为 1024，而不是 {minimum}。')
        port = self._find_next_open_port(minimum)
        if port is None:
          raise ConnectionError(
              f'无法连接到端口 {minimum} 或更高的服务。')
        # 代码不依赖于这个 assert 的结果。
        assert port >= minimum, (
            f'当最小值为 {minimum} 时，意外端口 {port}。')
        return port
    ```

    ```python
    No:
      def connect_to_next_port(self, minimum: int) -> int:
        """连接到下一个可用端口。

        参数:
          minimum: 大于或等于 1024 的端口值。

        返回:
          新的最小端口。
        """
        assert minimum >= 1024, '最小端口必须至少为 1024。'
        # 以下代码依赖于前面的 assert。
        port = self._find_next_open_port(minimum)
        assert port is not None
        # 返回语句的类型检查依赖于 assert。
        return port
    ```


-   库或包可以定义自己的异常。在这样做时，它们必须从现有的异常类继承。异常名称应以 `Error` 结尾，并且不应引入重复（`foo.FooError`）。

-   永远不要使用捕获所有异常的 `except:` 语句，或者捕获 `Exception` 或 `StandardError`，除非你正在

    -   重新引发异常，或者
    -   在程序中创建一个隔离点，在该点异常不会传播，而是被记录和抑制，例如，通过保护其最外层块来防止线程崩溃。

    Python 在这一点上非常宽容，`except:` 确实会捕获所有内容，包括拼写错误的名称、`sys.exit()` 调用、Ctrl+C 中断、单元测试失败以及你根本不想捕获的各种其他异常。

-   尽量减少 `try`/`except` 块中的代码量。`try` 块的主体越大，越有可能由你没想到会引发异常的代码行引发异常。在这些情况下，`try`/`except` 块隐藏了真正的错误。

-   使用 `finally` 子句来执行代码，无论 `try` 块中是否引发了异常。这通常用于清理，例如，关闭文件。

<a id="s2.5-global-variables"></a>
<a id="25-global-variables"></a>
<a id="s2.5-global-state"></a>
<a id="25-global-state"></a>

<a id="global-variables"></a>
### 2.5 可变全局状态

避免使用可变全局状态。

<a id="s2.5.1-definition"></a>
<a id="251-definition"></a>

<a id="global-variables-definition"></a>
#### 2.5.1 定义

在程序执行过程中可以被修改的模块级值或类属性。

<a id="s2.5.2-pros"></a>
<a id="252-pros"></a>

<a id="global-variables-pros"></a>
#### 2.5.2 优点

偶尔有用。

<a id="s2.5.3-cons"></a>
<a id="253-cons"></a>

<a id="global-variables-cons"></a>
#### 2.5.3 缺点

*   破坏封装：这种设计可能难以实现有效的目标。例如，如果使用全局状态来管理数据库连接，那么同时连接到两个不同的数据库（例如在迁移过程中计算差异）会变得困难。使用全局注册表时也容易出现类似问题。

*   在导入时可能改变模块行为，因为对全局变量的赋值是在模块首次导入时完成的。

<a id="s2.5.4-decision"></a>
<a id="254-decision"></a>

<a id="global-variables-decision"></a>
#### 2.5.4 决策

避免使用可变全局状态。

在极少数需要使用全局状态的情况下，可变全局实体应在模块级别或作为类属性声明，并通过在名称前加上 `_` 使其成为内部的。如果有必要，对可变全局状态的外部访问必须通过公共函数或类方法进行。参见下面的[命名](#s3.16-naming)。请在注释中或通过注释链接到文档中解释使用可变全局状态的设计原因。

模块级常量是允许且鼓励的。例如：`_MAX_HOLY_HANDGRENADE_COUNT = 3` 用于内部常量，或 `SIR_LANCELOTS_FAVORITE_COLOR = "blue"` 用于公共 API 常量。常量必须使用全大写字母和下划线命名。参见下面的[命名](#s3.16-naming)。

<a id="s2.6-nested"></a>
<a id="26-nested"></a>

<a id="nested-classes-functions"></a>
### 2.6 嵌套/局部/内部类和函数

当用于封闭局部变量时，嵌套局部函数或类是可以的。内部类也是可以的。

<a id="s2.6.1-definition"></a>
<a id="261-definition"></a>

<a id="nested-classes-functions-definition"></a>
#### 2.6.1 定义

类可以在方法、函数或类内部定义。函数可以在方法或函数内部定义。嵌套函数对封闭作用域中定义的变量具有只读访问权限。

<a id="s2.6.2-pros"></a>
<a id="262-pros"></a>

<a id="nested-classes-functions-pros"></a>
#### 2.6.2 优点

允许定义仅在非常有限的范围内使用的实用类和函数。非常符合[抽象数据类型](https://en.wikipedia.org/wiki/Abstract_data_type)的风格。常用于实现装饰器。

<a id="s2.6.3-cons"></a>
<a id="263-cons"></a>

<a id="nested-classes-functions-cons"></a>
#### 2.6.3 缺点

嵌套函数和类无法直接测试。嵌套可能会使外部函数更长且可读性降低。

<a id="s2.6.4-decision"></a>
<a id="264-decision"></a>

<a id="nested-classes-functions-decision"></a>
#### 2.6.4 决策

它们是可以接受的，但有一些注意事项。除非封闭的是 `self` 或 `cls` 之外的局部值，否则避免使用嵌套函数或类。不要仅仅为了对模块用户隐藏函数而嵌套函数。相反，在模块级别为其名称加上 `_` 前缀，以便测试仍然可以访问它。

<a id="s2.7-comprehensions"></a>
<a id="s2.7-list_comprehensions"></a>
<a id="27-list_comprehensions"></a>
<a id="list_comprehensions"></a>
<a id="list-comprehensions"></a>

<a id="comprehensions"></a>
### 2.7 推导式与生成器表达式

在简单情况下可以使用。

<a id="s2.7.1-definition"></a>
<a id="271-definition"></a>

<a id="comprehensions-definition"></a>
#### 2.7.1 定义

列表、字典和集合推导式以及生成器表达式提供了一种简洁且高效的方式来创建容器类型和迭代器，而无需使用传统的循环、`map()`、`filter()` 或 `lambda`。

<a id="s2.7.2-pros"></a>
<a id="272-pros"></a>

<a id="comprehensions-pros"></a>
#### 2.7.2 优点

简单的推导式可以比其他创建字典、列表或集合的方法更清晰和简单。生成器表达式非常高效，因为它们完全避免了列表的创建。

<a id="s2.7.3-cons"></a>
<a id="273-cons"></a>

<a id="comprehensions-cons"></a>
#### 2.7.3 缺点

复杂的推导式或生成器表达式可能难以阅读。

<a id="s2.7.4-decision"></a>
<a id="274-decision"></a>

<a id="comprehensions-decision"></a>
#### 2.7.4 决策

允许使用推导式，但不允许使用多个 `for` 子句或过滤表达式。优化可读性，而非简洁性。

```python
Yes:
  result = [mapping_expr for value in iterable if filter_expr]

  result = [
      is_valid(metric={'key': value})
      for value in interesting_iterable
      if a_longer_filter_expression(value)
  ]

  descriptive_name = [
      transform({'key': key, 'value': value}, color='black')
      for key, value in generate_iterable(some_input)
      if complicated_condition_is_met(key, value)
  ]

  result = []
  for x in range(10):
    for y in range(5):
      if x * y > 10:
        result.append((x, y))

  return {
      x: complicated_transform(x)
      for x in long_generator_function(parameter)
      if x is not None
  }

  return (x**2 for x in range(10))

  unique_names = {user.name for user in users if user is not None}
```

```python
No:
  result = [(x, y) for x in range(10) for y in range(5) if x * y > 10]

  return (
      (x, y, z)
      for x in range(5)
      for y in range(5)
      if x != y
      for z in range(5)
      if y != z
  )
```

<a id="s2.8-default-iterators-and-operators"></a>

<a id="default-iterators-operators"></a>
### 2.8 默认迭代器和操作符

对于支持它们的类型，如列表、字典和文件，使用默认迭代器和操作符。

<a id="s2.8.1-definition"></a>
<a id="281-definition"></a>

<a id="default-iterators-operators-definition"></a>
#### 2.8.1 定义

像字典和列表这样的容器类型定义了默认迭代器和成员测试操作符（"in" 和 "not in"）。

<a id="s2.8.2-pros"></a>
<a id="282-pros"></a>

<a id="default-iterators-operators-pros"></a>
#### 2.8.2 优点

默认迭代器和操作符简单且高效。它们直接表达操作，无需额外的方法调用。使用默认操作符的函数是通用的，可以与任何支持该操作的类型一起使用。

<a id="s2.8.3-cons"></a>
<a id="283-cons"></a>

<a id="default-iterators-operators-cons"></a>
#### 2.8.3 缺点

通过阅读方法名无法判断对象的类型（除非变量有类型注解）。这也是一种优势。

<a id="s2.8.4-decision"></a>
<a id="284-decision"></a>

<a id="default-iterators-operators-decision"></a>
#### 2.8.4 决策

对于支持它们的类型，如列表、字典和文件，使用默认迭代器和操作符。内置类型也定义了迭代器方法。优先使用这些方法而不是返回列表的方法，除非你在迭代容器时不应修改它。

```python
Yes:  for key in adict: ...
      if obj in alist: ...
      for line in afile: ...
      for k, v in adict.items(): ...
```

```python
No:   for key in adict.keys(): ...
      for line in afile.readlines(): ...
```

<a id="s2.9-generators"></a>
<a id="29-generators"></a>

<a id="generators"></a>
### 2.9 生成器

根据需要使用生成器。

<a id="s2.9.1-definition"></a>
<a id="291-definition"></a>

<a id="generators-definition"></a>
#### 2.9.1 定义

生成器函数返回一个迭代器，每次执行 `yield` 语句时都会产生一个值。生成器函数在产生值后，其运行状态会被暂停，直到下一个值被需要时再继续。

<a id="s2.9.2-pros"></a>
<a id="292-pros"></a>

<a id="generators-pros"></a>
#### 2.9.2 优点

代码更简单，因为每次调用时本地变量的状态和控制流都被保留。生成器比一次性创建整个值列表的函数使用更少的内存。

<a id="s2.9.3-cons"></a>
<a id="293-cons"></a>

<a id="generators-cons"></a>
#### 2.9.3 缺点

生成器中的本地变量在生成器被完全消耗或自身被垃圾回收之前不会被垃圾回收。

<a id="s2.9.4-decision"></a>
<a id="294-decision"></a>

<a id="generators-decision"></a>
#### 2.9.4 决策

可以使用。在生成器函数的文档字符串中使用 "Yields:" 而不是 "Returns:"。

如果生成器管理着昂贵的资源，确保强制进行清理。

一种好的清理方法是使用上下文管理器包装生成器 [PEP-0533](https://peps.python.org/pep-0533/)。

<a id="s2.10-lambda-functions"></a>
<a id="210-lambda-functions"></a>

<a id="lambdas"></a>
### 2.10 Lambda 函数

适用于单行代码。优先使用生成器表达式而不是带有 `lambda` 的 `map()` 或 `filter()`。

<a id="s2.10.1-definition"></a>
<a id="2101-definition"></a>

<a id="lambdas-definition"></a>
#### 2.10.1 定义

Lambda 定义了表达式中的匿名函数，与语句相对。

<a id="s2.10.2-pros"></a>
<a id="2102-pros"></a>

<a id="lambdas-pros"></a>
#### 2.10.2 优点

方便。

<a id="s2.10.3-cons"></a>
<a id="2103-cons"></a>

<a id="lambdas-cons"></a>
#### 2.10.3 缺点

比本地函数更难阅读和调试。缺乏名称意味着堆栈跟踪更难理解。由于函数只能包含表达式，其表达能力有限。

<a id="s2.10.4-decision"></a>
<a id="2104-decision"></a>

<a id="lambdas-decision"></a>
#### 2.10.4 决策

允许使用 Lambda。如果 Lambda 函数内的代码跨越多行或长度超过 60-80 个字符，最好将其定义为常规的[嵌套函数](#lexical-scoping)。

对于常见的操作如乘法，使用 `operator` 模块中的函数而不是 Lambda 函数。例如，优先使用 `operator.mul` 而不是 `lambda x, y: x * y`。

<a id="s2.11-conditional-expressions"></a>
<a id="211-conditional-expressions"></a>

<a id="conditional-expressions"></a>
### 2.11 条件表达式

适用于简单情况。

<a id="s2.11.1-definition"></a>
<a id="2111-definition"></a>

<a id="conditional-expressions-definition"></a>
#### 2.11.1 定义

条件表达式（有时称为“三元运算符”）是为 if 语句提供更简短语法的机制。例如：`x = 1 if cond else 2`。

<a id="s2.11.2-pros"></a>
<a id="2112-pros"></a>

<a id="conditional-expressions-pros"></a>
#### 2.11.2 优点

比 if 语句更短且更方便。

<a id="s2.11.3-cons"></a>
<a id="2113-cons"></a>

<a id="conditional-expressions-cons"></a>
#### 2.11.3 缺点

可能比 if 语句更难阅读。如果表达式很长，条件可能难以定位。

<a id="s2.11.4-decision"></a>
<a id="2114-decision"></a>

<a id="conditional-expressions-decision"></a>
#### 2.11.4 决策

在简单情况下可以使用。每个部分必须在一行内完成：true-expression, if-expression, else-expression。当情况变得复杂时，使用完整的 if 语句。

```python
Yes:
    one_line = 'yes' if predicate(value) else 'no'
    slightly_split = ('yes' if predicate(value)
                      else 'no, nein, nyet')
    the_longest_ternary_style_that_can_be_done = (
        'yes, true, affirmative, confirmed, correct'
        if predicate(value)
        else 'no, false, negative, nay')
```

```python
No:
    bad_line_breaking = ('yes' if predicate(value) else
                         'no')
    portion_too_long = ('yes'
                        if some_long_module.some_long_predicate_function(
                            really_long_variable_name)
                        else 'no, false, negative, nay')
```

<a id="s2.12-default-argument-values"></a>
<a id="212-default-argument-values"></a>

<a id="default-arguments"></a>
### 2.12 默认参数值

在大多数情况下是可以接受的。

<a id="s2.12.1-definition"></a>
<a id="2121-definition"></a>

<a id="default-arguments-definition"></a>
#### 2.12.1 定义

您可以在函数参数列表的末尾为变量指定值，例如，`def foo(a, b=0):`。如果`foo`仅使用一个参数调用，则`b`被设置为0。如果使用两个参数调用，则`b`的值为第二个参数的值。

<a id="s2.12.2-pros"></a>
<a id="2122-pros"></a>

<a id="default-arguments-pros"></a>
#### 2.12.2 优点

通常，您有一个使用许多默认值的函数，但在极少数情况下，您希望覆盖这些默认值。默认参数值提供了一种简单的方法来实现这一点，而无需为罕见的例外定义大量函数。由于Python不支持方法/函数重载，默认参数是一种“伪造”重载行为的简单方法。

<a id="s2.12.3-cons"></a>
<a id="2123-cons"></a>

<a id="default-arguments-cons"></a>
#### 2.12.3 缺点

默认参数在模块加载时仅评估一次。这可能会导致问题，如果参数是一个可变对象，如列表或字典。如果函数修改了对象（例如，通过向列表追加一个项目），默认值将被修改。

<a id="s2.12.4-decision"></a>
<a id="2124-decision"></a>

<a id="default-arguments-decision"></a>
#### 2.12.4 决策

可以使用，但需注意以下警告：

在函数或方法定义中不要使用可变对象作为默认值。

```python
Yes: def foo(a, b=None):
         if b is None:
             b = []
Yes: def foo(a, b: Sequence | None = None):
         if b is None:
             b = []
Yes: def foo(a, b: Sequence = ()):  # 空元组可以，因为元组是不可变的。
         ...
```

```python
from absl import flags
_FOO = flags.DEFINE_string(...)

No:  def foo(a, b=[]):
         ...
No:  def foo(a, b=time.time()):  # `b`是否应该表示此模块加载的时间？
         ...
No:  def foo(a, b=_FOO.value):  # sys.argv尚未解析...
         ...
No:  def foo(a, b: Mapping = {}):  # 可能仍然被传递给未经检查的代码。
         ...
```

<a id="s2.13-properties"></a>
<a id="213-properties"></a>

<a id="properties"></a>
### 2.13 属性

属性可用于控制获取或设置需要简单计算或逻辑的属性。属性实现必须符合常规属性访问的一般期望：它们应该是廉价的、直接的和不令人惊讶的。

<a id="s2.13.1-definition"></a>
<a id="2131-definition"></a>

<a id="properties-definition"></a>
#### 2.13.1 定义

一种将获取和设置属性的方法调用包装为标准属性访问的方式。

<a id="s2.13.2-pros"></a>
<a id="2132-pros"></a>

<a id="properties-pros"></a>
#### 2.13.2 优点

*   允许使用属性访问和赋值API，而不是[getter和setter](#getters-and-setters)方法调用。
*   可以用来使属性只读。
*   允许计算延迟进行。
*   提供了一种在类内部演变独立于类用户的情况下维护类公共接口的方式。

<a id="s2.13.3-cons"></a>
<a id="2133-cons"></a>

<a id="properties-cons"></a>
#### 2.13.3 缺点

*   可以像运算符重载一样隐藏副作用。
*   对子类来说可能令人困惑。

<a id="s2.13.4-decision"></a>
<a id="2134-decision"></a>

<a id="properties-decision"></a>
#### 2.13.4 决策

允许使用属性，但与运算符重载一样，仅在必要时使用，并且应符合典型属性访问的期望；否则遵循[getter和setter](#getters-and-setters)规则。

例如，仅使用属性来获取和设置内部属性是不允许的：没有计算发生，因此属性是不必要的（[应使属性公开](#getters-and-setters)）。相比之下，使用属性来控制属性访问或计算一个*简单*的派生值是允许的：逻辑简单且不令人惊讶。

应使用`@property`[装饰器](#s2.17-function-and-method-decorators)创建属性。手动实现属性描述符被视为[高级功能](#power-features)。

带有属性的继承可能不太明显。不要使用属性来实现子类可能希望覆盖和扩展的计算。

<a id="s2.14-truefalse-evaluations"></a>
<a id="214-truefalse-evaluations"></a>

<a id="truefalse-evaluations"></a>
### 2.14 真/假评估

尽可能使用“隐式”假值（有一些例外情况）。

<a id="s2.14.1-definition"></a>
<a id="2141-definition"></a>

<a id="truefalse-evaluations-definition"></a>
#### 2.14.1 定义

在布尔上下文中，Python 将某些值评估为 `False`。一个快速的“经验法则”是，所有“空”值都被视为假，因此 `0, None, [], {}, ''` 在布尔上下文中都评估为假。

<a id="s2.14.2-pros"></a>
<a id="2142-pros"></a>

<a id="truefalse-evaluations-pros"></a>
#### 2.14.2 优点

使用 Python 布尔值的条件更易读且错误更少。在大多数情况下，它们也更快。

<a id="s2.14.3-cons"></a>
<a id="2143-cons"></a>

<a id="truefalse-evaluations-cons"></a>
#### 2.14.3 缺点

对于 C/C++ 开发者来说可能看起来很奇怪。

<a id="s2.14.4-decision"></a>
<a id="2144-decision"></a>

<a id="truefalse-evaluations-decision"></a>
#### 2.14.4 决策

尽可能使用“隐式”假值，例如 `if foo:` 而不是 `if foo != []:`。但请注意以下几点：

-   始终使用 `if foo is None:`（或 `is not None`）来检查 `None` 值。例如，当测试一个默认值为 `None` 的变量或参数是否被设置为其他值时。其他值在布尔上下文中可能是假值！

-   永远不要使用 `==` 将布尔变量与 `False` 进行比较。应使用 `if not x:`。如果需要区分 `False` 和 `None`，则可以链接表达式，例如 `if not x and x is not None:`。

-   对于序列（字符串、列表、元组），利用空序列为假的事实，因此 `if seq:` 和 `if not seq:` 分别优于 `if len(seq):` 和 `if not len(seq):`。

-   处理整数时，隐式假值可能带来的风险大于收益（即，意外地将 `None` 处理为 0）。你可以将已知为整数的值（且不是 `len()` 的结果）与整数 0 进行比较。

    ```python
    Yes: if not users:
             print('无用户')

         if i % 10 == 0:
             self.handle_multiple_of_ten()

         def f(x=None):
             if x is None:
                 x = []
    ```

    ```python
    No:  if len(users) == 0:
             print('无用户')

         if not i % 10:
             self.handle_multiple_of_ten()

         def f(x=None):
             x = x or []
    ```

-   注意 `'0'`（即，字符串形式的 `0`）评估为真。

-   注意 Numpy 数组在隐式布尔上下文中可能会引发异常。测试 `np.array` 的空状态时，优先使用 `.size` 属性（例如 `if not users.size`）。

<a id="s2.16-lexical-scoping"></a>
<a id="216-lexical-scoping"></a>

<a id="lexical-scoping"></a>
### 2.16 词法作用域

可以使用。

<a id="s2.16.1-definition"></a>
<a id="2161-definition"></a>

<a id="lexical-scoping-definition"></a>
#### 2.16.1 定义

嵌套的Python函数可以引用在封闭函数中定义的变量，但不能对其进行赋值。变量绑定是通过词法作用域解析的，即基于静态程序文本。在一个代码块中对名称的任何赋值操作都会导致Python将对该名称的所有引用视为局部变量，即使使用在赋值之前。如果出现全局声明，该名称将被视为全局变量。

使用此功能的一个示例是：

```python
def get_adder(summand1: float) -> Callable[[float], float]:
    """返回一个将数字加到给定数字的函数。"""
    def adder(summand2: float) -> float:
        return summand1 + summand2

    return adder
```

<a id="s2.16.2-pros"></a>
<a id="2162-pros"></a>

<a id="lexical-scoping-pros"></a>
#### 2.16.2 优点

通常会产生更清晰、更优雅的代码。特别是对有经验的Lisp和Scheme（以及Haskell和ML等）程序员来说，这种方式更令人感到舒适。

<a id="s2.16.3-cons"></a>
<a id="2163-cons"></a>

<a id="lexical-scoping-cons"></a>
#### 2.16.3 缺点

可能会导致令人困惑的错误，例如基于[PEP-0227](https://peps.python.org/pep-0227/)的这个例子：

```python
i = 4
def foo(x: Iterable[int]):
    def bar():
        print(i, end='')
    # ...
    # 这里有一大堆代码
    # ...
    for i in x:  # 啊，i 是 foo 的局部变量，所以 bar 看到的是这个
        print(i, end='')
    bar()
```

因此，`foo([1, 2, 3])` 将打印 `1 2 3 3`，而不是 `1 2 3 4`。

<a id="s2.16.4-decision"></a>
<a id="2164-decision"></a>

<a id="lexical-scoping-decision"></a>
#### 2.16.4 决定

可以使用。

<a id="s2.17-function-and-method-decorators"></a>
<a id="217-function-and-method-decorators"></a>
<a id="function-and-method-decorators"></a>

<a id="decorators"></a>
### 2.17 函数和方法装饰器

在有明显优势时谨慎使用装饰器。避免使用 `staticmethod`，并限制使用 `classmethod`。

<a id="s2.17.1-definition"></a>
<a id="2171-definition"></a>

<a id="decorators-definition"></a>
#### 2.17.1 定义

[函数和方法的装饰器](https://docs.python.org/3/glossary.html#term-decorator)（也称为“`@` 符号表示法”）。一种常见的装饰器是 `@property`，用于将普通方法转换为动态计算的属性。然而，装饰器语法也允许用户定义装饰器。具体来说，对于某个函数 `my_decorator`，这：

```python
class C:
    @my_decorator
    def method(self):
        # 方法体 ...
```

等同于：

```python
class C:
    def method(self):
        # 方法体 ...
    method = my_decorator(method)
```

<a id="s2.17.2-pros"></a>
<a id="2172-pros"></a>

<a id="decorators-pros"></a>
#### 2.17.2 优点

优雅地指定对方法的某种转换；这种转换可能消除一些重复代码，强制执行不变量等。

<a id="s2.17.3-cons"></a>
<a id="2173-cons"></a>

<a id="decorators-cons"></a>
#### 2.17.3 缺点

装饰器可以对函数的参数或返回值执行任意操作，导致出乎意料的隐式行为。此外，装饰器在对象定义时执行。对于模块级对象（类、模块函数等），这发生在导入时。装饰器代码中的失败几乎无法恢复。

<a id="s2.17.4-decision"></a>
<a id="2174-decision"></a>

<a id="decorators-decision"></a>
#### 2.17.4 决策

在有明显优势时谨慎使用装饰器。装饰器应遵循与函数相同的导入和命名指南。装饰器的文档字符串应明确说明该函数是一个装饰器。为装饰器编写单元测试。

避免在装饰器本身中使用外部依赖（例如，不要依赖文件、套接字、数据库连接等），因为在装饰器运行时（可能在导入时，从 `pydoc` 或其他工具）它们可能不可用。使用有效参数调用的装饰器应（尽可能）保证在所有情况下都能成功。

装饰器是“顶级代码”的特殊情况 - 请参阅 [main](#s3.17-main) 以获取更多讨论。

除非为了与现有库中定义的 API 集成而被迫使用，否则永远不要使用 `staticmethod`。改为编写模块级函数。

仅在编写命名构造函数或修改必要全局状态（如进程范围缓存）的类特定例程时使用 `classmethod`。

<a id="s2.18-threading"></a>
<a id="218-threading"></a>

<a id="threading"></a>
### 2.18 线程

不要依赖内置类型的原子性。

虽然 Python 的内置数据类型（如字典）看起来具有原子操作，但在某些情况下它们并非原子（例如，如果 `__hash__` 或 `__eq__` 作为 Python 方法实现），不应依赖它们的原子性。也不应依赖原子变量赋值（因为这反过来依赖于字典）。

使用 `queue` 模块的 `Queue` 数据类型作为线程间通信数据的首选方式。否则，使用 `threading` 模块及其锁定原语。优先使用条件变量和 `threading.Condition`，而不是使用较低级别的锁。

<a id="s2.19-power-features"></a>
<a id="219-power-features"></a>

<a id="power-features"></a>
### 2.19 高级功能

避免使用这些功能。

<a id="s2.19.1-definition"></a>
<a id="2191-definition"></a>

<a id="power-features-definition"></a>
#### 2.19.1 定义

Python 是一种极其灵活的语言，它提供了许多高级功能，例如自定义元类、字节码访问、动态编译、动态继承、对象重新父化、导入技巧、反射（例如 `getattr()` 的一些用法）、修改系统内部、实现自定义清理的 `__del__` 方法等。

<a id="s2.19.2-pros"></a>
<a id="2192-pros"></a>

<a id="power-features-pros"></a>
#### 2.19.2 优点

这些是强大的语言功能。它们可以使你的代码更加简洁。

<a id="s2.19.3-cons"></a>
<a id="2193-cons"></a>

<a id="power-features-cons"></a>
#### 2.19.3 缺点

在不需要这些“酷炫”功能时，使用它们非常诱人。使用这些不常见的功能会使代码更难阅读、理解和调试。最初（对原始作者来说）可能不觉得如此，但当重新审视代码时，与那些较长但直接的代码相比，这些代码往往更难处理。

<a id="s2.19.4-decision"></a>
<a id="2194-decision"></a>

<a id="power-features-decision"></a>
#### 2.19.4 决策

在你的代码中避免使用这些功能。

内部使用这些功能的标准库模块和类是可以使用的（例如，`abc.ABCMeta`、`dataclasses` 和 `enum`）。

<a id="s2.20-modern-python"></a>
<a id="220-modern-python"></a>

<a id="modern-python"></a>
### 2.20 现代 Python：来自 __future__ 的导入

新语言版本的语义变化可能会通过特殊的未来导入来启用，以便在早期运行时中按文件启用这些功能。

<a id="s2.20.1-definition"></a>
<a id="2201-definition"></a>

<a id="modern-python-definition"></a>
#### 2.20.1 定义

通过 `from __future__ import` 语句可以启用一些更现代的功能，允许提前使用预期的未来 Python 版本的功能。

<a id="s2.20.2-pros"></a>
<a id="2202-pros"></a>

<a id="modern-python-pros"></a>
#### 2.20.2 优点

这已被证明可以使运行时版本升级更加顺畅，因为可以在声明兼容性和防止文件内回归的同时按文件进行更改。现代代码更易于维护，因为它不太可能积累在未来运行时升级中会造成问题的技术债务。

<a id="s2.20.3-cons"></a>
<a id="2203-cons"></a>

<a id="modern-python-cons"></a>
#### 2.20.3 缺点

此类代码可能无法在引入所需未来语句之前的非常旧的解释器版本上运行。这种需求在支持极广泛环境的项目中更为常见。

<a id="s2.20.4-decision"></a>
<a id="2204-decision"></a>

<a id="modern-python-decision"></a>
#### 2.20.4 决策

##### 来自 __future__ 的导入

鼓励使用 `from __future__ import` 语句。这允许给定的源文件从今天开始使用更现代的 Python 语法功能。一旦你不再需要在版本上运行，其中这些功能隐藏在 `__future__` 导入后面，请随时删除这些行。

在可能在旧至 3.5 版本而不是 >= 3.7 版本上执行的代码中，导入：

```python
from __future__ import generator_stop
```

有关更多信息，请阅读 [Python 未来语句定义](https://docs.python.org/3/library/__future__.html) 文档。

请在你确信代码仅在足够现代的环境中使用之前，不要删除这些导入。即使你目前在代码中没有使用特定未来导入启用的功能，保留它在文件中的位置可以防止后续对代码的修改无意中依赖于旧的行为。

根据需要使用其他 `from __future__` 导入语句。

<a id="s2.21-type-annotated-code"></a>
<a id="s2.21-typed-code"></a>
<a id="221-type-annotated-code"></a>
<a id="typed-code"></a>

<a id="typed-code"></a>
### 2.21 类型注解代码

您可以使用[类型提示](https://docs.python.org/3/library/typing.html)对Python代码进行注解。在构建时使用类型检查工具如[pytype](https://github.com/google/pytype)对代码进行类型检查。在大多数情况下，当可行时，类型注解应位于源文件中。对于第三方或扩展模块，注解可以位于[存根 `.pyi` 文件](https://peps.python.org/pep-0484/#stub-files)中。

<a id="s2.21.1-definition"></a>
<a id="2211-definition"></a>

<a id="typed-code-definition"></a>
#### 2.21.1 定义

类型注解（或“类型提示”）用于函数或方法的参数和返回值：

```python
def func(a: int) -> list[int]:
```

您还可以使用类似的语法声明变量的类型：

```python
a: SomeType = some_func()
```

<a id="s2.21.2-pros"></a>
<a id="2212-pros"></a>

<a id="typed-code-pros"></a>
#### 2.21.2 优点

类型注解可以提高代码的可读性和可维护性。类型检查器会将许多运行时错误转换为构建时错误，并减少您使用[高级功能](#power-features)的能力。

<a id="s2.21.3-cons"></a>
<a id="2213-cons"></a>

<a id="typed-code-cons"></a>
#### 2.21.3 缺点

您需要保持类型声明的更新。您可能会看到您认为是有效代码的类型错误。使用[type checker](https://github.com/google/pytype)可能会减少您使用[高级功能](#power-features)的能力。

<a id="s2.21.4-decision"></a>
<a id="2214-decision"></a>

<a id="typed-code-decision"></a>
#### 2.21.4 决策

强烈建议在更新代码时启用Python类型分析。在添加或修改公共API时，请包含类型注解，并在构建系统中通过pytype启用检查。由于静态分析对Python来说相对较新，我们承认一些项目可能会因为不希望的副作用（如错误推断的类型）而无法采用。在这些情况下，鼓励作者在BUILD文件或代码本身中适当位置添加带有TODO或链接到描述当前阻止类型注解采用的问题（们）的注释。

<a id="s3-python-style-rules"></a>
<a id="3-python-style-rules"></a>

<a id="python-style-rules"></a>
## 3 Python风格规则

<a id="s3.1-semicolons"></a>
<a id="31-semicolons"></a>

<a id="semicolons"></a>
### 3.1 分号

不要用分号结束您的行，也不要用分号将两个语句放在同一行。

<a id="s3.2-line-length"></a>
<a id="32-line-length"></a>

<a id="line-length"></a>
### 3.2 行长度

最大行长度为 *80 个字符*。

对 80 字符限制的明确例外情况包括：

- 长导入语句。
- 注释中的 URL、路径名或长标志。
- 不包含空格的长字符串模块级常量，这些常量如果分行会不方便，例如 URL 或路径名。
  - Pylint 禁用注释。（例如：`# pylint: disable=invalid-name`）

不要使用反斜杠进行[显式行连接](https://docs.python.org/3/reference/lexical_analysis.html#explicit-line-joining)。

相反，应利用 Python 的[括号、方括号和大括号内的隐式行连接](http://docs.python.org/reference/lexical_analysis.html#implicit-line-joining)。如有必要，可以在表达式外添加一对额外的括号。

请注意，此规则并不禁止字符串内的反斜杠转义换行符（参见[下文](#strings)）。

```python
Yes: foo_bar(self, width, height, color='black', design=None, x='foo',
             emphasis=None, highlight=0)
```

```python
Yes: if (width == 0 and height == 0 and
         color == 'red' and emphasis == 'strong'):

     (bridge_questions.clarification_on
      .average_airspeed_of.unladen_swallow) = 'African or European?'

     with (
         very_long_first_expression_function() as spam,
         very_long_second_expression_function() as beans,
         third_thing() as eggs,
     ):
       place_order(eggs, beans, spam, beans)
```

```python
No:  if width == 0 and height == 0 and \
         color == 'red' and emphasis == 'strong':

     bridge_questions.clarification_on \
         .average_airspeed_of.unladen_swallow = 'African or European?'

     with very_long_first_expression_function() as spam, \
           very_long_second_expression_function() as beans, \
           third_thing() as eggs:
       place_order(eggs, beans, spam, beans)
```

当一个字面字符串无法在一行内容纳时，使用括号进行隐式行连接。

```python
x = ('这将构建一个非常长的长长长长长长长长长长字符串')
```

尽量在最高可能的语法级别处断行。如果必须断两次行，应在相同的语法级别处断行。

```python
Yes: bridgekeeper.answer(
         name="Arthur", quest=questlib.find(owner="Arthur", perilous=True))

     answer = (a_long_line().of_chained_methods()
               .that_eventually_provides().an_answer())

     if (
         config is None
         or 'editor.language' not in config
         or config['editor.language'].use_spaces is False
     ):
       use_tabs()
```

```python
No: bridgekeeper.answer(name="Arthur", quest=questlib.find(
        owner="Arthur", perilous=True))

    answer = a_long_line().of_chained_methods().that_eventually_provides(
        ).an_answer()

    if (config is None or 'editor.language' not in config or config[
        'editor.language'].use_spaces is False):
      use_tabs()

```

在注释中，如果有必要，将长 URL 单独放在一行。

```python
Yes:  # 查看详细信息，请访问
      # http://www.example.com/us/developer/documentation/api/content/v2.0/csv_file_name_extension_full_specification.html
```

```python
No:  # 查看详细信息，请访问
     # http://www.example.com/us/developer/documentation/api/content/\
     # v2.0/csv_file_name_extension_full_specification.html
```

请注意上述行连接示例中元素的缩进；有关解释，请参见[缩进](#s3.4-indentation)部分。

[文档字符串](#docstrings)的摘要行必须保持在 80 个字符限制内。

在所有其他情况下，如果一行超过 80 个字符，并且 [Black](https://github.com/psf/black) 或 [Pyink](https://github.com/google/pyink) 自动格式化工具无法将该行调整到限制以下，则允许该行超过此最大值。作者应在合理的情况下，根据上述说明手动断行。

<a id="s3.3-parentheses"></a>
<a id="33-parentheses"></a>

<a id="parentheses"></a>
### 3.3 括号

谨慎使用括号。

在元组周围使用括号是可以的，但不是必需的。在返回语句或条件语句中，除非是为了隐式换行或表示元组，否则不要使用括号。

```python
Yes: if foo:
         bar()
     while x:
         x = bar()
     if x and y:
         bar()
     if not x:
         bar()
     # 对于单个元素的元组，使用括号更易于视觉识别，而不是使用逗号。
     onesie = (foo,)
     return foo
     return spam, beans
     return (spam, beans)
     for (x, y) in dict.items(): ...
```

```python
No:  if (x):
         bar()
     if not(x):
         bar()
     return (foo)
```

<a id="s3.4-indentation"></a>
<a id="34-indentation"></a>

<a id="indentation"></a>
### 3.4 缩进

使用*4个空格*来缩进代码块。

永远不要使用制表符。隐式换行应使包装元素垂直对齐（参见[行长度示例](#s3.2-line-length)），或者使用悬挂的4个空格缩进。结束的括号（圆括号、方括号或花括号）可以放在表达式的末尾，或者放在单独的行上，但这时应与对应的开始括号所在的行对齐。

```python
Yes:   # 与开始分隔符对齐。
       foo = long_function_name(var_one, var_two,
                                var_three, var_four)
       meal = (spam,
               beans)

       # 在字典中与开始分隔符对齐。
       foo = {
           'long_dictionary_key': value1 +
                                  value2,
           ...
       }

       # 4个空格的悬挂缩进；第一行不放任何内容。
       foo = long_function_name(
           var_one, var_two, var_three,
           var_four)
       meal = (
           spam,
           beans)

       # 4个空格的悬挂缩进；第一行不放任何内容，
       # 结束括号放在新的一行。
       foo = long_function_name(
           var_one, var_two, var_three,
           var_four
       )
       meal = (
           spam,
           beans,
       )

       # 在字典中使用4个空格的悬挂缩进。
       foo = {
           'long_dictionary_key':
               long_dictionary_value,
           ...
       }
```

```python
No:    # 第一行放内容是禁止的。
       foo = long_function_name(var_one, var_two,
           var_three, var_four)
       meal = (spam,
           beans)

       # 2个空格的悬挂缩进是禁止的。
       foo = long_function_name(
         var_one, var_two, var_three,
         var_four)

       # 在字典中不使用悬挂缩进。
       foo = {
           'long_dictionary_key':
           long_dictionary_value,
           ...
       }
```

<a id="s3.4.1-trailing-comma"></a>
<a id="s3.4.1-trailing-commas"></a>
<a id="s3.4.1-trailing_comma"></a>
<a id="s3.4.1-trailing_commas"></a>
<a id="341-trailing_comma"></a>
<a id="341-trailing_commas"></a>
<a id="trailing_comma"></a>
<a id="trailing_commas"></a>

<a id="trailing-comma"></a>
#### 3.4.1 序列项的尾随逗号？

仅当关闭容器标记 `]`、`)` 或 `}` 不在与最后一个元素相同的行上时，以及对于单元素元组，推荐使用序列项的尾随逗号。尾随逗号的存在也被用作提示我们的Python代码自动格式化工具[Black](https://github.com/psf/black)或[Pyink](https://github.com/google/pyink)，以便在最后一个元素后的`,`存在时，自动格式化容器中的项目为一行一个。

```python
Yes:   golomb3 = [0, 1, 3]
       golomb4 = [
           0,
           1,
           4,
           6,
       ]
```

```python
No:    golomb4 = [
           0,
           1,
           4,
           6,]
```

<a id="s3.5-blank-lines"></a>
<a id="35-blank-lines"></a>

<a id="blank-lines"></a>
### 3.5 空行

顶级定义之间（无论是函数还是类定义）使用两行空行。方法定义之间以及`class`的文档字符串与第一个方法之间使用一行空行。`def`行之后不使用空行。在函数或方法内根据需要使用单行空行。

空行不必紧跟定义。例如，紧接在函数、类和方法定义前的相关注释可能是合理的。考虑你的注释是否可以作为文档字符串的一部分更有用。

<a id="s3.6-whitespace"></a>
<a id="36-whitespace"></a>

<a id="whitespace"></a>
### 3.6 空白字符

遵循标准排版规则，在标点符号周围使用空格。

括号、方括号或大括号内部不应有空格。

```python
Yes: spam(ham[1], {'eggs': 2}, [])
```

```python
No:  spam( ham[ 1 ], { 'eggs': 2 }, [ ] )
```

逗号、分号或冒号前不应有空格，但在这些符号之后应使用空格，除非在行尾。

```python
Yes: if x == 4:
         print(x, y)
     x, y = y, x
```

```python
No:  if x == 4 :
         print(x , y)
     x , y = y , x
```

参数列表、索引或切片开始的左括号或左方括号前不应有空格。

```python
Yes: spam(1)
```

```python
No:  spam (1)
```

```python
Yes: dict['key'] = list[index]
```

```python
No:  dict ['key'] = list [index]
```

行尾不应有尾随空格。

在赋值运算符（`=`）、比较运算符（`==, <, >, !=, <>, <=, >=, in, not in, is, is not`）和布尔运算符（`and, or, not`）周围使用单个空格。根据实际情况判断在算术运算符（`+`, `-`, `*`, `/`, `//`, `%`, `**`, `@`）周围是否插入空格。

```python
Yes: x == 1
```

```python
No:  x<1
```

在传递关键字参数或定义默认参数值时，`=` 周围不应有空格，但有一个例外：[当存在类型注解时](#typing-default-values)，默认参数值的 `=` 周围应使用空格。

```python
Yes: def complex(real, imag=0.0): return Magic(r=real, i=imag)
Yes: def complex(real, imag: float = 0.0): return Magic(r=real, i=imag)
```

```python
No:  def complex(real, imag = 0.0): return Magic(r = real, i = imag)
No:  def complex(real, imag: float=0.0): return Magic(r = real, i = imag)
```

不要使用空格来垂直对齐连续行的标记，因为这会增加维护负担（适用于 `:`、`#`、`=` 等）：

```python
Yes:
  foo = 1000  # 注释
  long_name = 2  # 不应对齐的注释

  dictionary = {
      'foo': 1,
      'long_name': 2,
  }
```

```python
No:
  foo       = 1000  # 注释
  long_name = 2     # 不应对齐的注释

  dictionary = {
      'foo'      : 1,
      'long_name': 2,
  }
```

<a id="Python_Interpreter"></a>
<a id="s3.7-shebang-line"></a>
<a id="37-shebang-line"></a>

<a id="shebang-line"></a>
### 3.7 Shebang 行

大多数 `.py` 文件不需要以 `#!` 行开头。程序的主文件应以 `#!/usr/bin/env python3`（支持虚拟环境）或 `#!/usr/bin/python3` 开头，依据 [PEP-394](https://peps.python.org/pep-0394/)。

此行由内核用于查找 Python 解释器，但在导入模块时会被 Python 忽略。仅在打算直接执行的文件中需要此行。

<a id="s3.8-comments-and-docstrings"></a>
<a id="s3.8-comments"></a>
<a id="38-comments-and-docstrings"></a>

<a id="documentation"></a>
### 3.8 注释和文档字符串

请确保使用正确的样式来编写模块、函数、方法的文档字符串以及内联注释。

<a id="s3.8.1-comments-in-doc-strings"></a>
<a id="381-docstrings"></a>
<a id="comments-in-doc-strings"></a>

<a id="docstrings"></a>
#### 3.8.1 文档字符串

Python 使用 *文档字符串* 来记录代码。文档字符串是包、模块、类或函数中第一条语句的字符串。这些字符串可以通过对象的 `__doc__` 成员自动提取，并被 `pydoc` 使用。（尝试在你的模块上运行 `pydoc` 看看效果如何。）始终使用三重引号 `"""` 格式来编写文档字符串（按照 [PEP 257](https://peps.python.org/pep-0257/) 的规定）。文档字符串应组织为一个摘要行（一行物理行，不超过80个字符），以句号、问号或感叹号结束。当需要写更多内容时（鼓励这样做），必须在摘要行后留一空行，然后从与第一行第一个引号相同的光标位置开始继续写文档字符串。下面还有更多关于文档字符串的格式指南。

<a id="s3.8.2-comments-in-modules"></a>
<a id="382-modules"></a>
<a id="comments-in-modules"></a>

<a id="module-docs"></a>
#### 3.8.2 模块

每个文件都应包含许可证模板。根据项目使用的许可证（例如，Apache 2.0、BSD、LGPL、GPL）选择合适的模板。

文件应以描述模块内容和使用方法的文档字符串开始。
```python
"""模块或程序的一行摘要，以句号结束。

留一空行。此文档字符串的其余部分应包含模块或程序的整体描述。可以选择性地包含导出类和函数的简要描述和/或使用示例。

典型使用示例：

  foo = ClassFoo()
  bar = foo.function_bar()
"""
```


<a id="s3.8.2.1-test-modules"></a>

<a id="test-docs"></a>
##### 3.8.2.1 测试模块

测试文件的模块级文档字符串不是必需的。只有在有额外信息可以提供时才应包含。

示例包括关于如何运行测试的一些具体说明、不寻常的设置模式的解释、对外部环境的依赖等。

```python
"""此 blaze 测试使用黄金文件。

您可以通过在 `google3` 目录下运行
`blaze run //foo/bar:foo_test -- --update_golden_files` 来更新这些文件。
"""
```

不提供任何新信息的文档字符串不应使用。

```python
"""foo.bar 的测试。"""
```

<a id="s3.8.3-functions-and-methods"></a>
<a id="383-functions-and-methods"></a>
<a id="functions-and-methods"></a>

<a id="function-docs"></a>
#### 3.8.3 函数和方法

在本节中，"函数" 指的是方法、函数、生成器或属性。

对于具有以下一个或多个属性的每个函数，文档字符串是必需的：

-   是公共 API 的一部分
-   尺寸非-trivial
-   逻辑不明显

文档字符串应提供足够的信息，以便在不阅读函数代码的情况下编写函数调用。文档字符串应描述函数的调用语法及其语义，但通常不应描述其实现细节，除非这些细节与函数的使用方式相关。例如，一个函数如果作为副作用改变了其参数之一，应在其文档字符串中注明。否则，函数实现中不相关但重要的细节最好作为代码旁边的注释表达，而不是在函数的文档字符串中。

文档字符串可以是描述式风格（`"""从 Bigtable 中获取行。"""`）或命令式风格（`"""从 Bigtable 中获取行。"""`），但在一个文件中应保持一致。对于 `@property` 数据描述符的文档字符串，应使用与属性或<a href="#doc-function-args">函数参数</a>的文档字符串相同的风格（`"""Bigtable 路径。"""`，而不是 `"""返回 Bigtable 路径。"""`）。

函数的某些方面应在下列特殊部分中记录。每个部分以一个标题行开始，标题行以冒号结束。除了标题之外的所有部分应保持两个或四个空格的悬挂缩进（在一个文件中保持一致）。在函数名和签名足够说明问题的情况下，可以省略这些部分，只使用一行文档字符串来恰当地描述函数。
如果描述太长，无法在一行80个字符内显示，请使用比参数名称多2或4个空格的悬挂缩进（与文件中其他文档字符串保持一致）。描述应包括所需类型（如果代码中不包含相应的类型注解）。如果函数接受`*foo`（可变长度参数列表）和/或`**bar`（任意关键字参数），它们应列为`*foo`和`**bar`。

<a id="doc-function-returns"></a>
[*返回值:*（或*生成值:* 对于生成器）](#doc-function-returns)
:   描述返回值的语义，包括类型注解未提供的任何类型信息。如果函数仅返回None，则不需要此部分。如果文档字符串以“Return”、“Returns”、“Yield”或“Yields”开头（例如`"""Returns row from Bigtable as a tuple of strings."""`）*并且*开头句子足以描述返回值，则可以省略此部分。不要模仿旧的'NumPy风格'（[示例](https://numpy.org/doc/1.24/reference/generated/numpy.linalg.qr.html)），这种风格经常将元组返回值记录为多个具有单独名称的返回值（从不提及元组）。相反，应描述这样的返回值为：“返回：一个元组（mat_a, mat_b），其中mat_a是...，并且...”。文档字符串中的辅助名称不必与函数体中使用的任何内部名称相对应（因为这些不属于API的一部分）。如果函数使用`yield`（是一个生成器），则`Yields:`部分应记录`next()`返回的对象，而不是调用评估到的生成器对象本身。

<a id="doc-function-raises"></a>
[*引发:*](#doc-function-raises)
:   列出所有与接口相关的异常，后跟描述。使用类似于*Args:*中描述的异常名称+冒号+空格或换行和悬挂缩进样式。您不应记录违反文档字符串中指定的API时引发的异常（因为这将使违反API的行为成为API的一部分，这自相矛盾）。

```python
def fetch_smalltable_rows(
    table_handle: smalltable.Table,
    keys: Sequence[bytes | str],
    require_all_keys: bool = False,
) -> Mapping[bytes, tuple[str, ...]]:
    """从Smalltable中获取行。

    从由table_handle表示的Table实例中检索与给定键相关的行。字符串键将被UTF-8编码。

    参数:
        table_handle: 一个打开的smalltable.Table实例。
        keys: 表示要获取的每个表行的键的字符串序列。字符串键将被UTF-8编码。
        require_all_keys: 如果为True，则仅返回所有键都设置了值的行。

    返回值:
        一个将键映射到获取的相应表行数据的字典。每行表示为字符串的元组。例如：

        {b'Serak': ('Rigel VII', 'Preparer'),
         b'Zim': ('Irk', 'Invader'),
         b'Lrrr': ('Omicron Persei 8', 'Emperor')}

        返回的键始终为字节。如果keys参数中的键在字典中缺失，则该行在表中未找到（并且require_all_keys必须为False）。

    引发:
        IOError: 访问smalltable时发生错误。
    """
```

同样，这种带有换行的`Args:`变体也是允许的：

```python
def fetch_smalltable_rows(
    table_handle: smalltable.Table,
    keys: Sequence[bytes | str],
    require_all_keys: bool = False,
) -> Mapping[bytes, tuple[str, ...]]:
    """从Smalltable中获取行。

    从由table_handle表示的Table实例中检索与给定键相关的行。字符串键将被UTF-8编码。

    参数:
      table_handle:
        一个打开的smalltable.Table实例。
      keys:
        表示要获取的每个表行的键的字符串序列。字符串键将被UTF-8编码。
      require_all_keys:
        如果为True，则仅返回所有键都设置了值的行。

    返回值:
      一个将键映射到获取的相应表行数据的字典。每行表示为字符串的元组。例如：

      {b'Serak': ('Rigel VII', 'Preparer'),
       b'Zim': ('Irk', 'Invader'),
       b'Lrrr': ('Omicron Persei 8', 'Emperor')}

      返回的键始终为字节。如果keys参数中的键在字典中缺失，则该行在表中未找到（并且require_all_keys必须为False）。

    引发:
```python
IOError: 访问 smalltable 时发生错误。
"""
```

<a id="s3.8.3.1-overridden-methods"></a>

<a id="overridden-method-docs"></a>
##### 3.8.3.1 重写方法

如果一个方法重写了基类中的方法，并且明确使用了来自 `typing_extensions` 或 `typing` 模块的 [`@override`](https://typing-extensions.readthedocs.io/en/latest/#override) 装饰器，那么该方法不需要文档字符串，除非重写方法的行为实质上细化了基方法的契约，或者需要提供详细信息（例如，记录额外的副作用），在这种情况下，重写方法需要一个至少包含这些差异的文档字符串。

```python
from typing_extensions import override

class Parent:
  def do_something(self):
    """父类方法，包含文档字符串。"""

# 子类，方法使用 override 注解。
class Child(Parent):
  @override
  def do_something(self):
    pass
```

```python
# 子类，但没有使用 @override 装饰器，需要文档字符串。
class Child(Parent):
  def do_something(self):
    pass

# 文档字符串很简单，使用 @override 足以表明文档可以在基类中找到。
class Child(Parent):
  @override
  def do_something(self):
    """参见基类。"""
```

<a id="s3.8.4-comments-in-classes"></a>
<a id="384-classes"></a>
<a id="comments-in-classes"></a>

<a id="class-docs"></a>
#### 3.8.4 类

类应该在类定义下方有一个描述该类的文档字符串。公共属性（不包括[属性](#properties)）应该在这里的 `Attributes` 部分中进行文档化，并遵循与[函数的 `Args` 部分](#doc-function-args)相同的格式。

```python
class SampleClass:
    """此处是类的摘要。

    更长的类信息...
    更长的类信息...

    Attributes:
        likes_spam: 一个布尔值，表示我们是否喜欢 SPAM。
        eggs: 我们已经下的蛋的整数计数。
    """

    def __init__(self, likes_spam: bool = False):
        """根据对 SPAM 的偏好初始化实例。

        Args:
          likes_spam: 定义实例是否具有此偏好。
        """
        self.likes_spam = likes_spam
        self.eggs = 0

    @property
    def butter_sticks(self) -> int:
        """我们拥有的黄油棒的数量。"""
```

所有类的文档字符串应以一行摘要开始，描述类实例代表什么。这意味着 `Exception` 的子类也应该描述异常代表什么，而不是它可能发生的上下文。类文档字符串不应重复不必要的信息，例如类是一个类。

```python
# 是：
class CheeseShopAddress:
  """奶酪店的地址。

  ...
  """

class OutOfCheeseError(Exception):
  """没有更多的奶酪可用。"""
```

```python
# 否：
class CheeseShopAddress:
  """描述奶酪店地址的类。

  ...
  """

class OutOfCheeseError(Exception):
  """当没有更多的奶酪可用时引发。"""
```

<a id="s3.8.5-block-and-inline-comments"></a>
<a id="comments-in-block-and-inline"></a>
<a id="s3.8.5-comments-in-block-and-inline"></a>
<a id="385-block-and-inline-comments"></a>

<a id="comments"></a>
#### 3.8.5 块注释和行内注释

代码中复杂部分的最后一个注释位置。如果你需要在下一次[代码审查](http://en.wikipedia.org/wiki/Code_review)中解释它，你现在就应该添加注释。复杂的操作在操作开始前需要几行注释。非显而易见的操作在行尾添加注释。

```python
# 我们使用加权字典搜索来找出 i 在数组中的位置。我们根据数组中最大的数字和数组大小来推断位置，然后进行二分搜索以获得确切的数字。

if i & (i-1) == 0:  # 如果 i 为 0 或 2 的幂，则为 True。
```

为了提高可读性，这些注释应该至少与代码隔开两个空格，以 `#` 字符开始，后跟至少一个空格，然后是注释文本本身。

另一方面，永远不要描述代码。假设阅读代码的人比你更了解 Python（尽管他们不知道你试图做什么）。

```python
# 坏注释：现在遍历 b 数组并确保每当 i 出现时
# 下一个元素是 i+1
```

<!-- 下一节是从 C++ 风格指南中复制的内容。 -->

<a id="s3.8.6-punctuation-spelling-and-grammar"></a>
<a id="386-punctuation-spelling-and-grammar"></a>
<a id="spelling"></a>
<a id="punctuation"></a>
<a id="grammar"></a>

<a id="punctuation-spelling-grammar"></a>
#### 3.8.6 标点符号、拼写和语法

注意标点符号、拼写和语法；阅读写得好的注释比阅读写得差的注释更容易。

注释应该像叙述性文本一样易读，具有适当的大写和标点符号。在许多情况下，完整的句子比句子片段更易读。较短的注释，例如代码行末的注释，有时可以不那么正式，但您应该保持风格的一致性。

尽管代码审查者指出您使用逗号时应该使用分号可能会令人沮丧，但保持源代码的高度清晰和可读性非常重要。正确的标点符号、拼写和语法有助于实现这一目标。

<a id="s3.10-strings"></a>
<a id="310-strings"></a>

<a id="strings"></a>
### 3.10 字符串

使用 [f-string](https://docs.python.org/3/reference/lexical_analysis.html#f-strings)、`%` 运算符或 `format` 方法来格式化字符串，即使参数都是字符串。根据实际情况选择字符串格式化选项。单次使用 `+` 进行连接是可以接受的，但不要用 `+` 来格式化字符串。

```python
Yes: x = f'name: {name}; score: {n}'
     x = '%s, %s!' % (imperative, expletive)
     x = '{}, {}'.format(first, second)
     x = 'name: %s; score: %d' % (name, n)
     x = 'name: %(name)s; score: %(score)d' % {'name':name, 'score':n}
     x = 'name: {}; score: {}'.format(name, n)
     x = a + b
```

```python
No: x = first + ', ' + second
    x = 'name: ' + name + '; score: ' + str(n)
```

避免在循环中使用 `+` 和 `+=` 运算符来累积字符串。在某些情况下，使用加法累积字符串可能会导致运行时间从线性变为二次。虽然这种常见的累积操作在 CPython 上可能被优化，但这是一个实现细节。优化适用的条件难以预测且可能发生变化。相反，应将每个子字符串添加到列表中，并在循环结束后使用 `''.join` 连接列表，或者将每个子字符串写入 `io.StringIO` 缓冲区。这些技术始终具有均摊线性运行时间复杂度。

```python
Yes: items = ['<table>']
     for last_name, first_name in employee_list:
         items.append('<tr><td>%s, %s</td></tr>' % (last_name, first_name))
     items.append('</table>')
     employee_table = ''.join(items)
```

```python
No: employee_table = '<table>'
    for last_name, first_name in employee_list:
        employee_table += '<tr><td>%s, %s</td></tr>' % (last_name, first_name)
    employee_table += '</table>'
```

在一个文件中，保持字符串引号字符的一致性。选择 `'` 或 `"` 并坚持使用。如果需要避免在字符串中使用反斜杠转义引号，可以使用另一种引号字符。

```python
Yes:
  Python('Why are you hiding your eyes?')
  Gollum("I'm scared of lint errors.")
  Narrator('"Good!" thought a happy Python reviewer.')
```

```python
No:
  Python("Why are you hiding your eyes?")
  Gollum('The lint. It burns. It burns us.')
  Gollum("Always the great lint. Watching. Watching.")
```

对于多行字符串，优先使用 `"""` 而不是 `'''`。项目可以选择在所有非文档字符串的多行字符串中使用 `'''`，但前提是它们也使用 `'` 作为常规字符串的引号。文档字符串必须使用 `"""`。

多行字符串不应与程序的其他部分的缩进保持一致。如果需要避免在字符串中嵌入额外的空格，可以使用连接的单行字符串或使用 [`textwrap.dedent()`](https://docs.python.org/3/library/textwrap.html#textwrap.dedent) 移除每行的初始空格的多行字符串：

```python
  No:
  long_string = """This is pretty ugly.
Don't do this.
"""
```

```python
  Yes:
  long_string = """This is fine if your use case can accept
      extraneous leading spaces."""
```

```python
  Yes:
  long_string = ("And this is fine if you cannot accept\n" +
                 "extraneous leading spaces.")
```

```python
  Yes:
  long_string = ("And this too is fine if you cannot accept\n"
                 "extraneous leading spaces.")
```

```python
  Yes:
  import textwrap

  long_string = textwrap.dedent("""\
      This is also fine, because textwrap.dedent()
      will collapse common leading spaces in each line.""")
```

请注意，这里使用反斜杠并不违反 [显式行继续](#line-length) 的禁止规定；在这种情况下，反斜杠是 [转义换行符](https://docs.python.org/3/reference/lexical_analysis.html#string-and-bytes-literals) 的一部分。

<a id="s3.10.1-logging"></a>
<a id="3101-logging"></a>
<a id="logging"></a>

<a id="logging"></a>
#### 3.10.1 日志记录

对于期望第一个参数为模式字符串（带有 `%` 占位符）的日志记录函数：始终使用字符串字面量（而不是 f-string！）作为第一个参数，并将模式参数作为后续参数传递。某些日志记录实现会将未展开的模式字符串收集为可查询字段。这也避免了在没有配置输出日志的情况下花费时间渲染消息。

```python
  Yes:
  import tensorflow as tf
```python
  logger = tf.get_logger()
  logger.info('TensorFlow 版本是: %s', tf.__version__)
```

```python
  是:
  import os
  from absl import logging

  logging.info('当前 $PAGER 是: %s', os.getenv('PAGER', default=''))

  homedir = os.getenv('HOME')
  if homedir is None or not os.access(homedir, os.W_OK):
    logging.error('无法写入主目录，$HOME=%r', homedir)
```

```python
  否:
  import os
  from absl import logging

  logging.info('当前 $PAGER 是:')
  logging.info(os.getenv('PAGER', default=''))

  homedir = os.getenv('HOME')
  if homedir is None or not os.access(homedir, os.W_OK):
    logging.error(f'无法写入主目录，$HOME={homedir!r}')
```

<a id="s3.10.2-error-messages"></a>
<a id="3102-error-messages"></a>
<a id="error-messages"></a>

<a id="error-messages"></a>
#### 3.10.2 错误消息 

错误消息（例如：`ValueError` 等异常中的消息字符串，或显示给用户的消息）应遵循以下三个指导原则：

1. 消息必须精确匹配实际的错误条件。

2. 插值部分必须始终能被清楚地识别。

3. 它们应该允许简单的自动处理（例如 grep）。

```python
  是:
  if not 0 <= p <= 1:
    raise ValueError(f'不是概率: {p=}')

  try:
    os.rmdir(workdir)
  except OSError as error:
    logging.warning('无法删除目录（原因: %r）: %r',
                    error, workdir)
```

```python
  否:
  if p < 0 or p > 1:  # 问题：对于 float('nan') 也是假的！
    raise ValueError(f'不是概率: {p=}')

  try:
    os.rmdir(workdir)
  except OSError:
    # 问题：消息做出了可能不正确的假设：
    # 删除可能因其他原因失败，误导调试此问题的人。
    logging.warning('目录已被删除: %s', workdir)

  try:
    os.rmdir(workdir)
  except OSError:
    # 问题：消息比必要的更难 grep，且对于 `workdir` 的所有可能值不一定不令人困惑。
    # 想象有人使用这样的名称调用库函数，例如 workdir = 'deleted'。警告将显示为：
    # "无法删除已删除的目录。"
    logging.warning('无法删除 %s 目录。', workdir)
```

<a id="s3.11-files-sockets-closeables"></a>
<a id="s3.11-files-and-sockets"></a>
<a id="311-files-and-sockets"></a>
<a id="files-and-sockets"></a>

<a id="files"></a>
### 3.11 文件、套接字及类似有状态资源

在使用完文件和套接字后，应显式地关闭它们。这一规则自然也适用于内部使用套接字的可关闭资源，例如数据库连接，以及其他需要以类似方式关闭的资源。仅举几例，这还包括 [mmap](https://docs.python.org/3/library/mmap.html) 映射、[h5py 文件对象](https://docs.h5py.org/en/stable/high/file.html) 和 [matplotlib.pyplot 图形窗口](https://matplotlib.org/2.1.0/api/_as_gen/matplotlib.pyplot.close.html)。

不必要地保持文件、套接字或其他此类有状态对象处于打开状态有很多缺点：

- 它们可能会消耗有限的系统资源，例如文件描述符。如果处理许多此类对象的代码未能在使用后立即将这些资源归还给系统，可能会不必要地耗尽这些资源。
- 保持文件处于打开状态可能会阻止其他操作，例如移动或删除它们，或者卸载文件系统。
- 在程序中共享的文件和套接字可能在逻辑上关闭后仍被意外读取或写入。如果它们实际上已关闭，尝试从中读取或写入将引发异常，从而更早地发现问题。

此外，虽然文件和套接字（以及一些行为相似的资源）在对象被销毁时会自动关闭，但将对象的生命周期与资源的状态耦合是一种不良做法：

- 无法保证运行时何时实际调用 `__del__` 方法。不同的 Python 实现使用不同的内存管理技术，例如延迟垃圾回收，这可能会任意且无限地延长对象的生命周期。
- 对文件的意外引用，例如在全局变量或异常回溯中，可能会使其比预期更长地存在。

依赖终结器来执行具有可观察副作用的自动清理已被反复发现会导致重大问题，跨越数十年和多种语言（例如，参见 [这篇文章](https://wiki.sei.cmu.edu/confluence/display/java/MET12-J.+Do+not+use+finalizers) 关于 Java）。

管理文件和类似资源的首选方式是使用 [`with` 语句](http://docs.python.org/reference/compound_stmts.html#the-with-statement)：

```python
with open("hello.txt") as hello_file:
    for line in hello_file:
        print(line)
```

对于不支持 `with` 语句的类似文件对象，请使用 `contextlib.closing()`：

```python
import contextlib

with contextlib.closing(urllib.urlopen("http://www.python.org/")) as front_page:
    for line in front_page:
        print(line)
```

在极少数情况下，如果基于上下文的资源管理不可行，代码文档必须清楚地解释如何管理资源生命周期。

<a id="s3.12-todo-comments"></a>
<a id="312-todo-comments"></a>

<a id="todo"></a>
### 3.12 TODO 注释

对于临时性代码、短期解决方案或足够好但不完美的代码，请使用 `TODO` 注释。

`TODO` 注释以全大写的 `TODO` 开头，后跟一个冒号和一个包含上下文的资源链接，理想情况下是一个错误引用。错误引用是首选的，因为错误会被跟踪并有后续评论。在此上下文之后，使用连字符 `-` 引入一个解释性字符串。目的是拥有一个一致的 `TODO` 格式，以便可以通过搜索找到获取更多详细信息的方法。

```python
# TODO: crbug.com/192795 - 调查 cpufreq 优化。
```

旧样式，以前推荐，但不鼓励在新代码中使用：

```python
# TODO(crbug.com/192795): 调查 cpufreq 优化。
# TODO(yourusername): 在这里使用 "*" 作为连接运算符。
```

避免添加引用个人或团队作为上下文的 TODO：

```python
# TODO: @yourusername - 提交一个问题并使用 '*' 表示重复。
```

如果你的 `TODO` 是“在未来的某个日期做某事”的形式，请确保你要么包含一个非常具体的日期（“在 2009 年 11 月之前修复”），要么包含一个非常具体的事件（“当所有客户端都能处理 XML 响应时删除此代码。”），未来的代码维护者能够理解。问题是跟踪此类事项的理想方式。

<a id="s3.13-imports-formatting"></a>
<a id="313-imports-formatting"></a>

<a id="imports-formatting"></a>
### 3.13 导入格式

导入语句应单独成行；有例外情况，如[`typing`和`collections.abc`的导入](#typing-imports)。

例如：

```python
Yes: from collections.abc import Mapping, Sequence
     import os
     import sys
     from typing import Any, NewType
```

```python
No:  import os, sys
```

导入语句应始终放在文件顶部，紧跟在任何模块注释和文档字符串之后，模块全局变量和常量之前。导入应按从最通用到最不通用的顺序分组：

1. Python未来导入语句。例如：

    ```python
    from __future__ import annotations
    ```

    有关这些导入的更多信息，请参见[上文](#from-future-imports)。

2. Python标准库导入。例如：

    ```python
    import sys
    ```

3. [第三方](https://pypi.org/)模块或包导入。例如：

    
    ```python
    import tensorflow as tf
    ```

4. 代码库子包导入。例如：

    
    ```python
    from otherproject.ai import mind
    ```

5. **已废弃：** 属于与此文件相同顶级子包的应用程序特定导入。例如：

    
    ```python
    from myproject.backend.hgwells import time_machine
    ```

    您可能会发现旧的Google Python风格代码这样做，但这已不再是必需的。**鼓励新代码不必理会这一点。** 只需将应用程序特定子包导入视为其他子包导入即可。

    
在每个分组内，导入应按其完整包路径（`from path import ...`中的`path`）按字母顺序排序，不区分大小写。代码可以选择在导入部分之间添加空行。

```python
import collections
import queue
import sys

from absl import app
from absl import flags
import bs4
import cryptography
import tensorflow as tf

from book.genres import scifi
from myproject.backend import huxley
from myproject.backend.hgwells import time_machine
from myproject.backend.state_machine import main_loop
from otherproject.ai import body
from otherproject.ai import mind
from otherproject.ai import soul

# 旧风格的代码可能将这些导入放在这里：
#from myproject.backend.hgwells import time_machine
#from myproject.backend.state_machine import main_loop
```


<a id="s3.14-statements"></a>
<a id="314-statements"></a>

<a id="statements"></a>
### 3.14 语句 

通常每行只写一个语句。

但是，如果整个语句可以在一行内完成，您可以将测试的结果放在与测试相同的行上。特别是，您永远不能对`try`/`except`这样做，因为`try`和`except`无法放在同一行上，并且只有在没有`else`的情况下才能对`if`这样做。

```python
Yes:

  if foo: bar(foo)
```

```python
No:

  if foo: bar(foo)
  else:   baz(foo)

  try:               bar(foo)
  except ValueError: baz(foo)

  try:
      bar(foo)
  except ValueError: baz(foo)
```

<a id="s3.15-accessors"></a>
<a id="s3.15-access-control"></a>
<a id="315-access-control"></a>
<a id="access-control"></a>
<a id="accessors"></a>

<a id="getters-and-setters"></a>
### 3.15 获取器和设置器 

获取器和设置器函数（也称为访问器和变异器）应在它们为获取或设置变量值提供有意义的角色或行为时使用。

特别是，当获取或设置变量是复杂的或成本显著的，无论是当前还是在合理的未来，都应使用它们。

例如，如果一对获取器/设置器只是读取和写入一个内部属性，那么应将该内部属性设为公共属性。相比之下，如果设置一个变量意味着某些状态失效或需要重建，则应使用设置器函数。函数调用提示可能正在发生一个非平凡的操作。或者，当需要简单逻辑时，[属性](#properties)可能是选项，或者重构以不再需要获取器和设置器。

获取器和设置器应遵循[命名](#s3.16-naming)指南，例如`get_foo()`和`set_foo()`。

如果过去的行为允许通过属性访问，则不要将新的获取器/设置器函数绑定到属性。任何仍尝试通过旧方法访问变量的代码应明显中断，以便他们意识到复杂性的变化。

<a id="s3.16-naming"></a>
<a id="316-naming"></a>

<a id="naming"></a>
### 3.16 命名

`module_name`, `package_name`, `ClassName`, `method_name`, `ExceptionName`,
`function_name`, `GLOBAL_CONSTANT_NAME`, `global_var_name`, `instance_var_name`,
`function_parameter_name`, `local_var_name`, `query_proper_noun_for_thing`,
`send_acronym_via_https`。

名称应具有描述性。这包括函数、类、变量、属性、文件以及任何其他类型的命名实体。

避免使用缩写。特别是，不要使用对项目外部读者来说模糊或不熟悉的缩写，也不要通过删除单词中的字母来缩写。

始终使用 `.py` 作为文件扩展名。永远不要使用连字符。

<a id="s3.16.1-names-to-avoid"></a>
<a id="3161-names-to-avoid"></a>

<a id="names-to-avoid"></a>
#### 3.16.1 应避免的名称

-   单字符名称，除非在特定允许的情况下：

    -   计数器或迭代器（例如 `i`, `j`, `k`, `v` 等）
    -   在 `try/except` 语句中作为异常标识符的 `e`
    -   在 `with` 语句中作为文件句柄的 `f`
    -   没有约束的私有[类型变量](#typing-type-var)（例如 `_T = TypeVar("_T")`, `_P = ParamSpec("_P")`）
    -   与参考论文或算法中已建立的符号相匹配的名称（参见[数学符号](#math-notation)）

    请注意不要滥用单字符命名。一般来说，描述性应与名称的可见范围成比例。例如，`i` 可能适合于5行的代码块，但在多个嵌套作用域内，它可能过于模糊。

-   在任何包/模块名称中使用连字符（`-`）

-   `__双前导和双尾随下划线__` 名称（Python 保留）

-   冒犯性术语

-   不必要地包含变量类型的名称（例如：`id_to_name_dict`）

<a id="s3.16.2-naming-conventions"></a>
<a id="3162-naming-convention"></a>

<a id="naming-conventions"></a>
#### 3.16.2 命名约定

-   “内部”指的是模块内部，或类中的受保护或私有。

-   在模块变量和函数前加上单个下划线（`_`）具有一定的保护作用（代码检查工具会标记对受保护成员的访问）。请注意，单元测试可以访问被测试模块中的受保护常量是可以接受的。

-   在实例变量或方法名前加上双下划线（`__` 也称为“dunder”）会有效地将其设为类私有（使用名称改写）；我们不鼓励使用这种方法，因为它影响可读性和可测试性，而且实际上并不是真正的私有。建议使用单个下划线。

-   将相关的类和顶级函数放在一个模块中。与 Java 不同，没有必要限制每个模块只有一个类。

-   类名使用 CapWords 格式，但模块名使用 lower_with_under.py 格式。尽管有一些旧模块使用 CapWords.py 命名，但现在不鼓励这样做，因为当模块恰好以类命名时会引起混淆。（“等等——我是写了 `import StringIO` 还是 `from StringIO import StringIO`？”）

-   新的*单元测试*文件遵循 PEP 8 兼容的 lower_with_under 方法命名，例如 `test_<method_under_test>_<state>`。为了与遵循 CapWords 函数命名的旧模块保持一致（*），以 `test` 开头的方法名中可以使用下划线来分隔名称的逻辑组成部分。一种可能的模式是 `test<MethodUnderTest>_<state>`。

<a id="s3.16.3-file-naming"></a>
<a id="3163-file-naming"></a>

<a id="file-naming"></a>
#### 3.16.3 文件命名

Python 文件名必须有 `.py` 扩展名，并且不得包含连字符（`-`）。这使得它们可以被导入和单元测试。如果你希望一个可执行文件在没有扩展名的情况下可以访问，请使用符号链接或包含 `exec "$0.py" "$@"` 的简单 bash 包装器。

<a id="s3.16.4-guidelines-derived-from-guidos-recommendations"></a>
<a id="3164-guidelines-derived-from-guidos-recommendations"></a>

<a id="guidelines-derived-from-guidos-recommendations"></a>
#### 3.16.4 源自[Guido](https://en.wikipedia.org/wiki/Guido_van_Rossum)建议的指导原则

<table rules="all" border="1" summary="源自 Guido 建议的指导原则"
       cellspacing="2" cellpadding="2">

  <tr>
    <th>类型</th>
    <th>公共</th>
    <th>内部</th>
  </tr>

  <tr>
    <td>包</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

  <tr>
    <td>模块</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code></td>
  </tr>

  <tr>
    <td>类</td>
    <td><code>CapWords</code></td>
    <td><code>_CapWords</code></td>
  </tr>

  <tr>
    <td>异常</td>
    <td><code>CapWords</code></td>
    <td></td>
  </tr>

  <tr>
    <td>函数</td>
    <td><code>lower_with_under()</code></td>
    <td><code>_lower_with_under()</code></td>
  </tr>

  <tr>
```html
  <tr>
    <td>全局/类常量</td>
    <td><code>CAPS_WITH_UNDER</code></td>
    <td><code>_CAPS_WITH_UNDER</code></td>
  </tr>

  <tr>
    <td>全局/类变量</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code></td>
  </tr>

  <tr>
    <td>实例变量</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code>（受保护）</td>
  </tr>

  <tr>
    <td>方法名称</td>
    <td><code>lower_with_under()</code></td>
    <td><code>_lower_with_under()</code>（受保护）</td>
  </tr>

  <tr>
    <td>函数/方法参数</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

  <tr>
    <td>局部变量</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

</table>


<a id="s3.17-main"></a>
<a id="317-main"></a>

<a id="math-notation"></a>
#### 3.16.5 数学符号 

对于数学密集型代码，首选与参考论文或算法中已建立的符号相匹配的简短变量名，即使这些名称可能违反风格指南。

在使用基于已建立符号的名称时：

1. 在注释或文档字符串中引用所有命名约定的来源，最好提供指向学术资源本身的超链接。如果来源不可访问，请清楚地记录命名约定。
2. 对于公共API，首选符合PEP8的`descriptive_names`，因为它们更可能在脱离上下文的情况下被遇到。
3. 使用范围狭窄的`pylint: disable=invalid-name`指令来静默警告。对于少数几个变量，将指令作为每条变量的行尾注释；对于更多变量，在代码块开始处应用指令。

<a id="main"></a>
### 3.17 主函数 

在Python中，`pydoc`以及单元测试需要模块是可导入的。如果一个文件旨在作为可执行文件使用，其主要功能应放在`main()`函数中，并且您的代码应始终在执行主程序之前检查`if __name__ == '__main__'`，以便在模块被导入时不执行。

当使用[absl](https://github.com/abseil/abseil-py)时，使用`app.run`：

```python
from absl import app
...

def main(argv: Sequence[str]):
    # 处理非标志参数
    ...

if __name__ == '__main__':
    app.run(main)
```

否则，使用：

```python
def main():
    ...

if __name__ == '__main__':
    main()
```

顶级的所有代码在模块被导入时将被执行。请注意不要调用函数、创建对象或执行在文件被`pydoc`时不应执行的其他操作。

<a id="s3.18-function-length"></a>
<a id="318-function-length"></a>

<a id="function-length"></a>
### 3.18 函数长度 

首选小而集中的函数。

我们认识到有时长函数是合适的，因此没有对函数长度设定硬性限制。如果一个函数超过大约40行，请考虑是否可以在不损害程序结构的情况下将其拆分。

即使您的长函数现在运行得很完美，几个月后有人修改它时可能会添加新行为。这可能会导致难以发现的错误。保持您的函数简短和简单，使其他人更容易阅读和修改您的代码。

在处理某些代码时，您可能会遇到长而复杂的函数。不要被修改现有代码所吓倒：如果处理这样的函数证明是困难的，您发现错误难以调试，或者您想在几个不同的上下文中使用它的某部分，请考虑将函数拆分成更小、更易管理的部分。

<a id="s3.19-type-annotations"></a>
<a id="319-type-annotations"></a>

<a id="type-annotations"></a>
```
### 3.19 类型注解

<a id="s3.19.1-general-rules"></a>
<a id="s3.19.1-general"></a>
<a id="3191-general-rules"></a>

<a id="typing-general"></a>
#### 3.19.1 通用规则

*   熟悉[类型提示](https://docs.python.org/3/library/typing.html)。

*   通常不需要为`self`或`cls`添加注解。如果需要正确的类型信息，可以使用[`Self`](https://docs.python.org/3/library/typing.html#typing.Self)，例如：

    ```python
    from typing import Self

    class BaseClass:
      @classmethod
      def create(cls) -> Self:
        ...

      def difference(self, other: Self) -> float:
        ...
    ```

*   同样，不必为`__init__`的返回值添加注解（唯一有效的选项是`None`）。

*   如果其他变量或返回类型不应被表达，使用`Any`。

*   你不需要为模块中的所有函数添加注解。

    -   至少为你的公共API添加注解。
    -   在安全性和清晰性与灵活性之间取得良好的平衡时，请运用判断力。
    -   为容易出现类型相关错误的代码（之前的错误或复杂性）添加注解。
    -   为难以理解的代码添加注解。
    -   当代码从类型角度变得稳定时添加注解。在许多情况下，你可以在不失去太多灵活性的情况下为成熟代码中的所有函数添加注解。

<a id="s3.19.2-line-breaking"></a>
<a id="3192-line-breaking"></a>

<a id="typing-line-breaking"></a>
#### 3.19.2 换行

尽量遵循现有的[缩进](#indentation)规则。

在添加注解后，许多函数签名将变成“每行一个参数”。为了确保返回类型也有自己的行，可以在最后一个参数后添加逗号。

```python
def my_method(
    self,
    first_var: int,
    second_var: Foo,
    third_var: Bar | None,
) -> int:
  ...
```

始终优先在变量之间换行，而不是例如在变量名和类型注解之间。然而，如果所有内容都能在一行上显示，那就这样做。

```python
def my_method(self, first_var: int) -> int:
  ...
```

如果函数名、最后一个参数和返回类型的组合太长，在新行上缩进4个空格。当使用换行时，优先将每个参数和返回类型放在各自的行上，并将闭合括号与`def`对齐：

```python
Yes:
def my_method(
    self,
    other_arg: MyLongType | None,
) -> tuple[MyLongType1, MyLongType1]:
  ...
```

可选地，返回类型可以与最后一个参数放在同一行：

```python
Okay:
def my_method(
    self,
    first_var: int,
    second_var: int) -> dict[OtherLongType, MyLongType]:
  ...
```

`pylint`允许你将闭合括号移到新行并与开启括号对齐，但这样可读性较差。

```python
No:
def my_method(self,
              other_arg: MyLongType | None,
             ) -> dict[OtherLongType, MyLongType]:
  ...
```

如上例所示，优先不拆分类型。然而，有时它们太长而无法在一行上显示（尽量保持子类型不拆分）。

```python
def my_method(
    self,
    first_var: tuple[list[MyLongType1],
                     list[MyLongType2]],
    second_var: list[dict[
        MyLongType3, MyLongType4]],
) -> None:
  ...
```

如果单个名称和类型太长，考虑使用[别名](#typing-aliases)来表示类型。最后的手段是在冒号后换行并缩进4个空格。

```python
Yes:
def my_function(
    long_variable_name:
        long_module_name.LongTypeName,
) -> None:
  ...
```

```python
No:
def my_function(
    long_variable_name: long_module_name.
        LongTypeName,
) -> None:
  ...
```

<a id="s3.19.3-forward-declarations"></a>
<a id="3193-forward-declarations"></a>

<a id="forward-declarations"></a>
#### 3.19.3 前向声明

如果你需要使用同一个模块中尚未定义的类名——例如，如果你需要在该类的声明中使用类名，或者你使用了代码中稍后定义的类——要么使用`from __future__ import annotations`，要么为类名使用字符串。

```python
Yes:
from __future__ import annotations

class MyClass:
  def __init__(self, stack: Sequence[MyClass], item: OtherClass) -> None:

class OtherClass:
  ...
```

```python
Yes:
class MyClass:
  def __init__(self, stack: Sequence['MyClass'], item: 'OtherClass') -> None:

class OtherClass:
  ...
```

<a id="s3.19.4-default-values"></a>
<a id="3194-default-values"></a>

<a id="typing-default-values"></a>
#### 3.19.4 默认值

根据 [PEP-008](https://peps.python.org/pep-0008/#other-recommendations) 的规定，仅在参数同时具有类型注解和默认值时，在 `=` 周围使用空格。

```python
正确：
def func(a: int = 0) -> int:
  ...
```

```python
错误：
def func(a:int=0) -> int:
  ...
```

<a id="s3.19.5-nonetype"></a>
<a id="s3.19.5-none-type"></a>
<a id="3195-nonetype"></a>

<a id="none-type"></a>
#### 3.19.5 NoneType 

在 Python 类型系统中，`NoneType` 是一种“一等”类型，而 `None` 是 `NoneType` 的别名。如果一个参数可以是 `None`，则必须进行声明！您可以使用 `|` 联合类型表达式（在 Python 3.10+ 的新代码中推荐），或者使用旧的 `Optional` 和 `Union` 语法。

请使用显式的 `X | None` 而不是隐式的。在早期的类型检查器版本中，`a: str = None` 会被解释为 `a: str | None = None`，但这不再是首选行为。

```python
正确：
def modern_or_union(a: str | int | None, b: str | None = None) -> str:
  ...
def union_optional(a: Union[str, int, None], b: Optional[str] = None) -> str:
  ...
```

```python
错误：
def nullable_union(a: Union[None, str]) -> str:
  ...
def implicit_optional(a: str = None) -> str:
  ...
```

<a id="s3.19.6-type-aliases"></a>
<a id="s3.19.6-aliases"></a>
<a id="3196-type-aliases"></a>
<a id="typing-aliases"></a>

<a id="type-aliases"></a>
#### 3.19.6 类型别名 

您可以声明复杂类型的别名。别名的名称应采用 CapWorded 格式。如果别名仅在本模块中使用，则应为 \_Private。

请注意，`: TypeAlias` 注解仅在 3.10+ 版本中支持。

```python
from typing import TypeAlias

_LossAndGradient: TypeAlias = tuple[tf.Tensor, tf.Tensor]
ComplexTFMap: TypeAlias = Mapping[str, _LossAndGradient]
```

<a id="s3.19.7-ignoring-types"></a>
<a id="s3.19.7-ignore"></a>
<a id="3197-ignoring-types"></a>

<a id="typing-ignore"></a>
#### 3.19.7 忽略类型 

您可以通过特殊注释 `# type: ignore` 在一行上禁用类型检查。

`pytype` 对于特定错误有禁用选项（类似于 lint）：

```python
# pytype: disable=attribute-error
```

<a id="s3.19.8-typing-variables"></a>
<a id="s3.19.8-comments"></a>
<a id="3198-typing-internal-variables"></a>

<a id="typing-variables"></a>
#### 3.19.8 变量类型标注 

<a id="annotated-assignments"></a>
[*带注释的赋值*](#annotated-assignments)
:   如果内部变量的类型难以推断或无法推断，请使用带注释的赋值来指定其类型 - 在变量名和值之间使用冒号和类型（与具有默认值的函数参数的做法相同）：

    ```python
    a: Foo = SomeUndecoratedFunction()
    ```

<a id="type-comments"></a>
[*类型注释*](#type-comments)
:   虽然您可能会在代码库中看到它们（在Python 3.6之前它们是必要的），但不要在行尾添加更多使用 `# type: <类型名称>` 的注释：

    ```python
    a = SomeUndecoratedFunction()  # type: Foo
    ```

<a id="s3.19.9-tuples-vs-lists"></a>
<a id="s3.19.9-tuples"></a>
<a id="3199-tuples-vs-lists"></a>

<a id="typing-tuples"></a>
#### 3.19.9 元组与列表 

类型化的列表只能包含单一类型的对象。类型化的元组可以具有单一重复类型，或者具有不同类型的固定数量的元素。后者通常用作函数的返回类型。

```python
a: list[int] = [1, 2, 3]
b: tuple[int, ...] = (1, 2, 3)
c: tuple[int, str, float] = (1, "2", 3.5)
```

<a id="s3.19.10-typevars"></a>
<a id="s3.19.10-type-var"></a>
<a id="31910-typevar"></a>
<a id="typing-type-var"></a>

<a id="typevars"></a>
#### 3.19.10 类型变量 

Python类型系统具有[泛型](https://docs.python.org/3/library/typing.html#generics)。类型变量，如 `TypeVar` 和 `ParamSpec`，是使用它们的常见方式。

示例：

```python
from collections.abc import Callable
from typing import ParamSpec, TypeVar
_P = ParamSpec("_P")
_T = TypeVar("_T")
...
def next(l: list[_T]) -> _T:
  return l.pop()

def print_when_called(f: Callable[_P, _T]) -> Callable[_P, _T]:
  def inner(*args: _P.args, **kwargs: _P.kwargs) -> _T:
    print("函数被调用")
    return f(*args, **kwargs)
  return inner
```

`TypeVar` 可以被约束：

```python
AddableType = TypeVar("AddableType", int, float, str)
def add(a: AddableType, b: AddableType) -> AddableType:
  return a + b
```

`typing` 模块中常见的预定义类型变量是 `AnyStr`。当多个注释可以是 `bytes` 或 `str` 且必须是相同类型时使用它。

```python
from typing import AnyStr
def check_length(x: AnyStr) -> AnyStr:
  if len(x) <= 42:
    return x
  raise ValueError()
```

类型变量必须具有描述性名称，除非它满足以下所有条件：

*   不对外可见
*   未被约束

```python
正确：
  _T = TypeVar("_T")
  _P = ParamSpec("_P")
  AddableType = TypeVar("AddableType", int, float, str)
  AnyFunction = TypeVar("AnyFunction", bound=Callable)
```

```python
错误：
  T = TypeVar("T")
  P = ParamSpec("P")
  _T = TypeVar("_T", int, float, str)
  _F = TypeVar("_F", bound=Callable)
```

<a id="s3.19.11-string-types"></a>
<a id="s3.19.11-strings"></a>
<a id="31911-string-types"></a>

<a id="typing-strings"></a>
#### 3.19.11 字符串类型 

> 在新代码中不要使用 `typing.Text`。它仅用于Python 2/3兼容性。

对于字符串/文本数据，使用 `str`。对于处理二进制数据的代码，使用 `bytes`。

```python
def deals_with_text_data(x: str) -> str:
  ...
def deals_with_binary_data(x: bytes) -> bytes:
  ...
```

如果函数的所有字符串类型始终相同，例如如果返回类型与上述代码中的参数类型相同，请使用 [AnyStr](#typing-type-var)。

<a id="s3.19.12-imports-for-typing"></a>
<a id="s3.19.12-imports"></a>
<a id="31912-imports-for-typing"></a>

<a id="typing-imports"></a>
#### 3.19.12 用于类型标注的导入 

对于用于支持静态分析和类型检查的 `typing` 或 `collections.abc` 模块中的符号（包括类型、函数和常量），始终导入符号本身。这使得常见的注释更加简洁，并与全球使用的类型标注实践相匹配。您明确允许从 `typing` 和 `collections.abc` 模块中在一行上导入多个特定符号。例如：

```python
from collections.abc import Mapping, Sequence
from typing import Any, Generic, cast, TYPE_CHECKING
```
```
鉴于这种导入方式会将项目添加到本地命名空间中，`typing` 或 `collections.abc` 中的名称应被视为关键字处理，不应在您的 Python 代码中定义，无论是否有类型注解。如果某个类型与模块中已存在的名称发生冲突，请使用 `import x as y` 进行导入。

```python
from typing import Any as AnyType
```

在标注函数签名时，优先使用抽象容器类型，如 `collections.abc.Sequence`，而不是具体类型，如 `list`。如果需要使用具体类型（例如，带有类型元素的 `tuple`），请优先使用内置类型，如 `tuple`，而不是 `typing` 模块中的参数化类型别名（例如，`typing.Tuple`）。

```python
from typing import List, Tuple

def transform_coordinates(original: List[Tuple[float, float]]) ->
    List[Tuple[float, float]]:
  ...
```

```python
from collections.abc import Sequence

def transform_coordinates(original: Sequence[tuple[float, float]]) ->
    Sequence[tuple[float, float]]:
  ...
```

<a id="s3.19.13-conditional-imports"></a>
<a id="31913-conditional-imports"></a>

<a id="typing-conditional-imports"></a>
#### 3.19.13 条件导入

仅在特殊情况下使用条件导入，即在运行时必须避免为类型检查所需的额外导入。这种模式是不鼓励的；应优先考虑重构代码以允许顶级导入的替代方案。

仅用于类型注解的导入可以放在 `if TYPE_CHECKING:` 块中。

- 条件导入的类型需要以字符串形式引用，以便与 Python 3.6 向前兼容，在该版本中注解表达式实际上会被评估。
- 仅应在此处定义用于类型化的实体；这包括别名。否则，将在运行时导致错误，因为模块不会在运行时被导入。
- 该块应紧跟在所有常规导入之后。
- 类型导入列表中不应有空行。
- 按常规导入列表的方式对其进行排序。

```python
import typing
if typing.TYPE_CHECKING:
  import sketch
def f(x: "sketch.Sketch"): ...
```

<a id="s3.19.14-circular-dependencies"></a>
<a id="s3.19.14-circular-deps"></a>
<a id="31914-circular-dependencies"></a>

<a id="typing-circular-deps"></a>
#### 3.19.14 循环依赖

由类型化引起的循环依赖是代码异味。这种代码是重构的好候选对象。虽然技术上可以保留循环依赖，但各种构建系统不会允许您这样做，因为每个模块都必须依赖另一个模块。

用 `Any` 替换创建循环依赖导入的模块。设置一个具有意义名称的[别名](#typing-aliases)，并使用该模块中的真实类型名称（`Any` 的任何属性都是 `Any`）。别名定义应与最后一个导入之间隔一行。

```python
from typing import Any

some_mod = Any  # some_mod.py 导入此模块。
...

def my_method(self, var: "some_mod.SomeType") -> None:
  ...
```

<a id="typing-generics"></a>
<a id="s3.19.15-generics"></a>
<a id="31915-generics"></a>

<a id="generics"></a>
#### 3.19.15 泛型

在进行类型注解时，优先在参数列表中指定[泛型](https://docs.python.org/3/library/typing.html#generics)的类型参数；否则，泛型的参数将被假定为 [`Any`](https://docs.python.org/3/library/typing.html#the-any-type)。

```python
# 是：
def get_names(employee_ids: Sequence[int]) -> Mapping[int, str]:
  ...
```

```python
# 否：
# 这被解释为 get_names(employee_ids: Sequence[Any]) -> Mapping[Any, Any]
def get_names(employee_ids: Sequence) -> Mapping:
  ...
```

如果泛型的最佳类型参数是 `Any`，请明确指出，但请记住，在许多情况下 [`TypeVar`](#typing-type-var) 可能更合适：

```python
# 否：
def get_names(employee_ids: Sequence[Any]) -> Mapping[Any, str]:
  """返回给定 ID 的员工 ID 到员工姓名的映射。"""
```

```python
# 是：
_T = TypeVar('_T')
def get_names(employee_ids: Sequence[_T]) -> Mapping[_T, str]:
  """返回给定 ID 的员工 ID 到员工姓名的映射。"""
```


<a id="4-parting-words"></a>

<a id="consistency"></a>
## 4 结束语

*保持一致性*。

如果你在编辑代码，请花几分钟时间查看周围的代码并确定其风格。如果他们在索引变量名中使用 `_idx` 后缀，你也应该这样做。如果他们的注释周围有小方框的哈希标记，你的注释也应该有小方框的哈希标记。

制定风格指南的目的是建立一个共同的编码词汇表，让人们能够专注于你要表达的内容，而不是你表达的方式。我们在这里提出全球风格规则，以便人们了解这个词汇表，但本地风格也很重要。如果你添加到文件中的代码与周围现有代码看起来大不相同，读者在阅读时就会被打乱节奏。

然而，一致性是有限度的。它在本地应用得更为重要，并且适用于全球风格未指定的选择。一致性通常不应被用作在不考虑新风格的好处或代码库随时间趋向于采用更新风格的倾向的情况下，继续使用旧风格的理由。