# README 文件

关于 README.md 文件。

1.  [概述](#概述)
1.  [可读的 README 文件](#可读的-readme-文件)
1.  [README 文件的放置位置](#readme-文件的放置位置)
1.  [README 文件应包含的内容](#readme-文件应包含的内容)

## 概述

README 文件是对目录内容的简短总结。当你在 GitHub 和 Gitiles 上查看包含该目录的内容时，文件内容会显示出来。README 文件为浏览你的代码的人们提供了关键信息，特别是首次使用者。

本文档介绍如何创建可在 GitHub 和 Gitiles 上阅读的 README 文件。

## 可读的 README 文件

**README 文件必须命名为 `README.md`。** 文件名*必须*以 `.md` 扩展名结尾，且大小写敏感。

例如，当你查看包含该目录的内容时，文件 /README.md 会被渲染：

https://github.com/google/styleguide/tree/gh-pages

此外，`README.md` 在 `HEAD` 引用时也会被 Gitiles 渲染，用于显示仓库索引：

https://gerrit.googlesource.com/gitiles/

## README 文件的放置位置

与所有其他 Markdown 文件不同，`README.md` 文件不应位于你的产品或库的文档目录内。`README.md` 文件应位于你的产品或库实际代码库的顶级目录中。

代码包的所有顶级目录都应有一个最新的 `README.md` 文件。这对于提供其他团队接口的包目录尤为重要。

## README 文件应包含的内容

你的 `README.md` 文件至少应包含指向用户和/或团队文档的链接。

每个包级别的 `README.md` 应包含或指向以下信息：

1.  此包或库中包含什么内容及其用途。
1.  联系人。
1.  此包或库是否已废弃，或不适合一般发布等状态。
1.  如何使用此包或库。示例包括示例代码、可复制的 `bazel run` 或 `bazel test` 命令等。
1.  相关文档的链接。