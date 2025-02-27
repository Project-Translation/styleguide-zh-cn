# Google R 风格指南

R 是一种主要用于统计计算和图形的高级编程语言。R 编程风格指南的目标是使我们的 R 代码更易于阅读、分享和验证。

Google R 风格指南是 Hadley Wickham 的 [Tidyverse 风格指南](https://style.tidyverse.org/) 的分支，[许可证](https://creativecommons.org/licenses/by-sa/2.0/)。Google 的修改是在内部 R 用户社区的合作下开发的。本文档的其余部分解释了 Google 与 Tidyverse 指南的主要差异，以及这些差异存在的原因。

## 语法

### 命名约定

Google 更喜欢使用 `BigCamelCase` 来标识函数，以便清楚地区分它们与其他对象。

```
# 好
DoNothing <- function() {
  return(invisible(NULL))
}
```

私有函数的名称应以点开头。这有助于传达函数的来源及其预期用途。

```
# 好
.DoNothingPrivately <- function() {
  return(invisible(NULL))
}
```

我们之前推荐使用 `dot.case` 来命名对象。我们正在远离这种做法，因为它会与 S3 方法产生混淆。

### 不要使用 attach()

使用 `attach()` 时，产生错误的可能性很多。

## 管道

### 右侧赋值

我们不支持使用右侧赋值。

```
# 坏
iris %>%
  dplyr::summarize(max_petal = max(Petal.Width)) -> results
```

这种约定与其他语言的做法大相径庭，使得在代码中难以看出对象是在哪里定义的。例如，搜索 `foo <-` 比搜索 `foo <-` 和 `-> foo`（可能分成多行）更容易。

### 使用显式返回

不要依赖 R 的隐式返回功能。明确表示你打算 `return()` 一个对象会更好。

```
# 好
AddValues <- function(x, y) {
  return(x + y)
}

# 坏
AddValues <- function(x, y) {
  x + y
}
```

### 限定命名空间

用户应为所有外部函数明确限定命名空间。

```
# 好
purrr::map()
```

我们不鼓励使用 `@import` Roxygen 标签将所有函数引入 NAMESPACE。Google 有一个非常大的 R 代码库，导入所有函数会带来名称冲突的太大风险。

虽然使用 `::` 会有一定的性能损失，但它使理解代码中的依赖关系变得更容易。此规则有一些例外。

*   中缀函数（`%name%`）总是需要导入。
*   某些 `rlang` 代词，尤其是 `.data`，需要导入。
*   来自默认 R 包的函数，包括 `datasets`, `utils`, `grDevices`, `graphics`, `stats` 和 `methods`。如果需要，可以 `@import` 整个包。

在导入函数时，将 `@importFrom` 标签放在使用外部依赖的函数上方的 Roxygen 头部。

## 文档

### 包级文档

所有包都应有一个包文档文件，放在 `packagename-package.R` 文件中。