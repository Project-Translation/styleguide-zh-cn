<!--
AUTHORS:
在外部文本中，优先使用 GitHub 风格的 Markdown。
详细信息请参见 README.md。
-->

# Shell 风格指南

由许多 Googler 撰写、修订和维护。

## 目录

部分                                                                              | 内容
------------------------------------------------------------------------------------ | --------
[背景](#s1-background)                                                             | [使用哪种 Shell](#s1.1-which-shell-to-use) - [何时使用 Shell](#s1.2-when-to-use-shell)
[Shell 文件和解释器调用](#s2-shell-files-and-interpreter-invocation)                | [文件扩展名](#s2.1-file-extensions) - [SUID/SGID](#s2.2-suid-sgid)
[环境](#s3-environment)                                                             | [STDOUT 与 STDERR](#s3.1-stdout-vs-stderr)
[注释](#s4-comments)                                                                | [文件头](#s4.1-file-header) - [函数注释](#s4.2-function-comments) - [实现注释](#s4.3-implementation-comments) - [TODO 注释](#s4.4-todo-comments)
[格式化](#s5-formatting)                                                            | [缩进](#s5.1-indentation) - [行长度和长字符串](#s5.2-line-length-and-long-strings) - [管道](#s5.3-pipelines) - [控制流](#s5.4-control-flow) - [Case 语句](#s5.5-case-statement) - [变量扩展](#s5.6-variable-expansion) - [引用](#s5.7-quoting)
[功能和错误](#s6-features-and-bugs)                                                 | [ShellCheck](#s6.1-shellcheck) - [命令替换](#s6.2-command-substitution) - [Test, `[… ]`, 和 `[[… ]]`](#s6.3-tests) - [测试字符串](#s6.4-testing-strings) - [文件名通配符扩展](#s6.5-wildcard-expansion-of-filenames) - [Eval](#s6.6-eval) - [数组](#s6.7-arrays) - [管道到 While](#s6.8-pipes-to-while) - [算术运算](#s6.9-arithmetic) - [别名](#s6.10-aliases)
[命名约定](#s7-naming-conventions)                                                  | [函数名称](#s7.1-function-names) - [变量名称](#s7.2-variable-names) - [常量和环境变量名称](#s7.3-constants-and-environment-variable-names) - [源文件名称](#s7.4-source-filenames) - [使用局部变量](#s7.5-use-local-variables) - [函数位置](#s7.6-function-location) - [main](#s7.7-main)
[调用命令](#s8-calling-commands)                                                    | [检查返回值](#s8.1-checking-return-values) - [内置命令与外部命令](#s8.2-builtin-commands-vs-external-commands)
[当有疑问时：保持一致](#s9-conclusion)                                              |

<a id="s1-background"></a>

## 背景

<a id="s1.1-which-shell-to-use"></a>

### 使用哪种 Shell

Bash 是唯一允许用于可执行文件的 shell 脚本语言。

可执行文件必须以 `#!/bin/bash` 开头，并使用最少的标志。使用 `set` 来设置 shell 选项，以便以 `bash script_name` 的方式调用脚本时不会破坏其功能。

将所有可执行 shell 脚本限制为 *bash* 可以为我们提供一种在所有机器上都安装的统一的 shell 语言。特别是，这意味着通常没有必要追求 POSIX 兼容性或避免使用 "bashisms"。

上述规则的唯一例外是当您被您编写的代码所强制时。例如，一些旧操作系统或受限的执行环境可能需要对于某些脚本使用纯 Bourne shell。

<a id="s1.2-when-to-use-shell"></a>

### 何时使用 Shell

Shell 仅应用于小型实用程序或简单的包装脚本。

虽然 shell 脚本不是一种开发语言，但在 Google 内部用于编写各种实用脚本。本风格指南更多是承认其使用，而不是建议广泛部署。

一些指导原则：

*   如果您主要是调用其他实用程序，并且进行的 数据操作相对较少，shell 是完成任务的可接受选择。
*   如果性能很重要，请使用 shell 以外的其他东西。
*   如果您编写的脚本超过 100 行，或者使用了非直观的控制流逻辑，您应该立即用更结构化的语言重写它。请记住，脚本会增长。及早重写您的脚本，以避免日后更耗时的重写。
*   在评估代码的复杂性时（例如，决定是否切换语言），请考虑代码是否容易被除作者之外的其他人维护。
### 文件扩展名

可执行文件应具有 `.sh` 扩展名或无扩展名。

- 如果可执行文件将有一个构建规则来重命名源文件，则应使用 `.sh` 扩展名。这使您可以使用推荐的命名约定，源文件如 `foo.sh`，构建规则命名为 `foo`。
- 如果可执行文件将直接添加到用户的 `PATH` 中，则应使用无扩展名。执行程序时无需知道程序是用哪种语言编写的，shell 也不需要扩展名，因此我们倾向于不对将由用户直接调用的可执行文件使用扩展名。同时，考虑是否最好部署构建规则的输出，而不是直接部署源文件。
- 如果以上两者都不适用，则两种选择均可接受。

库文件必须具有 `.sh` 扩展名，并且不应具有可执行权限。

<a id="s2.2-suid-sgid"></a>

### SUID/SGID

在 shell 脚本中禁止使用 SUID 和 SGID。

shell 存在太多安全问题，使得几乎不可能充分保护以允许 SUID/SGID。虽然 bash 确实使得运行 SUID 变得困难，但在某些平台上仍然是可能的，这就是我们明确禁止它的原因。

如果需要提升权限，请使用 `sudo`。

<a id="s3-environment"></a>

## 环境

<a id="s3.1-stdout-vs-stderr"></a>

### STDOUT 与 STDERR

所有错误消息应输出到 `STDERR`。

这样可以更容易地区分正常状态和实际问题。

建议使用一个函数来打印错误消息以及其他状态信息。

```shell
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

if ! do_something; then
  err "无法执行 do_something"
  exit 1
fi
```

<a id="s4-comments"></a>

## 注释

<a id="s4.1-file-header"></a>

### 文件头

每个文件应以对其内容的描述开始。

每个文件必须有一个顶级注释，包括对其内容的简要概述。版权声明和作者信息是可选的。

示例：

```shell
#!/bin/bash
#
# 对 Oracle 数据库执行热备份。
```

<a id="s4.2-function-comments"></a>

### 函数注释

任何不是既明显又简短的函数都必须有函数头注释。库中的任何函数，无论长度或复杂度如何，都必须有函数头注释。

其他人应该能够通过阅读注释（以及提供的自助信息，如果有的话）而不必阅读代码，就能学会如何使用您的程序或使用库中的函数。

所有函数头注释都应使用以下内容描述预期的 API 行为：

* 函数的描述。
* 全局变量：使用的和修改的全局变量列表。
* 参数：接受的参数。
* 输出：输出到 STDOUT 或 STDERR。
* 返回值：除了最后运行的命令的默认退出状态之外的返回值。

示例：

```shell
#######################################
# 从备份目录中清理文件。
# 全局变量：
#   BACKUP_DIR
#   ORACLE_SID
# 参数：
#   无
#######################################
function cleanup() {
  …
}

#######################################
# 获取配置目录。
# 全局变量：
#   SOMEDIR
# 参数：
#   无
# 输出：
#   将位置写入 stdout
#######################################
function get_dir() {
  echo "${SOMEDIR}"
}

#######################################
# 以复杂的方式删除文件。
# 参数：
#   要删除的文件路径。
# 返回值：
#   如果删除成功返回 0，错误时返回非零值。
#######################################
function del_thing() {
  rm "$1"
}
```

<a id="s4.3-implementation-comments"></a>

### 实现注释

对代码中棘手的、非显而易见的、有趣的或重要的部分进行注释。

这遵循一般的 Google 编码注释实践。不要对所有内容进行注释。如果存在复杂的算法或您正在做一些不寻常的事情，请添加一个简短的注释。

<a id="s4.4-todo-comments"></a>

### TODO 注释

对临时代码、短期解决方案或足够好但不完美的代码使用 TODO 注释。

这与 [C++ 指南](https://jqknono.github.io/styleguide/cppguide.html#TODO_Comments) 中的约定相匹配。

TODO 应包含全大写的字符串 `TODO`，后跟对问题有最佳了解的人的姓名、电子邮件地址或其他标识符。主要目的是拥有一个一致的 `TODO`，可以搜索以了解如何在需要时获取更多详细信息。TODO 并不是对所提及的人承诺解决问题。因此，当您创建一个 TODO 时，几乎总是给出您自己的名字。

示例：

```shell
# TODO(mrmonkey): 处理不太可能的边缘情况（错误 ####）
```

<a id="s5-formatting"></a>

## 格式化

虽然您应该遵循您正在修改的文件中已有的风格，但对于任何新代码，以下是必需的。

<a id="s5.1-indentation"></a>
### 缩进

缩进使用2个空格。不要使用制表符。

在代码块之间使用空行以提高可读性。缩进为两个空格。无论你做什么，都不要使用制表符。对于现有文件，保持与现有缩进一致。

**例外：** 使用制表符的唯一例外是 `<<-` 标签缩进的 [here-document](https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Here-Documents) 主体。

<a id="s5.2-line-length-and-long-strings"></a>

### 行长度和长字符串

最大行长度为80个字符。

如果你必须编写超过80个字符的字面字符串，应该尽可能使用 [here-document](https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Here-Documents) 或嵌入换行符来完成。

超过80个字符且无法合理分割的单词是可以的，但尽可能将这些项目放在单独的一行上，或将其分解为变量。例如，文件路径和URL，特别是在维护时进行字符串匹配（如 `grep`）很有价值的情况下。

```shell
# 使用 'here document'
cat <<END
我是一个异常长的
字符串。
END

# 嵌入换行符也是可以的
long_string="我是一个异常
长的字符串。"

long_file="/i/am/an/exceptionally/loooooooooooooooooooooooooooooooooooooooooooooooooooong_file"

long_string_with_long_file="我包含一个异常长的 \
/very/long/file\
在这个长字符串中。"

# 将长文件转换为较短的变量名，并进行更清晰的换行。
long_string_alt="我包含一个异常长的 ${long_file} 在这个长\
字符串中"
```

```shell
# 仅仅因为一行包含例外，并不意味着该行的其余部分不应该像往常一样换行。

bad_long_string_with_long_file="我包含一个异常长的 /very/long/file 在这个长字符串中。"
```

<a id="s5.3-pipelines"></a>

### 管道

如果管道不能在一行内全部显示，则应每行分割一个管道段。

如果一个管道能在一行内显示，则应在一行内显示。

如果不能，则应在每行分割一个管道段，管道符号放在新行上，下一段管道缩进2个空格。应一致使用 `\ ` 来表示行继续。这适用于使用 `|` 组合的命令链，也适用于使用 `||` 和 `&&` 的逻辑复合。

```shell
# 全部在一行内
command1 | command2

# 长命令
command1 \
  | command2 \
  | command3 \
  | command4
```

这有助于在区分管道和常规长命令继续时提高可读性，特别是如果该行同时使用两者。

注释需要在整个管道之前。如果注释和管道都很大且复杂，那么值得考虑使用辅助函数将它们的低级细节移开。

<a id="s5.4-control-flow"></a>

<!-- 之前的章节标题为 "Loops" -->

<a id="s5.4-loops"></a>
<a id="loops"></a>

### 控制流

将 `; then` 和 `; do` 放在 `if`、`for` 或 `while` 相同的行上。

shell 中的控制流语句有点不同，但我们遵循与声明函数时使用大括号相同的原则。即：`; then` 和 `; do` 应与 `if`/`for`/`while`/`until`/`select` 放在同一行上。`else` 应单独一行，结束语句（`fi` 和 `done`）应单独一行，与开始语句垂直对齐。

示例：

```shell
# 在函数内部记得将循环变量声明为
# 本地变量，以避免其泄露到全局环境中：
local dir
for dir in "${dirs_to_cleanup[@]}"; do
  if [[ -d "${dir}/${SESSION_ID}" ]]; then
    log_date "清理 ${dir}/${SESSION_ID} 中的旧文件"
    rm "${dir}/${SESSION_ID}/"* || error_message
  else
    mkdir -p "${dir}/${SESSION_ID}" || error_message
  fi
done
```

虽然在 for 循环中可以[省略 `in "$@"`](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#index-for)，但我们建议为了清晰起见始终包含它。

```shell
for arg in "$@"; do
  echo "参数: ${arg}"
done
```

<a id="s5.5-case-statement"></a>
### Case 语句

*   替代方案缩进 2 个空格。
*   一行替代方案需要在模式的闭合括号后和 `;;` 前留一个空格。
*   长命令或多命令替代方案应分成多行，模式、动作和 `;;` 各占一行。

匹配表达式相对于 `case` 和 `esac` 缩进一级。多行动作再缩进一级。一般来说，匹配表达式不需要加引号。模式表达式前不应有开括号。避免使用 `;&` 和 `;;&` 符号。

```shell
case "${expression}" in
  a)
    variable="…"
    some_command "${variable}" "${other_expr}" …
    ;;
  absolute)
    actions="relative"
    another_command "${actions}" "${other_expr}" …
    ;;
  *)
    error "Unexpected expression '${expression}'"
    ;;
esac
```

简单命令可以与模式和 `;;` 放在同一行，只要表达式保持可读性即可。这通常适用于单字母选项处理。当动作无法在一行内完成时，将模式单独放在一行，然后是动作，最后 `;;` 也单独放在一行。当与动作在同一行时，在模式的闭合括号后和 `;;` 前各留一个空格。

```shell
verbose='false'
aflag=''
bflag=''
files=''
while getopts 'abf:v' flag; do
  case "${flag}" in
    a) aflag='true' ;;
    b) bflag='true' ;;
    f) files="${OPTARG}" ;;
    v) verbose='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done
```

<a id="s5.6-variable-expansion"></a>

### 变量扩展

按优先级顺序：保持与现有代码一致；对变量加引号；优先使用 `"${var}"` 而不是 `"$var"`。

这些是强烈推荐的指导方针，但不是强制规定。尽管如此，推荐而非强制并不意味着可以轻视或忽视。

它们按优先级顺序列出。

*   保持与现有代码一致。
*   对变量加引号，参见下面的[引号部分](#quoting)。
*   除非绝对必要或避免严重混淆，否则不要对单字符的 shell 特殊变量/位置参数使用大括号。

优先对所有其他变量使用大括号。

```shell
# *推荐*案例部分。

# '特殊'变量的首选样式：
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# 需要大括号：
echo "many parameters: ${10}"

# 大括号避免混淆：
# 输出是 "a0b0c0"
set -- a b c
echo "${1}0${2}0${3}0"

# 其他变量的首选样式：
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
while read -r f; do
  echo "file=${f}"
done < <(find /tmp)
```

```shell
# *不推荐*案例部分

# 未加引号的变量，未加大括号的变量，对单字母 shell 特殊变量使用大括号。
echo a=$avar "b=$bvar" "PID=${$}" "${1}"

# 混淆使用：这被扩展为 "${1}0${2}0${3}0"，
# 而不是 "${10}${20}${30}
set -- a b c
echo "$10$20$30"
```

注意：在 `${var}` 中使用大括号*不是*一种引号形式。必须*同时*使用“双引号”。

<a id="s5.7-quoting"></a>

### 引号

*   除非需要小心地未加引号的扩展或它是 shell 内部整数（见下一点），否则始终对包含变量、命令替换、空格或 shell 元字符的字符串加引号。
*   使用数组来安全地引用元素列表，尤其是命令行标志。参见下面的[数组](#arrays)。
*   可选择性地对定义为整数的 shell 内部、只读[特殊变量](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)加引号：`$?`, `$#`, `$$`, `$!`。为了保持一致性，优先对“命名”的内部整数变量加引号，例如 PPID 等。
*   优先对作为“单词”的字符串加引号（相对于命令选项或路径名）。
*   注意在 `[[ … ]]` 中模式匹配的引号规则。参见下面的[测试、`[ … ]` 和 `[[ … ]]`](#tests)部分。
*   使用 `"$@"` 除非你有特定的理由使用 `$*`，例如简单地将参数附加到消息或日志中的字符串。

```shell
# '单'引号表示不需要替换。
# "双"引号表示需要/容忍替换。

# 简单示例

# "对命令替换加引号"
```shell
# 注意，嵌套在 "$()" 中的引号不需要转义。
flag="$(some_command and its args "$@" 'quoted separately')"

# "引用变量"
echo "${flag}"

# 使用带引号扩展的数组处理列表。
declare -a FLAGS
FLAGS=( --foo --bar='baz' )
readonly FLAGS
mybinary "${FLAGS[@]}"

# 不引用内部整数变量是可以的。
if (( $# > 3 )); then
  echo "ppid=${PPID}"
fi

# "从不引用字面整数"
value=32
# "引用命令替换"，即使你期望得到整数
number="$(generate_number)"

# "优先引用单词"，但不是强制性的
readonly USE_INTEGER='true'

# "引用 shell 元字符"
echo 'Hello stranger, and well met. Earn lots of $$$'
echo "Process $$: Done making \$\$\$."

# "命令选项或路径名"
# （假设 $1 包含一个值）
grep -li Hugo /dev/null "$1"

# 较复杂的示例
# "引用变量，除非证明不需要"：ccs 可能为空
git send-email --to "${reviewers}" ${ccs:+"--cc" "${ccs}"}

# 位置参数的预防措施：$1 可能未设置
# 单引号保持正则表达式原样。
grep -cP '([Ss]pecial|\|?characters*)$' ${1:+"$1"}

# 传递参数时，
# "$@" 几乎总是正确的选择，而
# $* 几乎总是错误的选择：
#
# * $* 和 $@ 会在空格处分割，破坏包含空格的参数并丢弃空字符串；
# * "$@" 会保持参数原样，因此没有提供参数时不会传递任何参数；
#   这在大多数情况下是你想要用于传递参数的选择。
# * "$*" 扩展为一个参数，所有参数由（通常是）空格连接，
#   因此没有提供参数时会传递一个空字符串。
#
# 请参阅
# https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html 和
# https://mywiki.wooledge.org/BashGuide/Arrays 了解更多信息

(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$*"; echo "$#, $@")
(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$@"; echo "$#, $@")
```

<a id="s6-features-and-bugs"></a>

## 功能和错误

<a id="s6.1-shellcheck"></a>

### ShellCheck

[ShellCheck 项目](https://www.shellcheck.net/) 可以识别 shell 脚本中的常见错误和警告。无论脚本大小，均建议使用。

<a id="s6.2-command-substitution"></a>

### 命令替换

使用 `$(command)` 替代反引号。

嵌套的反引号需要对内部的反引号进行转义，使用 `\ `。`$(command)` 格式在嵌套时不会改变，并且更易于阅读。

示例：

```shell
# 推荐这样做：
var="$(command "$(command1)")"
```

```shell
# 不推荐这样做：
var="`command \`command1\``"
```

<a id="s6.3-tests"></a>

<a id="tests"></a>
### 测试，`[ … ]` 和 `[[ … ]]`

优先使用 `[[ … ]]` 而不是 `[ … ]`、`test` 和 `/usr/bin/[`。

`[[ … ]]` 减少了错误，因为在 `[[` 和 `]]` 之间不会进行路径名扩展或单词分割。此外，`[[ … ]]` 允许模式和正则表达式匹配，而 `[ … ]` 则不支持。

```shell
# 这确保左侧的字符串由 alnum 字符类中的字符组成，后跟字符串 name。
# 注意，此处不应引用 RHS。
if [[ "filename" =~ ^[[:alnum:]]+name ]]; then
  echo "匹配"
fi

# 这匹配确切的模式 "f*"（在这种情况下不匹配）
if [[ "filename" == "f*" ]]; then
  echo "匹配"
fi
```

```shell
# 这会导致“参数过多”错误，因为 f* 被扩展为当前目录的内容。它还可能触发
# “意外操作符”错误，因为 `[` 不支持 `==`，只支持 `=`。
if [ "filename" == f* ]; then
  echo "匹配"
fi
```

有关详细信息，请参阅 [Bash FAQ](http://tiswww.case.edu/php/chet/bash/FAQ) 中的 E14

<a id="s6.4-testing-strings"></a>

### 测试字符串

尽可能使用引号而不是填充字符。

Bash 足够聪明，可以处理测试中的空字符串。因此，考虑到代码更易读，使用测试空/非空字符串或空字符串，而不是填充字符。

```shell
# 这样做：
if [[ "${my_var}" == "some_string" ]]; then
  do_something
fi

# -z（字符串长度为零）和 -n（字符串长度不为零）优于测试空字符串
if [[ -z "${my_var}" ]]; then
  do_something
fi
```
# 这可以（确保空侧有引号），但不是首选：
```shell
if [[ "${my_var}" == "" ]]; then
  do_something
fi
```

```shell
# 不要这样做：
if [[ "${my_var}X" == "some_stringX" ]]; then
  do_something
fi
```

为了避免对测试内容的混淆，明确使用 `-z` 或 `-n`。

```shell
# 使用这种方式
if [[ -n "${my_var}" ]]; then
  do_something
fi
```

```shell
# 而不是这种方式
if [[ "${my_var}" ]]; then
  do_something
fi
```

为了清晰起见，使用 `==` 表示相等，而不是 `=`，尽管两者都有效。前者鼓励使用 `[[`，而后者可能与赋值混淆。然而，在 `[[ … ]]` 中使用 `<` 和 `>` 时要小心，因为它们执行的是字典顺序比较。对于数值比较，请使用 `(( … ))` 或 `-lt` 和 `-gt`。

```shell
# 使用这种方式
if [[ "${my_var}" == "val" ]]; then
  do_something
fi

if (( my_var > 3 )); then
  do_something
fi

if [[ "${my_var}" -gt 3 ]]; then
  do_something
fi
```

```shell
# 而不是这种方式
if [[ "${my_var}" = "val" ]]; then
  do_something
fi

# 可能意外的字典顺序比较。
if [[ "${my_var}" > 3 ]]; then
  # 对4为真，对22为假。
  do_something
fi
```

<a id="s6.5-wildcard-expansion-of-filenames"></a>

### 文件名通配符扩展

在进行文件名通配符扩展时，请使用明确的路径。

由于文件名可能以 `-` 开头，使用 `./*` 而不是 `*` 来扩展通配符会更安全。

```shell
# 目录内容如下：
# -f  -r  somedir  somefile

# 错误地强制删除目录中几乎所有内容
psa@bilby$ rm -v *
removed directory: `somedir'
removed `somefile'
```

```shell
# 相对的：
psa@bilby$ rm -v ./*
removed `./-f'
removed `./-r'
rm: cannot remove `./somedir': Is a directory
removed `./somefile'
```

<a id="s6.6-eval"></a>

### Eval

应避免使用 `eval`。

在将 `eval` 用于变量赋值时，它会混淆输入，并且可能在不允许检查这些变量是什么的情况下设置变量。

```shell
# 这设置了什么？
# 它成功了吗？部分还是全部？
eval $(set_my_variables)

# 如果返回值中有一个包含空格会怎样？
variable="$(eval some_function)"
```

<a id="s6.7-arrays"></a>

### 数组

应使用 Bash 数组来存储元素列表，以避免引用复杂性。这特别适用于参数列表。数组不应用于促进更复杂的数据结构（参见上面的[何时使用 Shell](#when-to-use-shell)）。

数组存储字符串的有序集合，可以安全地扩展为命令或循环的各个元素。

应避免使用单个字符串来表示多个命令参数，因为这不可避免地导致作者使用 `eval` 或尝试在字符串中嵌套引号，这不会产生可靠或可读的结果，并导致不必要的复杂性。

```shell
# 数组使用括号赋值，可以使用 +=( … ) 追加。
declare -a flags
flags=(--foo --bar='baz')
flags+=(--greeting="Hello ${name}")
mybinary "${flags[@]}"
```

```shell
# 不要使用字符串来表示序列。
flags='--foo --bar=baz'
flags+=' --greeting="Hello world"'  # 这不会按预期工作。
mybinary ${flags}
```

```shell
# 命令扩展返回单个字符串，而不是数组。避免在数组赋值中使用未引用的扩展，因为如果命令输出包含特殊字符或空白，它将无法正确工作。

# 这将列表输出扩展为字符串，然后进行特殊关键字扩展，然后进行空白分割。只有在它变成单词列表后才行。ls 命令也可能根据用户的活动环境改变行为！
declare -a files=($(ls /directory))

# get_arguments 将所有内容写入 STDOUT，但随后会经历
# 在转换为参数列表之前的相同扩展过程。
mybinary $(get_arguments)

<a id="s6.7.1-arrays-pros"></a>

#### 数组的优点

*   使用数组可以处理列表，而不会混淆引号语义。反之，不使用数组会导致尝试在字符串内部嵌套引号的误导性尝试。
*   数组可以安全地存储任意字符串的序列/列表，包括包含空格的字符串。

<a id="s6.7.2-arrays-cons"></a>

#### 数组的缺点

使用数组可能会增加脚本的复杂性。

<a id="s6.7.3-arrays-decision"></a>

#### 数组的决策

应使用数组来安全地创建和传递列表。特别是在构建一组命令参数时，使用数组可以避免引号问题的混淆。使用引号扩展 – `"${array[@]}"` – 来访问数组。然而，如果需要更高级的数据操作，应完全避免使用 shell 脚本；参见[上文](#when-to-use-shell)。

<a id="s6.8-pipes-to-while"></a>

### 管道到 While

优先使用进程替换或 `readarray` 内置命令（bash4+）而不是将管道到 `while`。管道会创建一个子 shell，因此在管道内修改的任何变量都不会传播到父 shell。

管道到 `while` 的隐式子 shell 可能会引入难以追踪的细微错误。

```shell
last_line='NULL'
your_command | while read -r line; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done

# 这将始终输出 'NULL'！
echo "${last_line}"
```

使用进程替换也会创建一个子 shell。然而，它允许从子 shell 重定向到 `while`，而不将 `while`（或任何其他命令）放入子 shell。

```shell
last_line='NULL'
while read line; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done < <(your_command)

# 这将输出 your_command 的最后一行非空内容
echo "${last_line}"
```

或者，使用 `readarray` 内置命令将文件读入数组，然后循环遍历数组的内容。注意，由于与上述相同的原因，您需要对 `readarray` 使用进程替换而不是管道，但优点是循环的输入生成位于循环之前，而不是之后。

```shell
last_line='NULL'
readarray -t lines < <(your_command)
for line in "${lines[@]}"; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done
echo "${last_line}"
```

> 注意：在使用 for 循环遍历输出时要小心，如 `for var in $(...)`，因为输出是按空格分割的，而不是按行分割。有时您会知道这样做是安全的，因为输出中不会包含任何意外的空格，但在这种情况不明显或不会提高可读性时（例如 `$(...)` 内的长命令），`while read` 循环或 `readarray` 通常更安全、更清晰。

<a id="s6.9-arithmetic"></a>

### 算术运算

始终使用 `(( … ))` 或 `$(( … ))`，而不是 `let` 或 `$[ … ]` 或 `expr`。

永远不要使用 `$[ … ]` 语法、`expr` 命令或 `let` 内置命令。

在 `[[ … ]]` 表达式中，`<` 和 `>` 不执行数值比较（它们执行的是字典顺序比较；参见[测试字符串](#testing-strings)）。优先不要在数值比较中使用 `[[ … ]]`，而是使用 `(( … ))`。

建议避免将 `(( … ))` 用作独立语句，并且要注意其表达式计算结果为零的情况 - 特别是在启用了 `set -e` 时。例如，`set -e; i=0; (( i++ ))` 将导致 shell 退出。

```shell
# 简单的计算用作文本 - 注意在字符串中使用 $(( … ))
echo "$(( 2 + 2 )) 是 4"

# 执行算术比较进行测试时
if (( a < b )); then
  …
fi

# 一些计算赋值给变量。
(( i = 10 * j + 400 ))
```

```shell
# 这种形式不具备可移植性，且已被废弃
i=$[2 * 10]

# 尽管看起来像是，'let' 并不是声明性关键字之一，
# 因此未加引号的赋值会受到通配符扩展和单词分割的影响。
# 为了简单起见，避免使用 'let'，而是使用 (( … ))
let i="2 + 2"

# expr 实用程序是一个外部程序，而不是 shell 内置命令。
i=$( expr 4 + 4 )
```
# 使用 expr 时，引用也容易出错。
i=$( expr 4 '*' 4 )

抛开风格上的考虑，shell 内置的算术运算比 `expr` 快很多倍。

在使用变量时，在 `$(( … ))` 中不需要使用 `${var}`（和 `$var`）形式。shell 会自动查找 `var`，省略 `${…}` 可以使代码更简洁。这与之前关于始终使用大括号的规则略有不同，因此这只是一个建议。

```shell
# 注意：尽可能将变量声明为整数，并优先使用局部变量而不是全局变量。
local -i hundred="$(( 10 * 10 ))"
declare -i five="$(( 10 / 2 ))"

# 将变量 "i" 增加三。
# 注意：
#  - 我们不写 ${i} 或 $i。
#  - 我们在 (( 和 )) 之间加了空格。
(( i += 3 ))

# 将变量 "i" 减少五：
(( i -= 5 ))

# 进行一些复杂的计算。
# 注意，遵循正常的算术运算符优先级。
hr=2
min=5
sec=30
echo "$(( hr * 3600 + min * 60 + sec ))" # 如预期打印 7530
```

<a id="s6.10-aliases"></a>

## 别名

尽管在 `.bashrc` 文件中常见，但在脚本中应避免使用别名。正如
[Bash 手册](https://www.gnu.org/software/bash/manual/html_node/Aliases.html)
所述：

> 几乎在所有情况下，shell 函数比别名更受欢迎。

别名使用起来很麻烦，因为它们需要仔细地引用和转义其内容，而且错误可能难以察觉。

```shell
# 这会在定义别名时对 $RANDOM 求值一次，
# 因此每次调用时 echo 的字符串都相同
alias random_name="echo some_prefix_${RANDOM}"
```

函数提供了别名功能的超集，应始终优先使用。

```shell
random_name() {
  echo "some_prefix_${RANDOM}"
}

# 注意，与别名不同，函数的参数通过 $@ 访问
fancy_ls() {
  ls -lh "$@"
}
```

<a id="s7-naming-conventions"></a>

## 命名约定

<a id="s7.1-function-names"></a>

### 函数名称

使用小写字母，单词之间用下划线分隔。用 `::` 分隔库。函数名后必须跟括号。关键字 `function` 是可选的，但必须在整个项目中一致使用。

如果您编写的是单个函数，请使用小写字母并用下划线分隔单词。如果您编写的是一个包，请用 `::` 分隔包名。然而，旨在交互式使用的函数可能选择避免使用冒号，因为它可能会混淆 bash 的自动补全功能。

大括号必须与函数名在同一行（与 Google 的其他语言一致），并且函数名与括号之间没有空格。

```shell
# 单个函数
my_func() {
  …
}

# 包的一部分
mypackage::my_func() {
  …
}
```

当函数名后有 "()" 时，`function` 关键字是多余的，但它有助于快速识别函数。

<a id="s7.2-variable-names"></a>

### 变量名称

与函数名称相同。

循环变量的名称应与您正在循环的任何变量类似命名。

```shell
for zone in "${zones[@]}"; do
  something_with "${zone}"
done
```

<a id="s7.3-constants-and-environment-variable-names"></a>
<a id="s7.5-read-only-variables"></a>

### 常量、环境变量和只读变量

常量和导出到环境中的任何内容应大写，单词之间用下划线分隔，并在文件顶部声明。

```shell
# 常量
readonly PATH_TO_FILES='/some/path'

# 既是常量又导出到环境中
declare -xr ORACLE_SID='PROD'
```

为了清晰起见，建议使用 `readonly` 或 `export`，而不是等效的 `declare` 命令。您可以按顺序执行它们，如下所示：

```shell
# 常量
readonly PATH_TO_FILES='/some/path'
export PATH_TO_FILES
```

可以在运行时或条件中设置常量，但应立即将其设为只读。

```shell
ZIP_VERSION="$(dpkg --status zip | sed -n 's/^Version: //p')"
if [[ -z "${ZIP_VERSION}" ]]; then
  ZIP_VERSION="$(pacman -Q --info zip | sed -n 's/^Version *: //p')"
fi
if [[ -z "${ZIP_VERSION}" ]]; then
  handle_error_and_quit
fi
readonly ZIP_VERSION
```

<a id="s7.4-source-filenames"></a>

### 源文件名

使用小写字母，如果需要，可以用下划线分隔单词。

这与 Google 其他代码风格保持一致：`maketemplate` 或 `make_template`，但不是 `make-template`。

<a id="s7.5-use-local-variables"></a>
<a id="s7.6-use-local-variables"></a>
### 使用局部变量

使用 `local` 声明函数特定的变量。

通过在声明时使用 `local`，确保局部变量只能在函数及其子函数内可见。这样可以避免污染全局命名空间，并防止意外设置可能在函数外部具有重要意义的变量。

当赋值值由命令替换提供时，声明和赋值必须是分开的语句；因为 `local` 内置命令不会传播命令替换的退出码。

```shell
my_func2() {
  local name="$1"

  # 声明和赋值分开的行：
  local my_var
  my_var="$(my_func)"
  (( $? == 0 )) || return

  …
}
```

```shell
my_func2() {
  # 不要这样做：
  # $? 总是为零，因为它包含的是 'local' 的退出码，而不是 my_func
  local my_var="$(my_func)"
  (( $? == 0 )) || return

  …
}
```

<a id="s7.6-function-location"></a>
<a id="s7.7-function-location"></a>

### 函数位置

将所有函数放在文件中常量下方。不要在函数之间隐藏可执行代码。这样做会使代码难以跟踪，并在调试时造成不愉快的意外。

如果你有函数，请将它们全部放在文件的顶部附近。只有包含、`set` 语句和设置常量可以在声明函数之前进行。

<a id="s7.7-main"></a>
<a id="s7.8-main"></a>

### main

对于包含至少一个其他函数的长脚本，需要一个名为 `main` 的函数。

为了便于找到程序的开始位置，请将主程序放在一个名为 `main` 的函数中，作为最底部的函数。这与代码库的其余部分保持一致，并且允许你定义更多的 `local` 变量（如果主代码不是函数，则无法这样做）。文件中的最后一行非注释行应为对 `main` 的调用：

```shell
main "$@"
```

显然，对于仅有线性流程的短脚本，`main` 过于复杂，因此不是必需的。

<a id="s8-calling-commands"></a>

## 调用命令

<a id="s8.1-checking-return-values"></a>

### 检查返回值

始终检查返回值并提供信息性的返回值。

对于非管道命令，使用 `$?` 或通过 `if` 语句直接检查以保持简单。

示例：

```shell
if ! mv "${file_list[@]}" "${dest_dir}/"; then
  echo "无法将 ${file_list[*]} 移动到 ${dest_dir}" >&2
  exit 1
fi

# 或者
mv "${file_list[@]}" "${dest_dir}/"
if (( $? != 0 )); then
  echo "无法将 ${file_list[*]} 移动到 ${dest_dir}" >&2
  exit 1
fi
```

Bash 还具有 `PIPESTATUS` 变量，允许检查管道的所有部分的返回码。如果只需要检查整个管道的成功或失败，那么以下是可接受的：

```shell
tar -cf - ./* | ( cd "${dir}" && tar -xf - )
if (( PIPESTATUS[0] != 0 || PIPESTATUS[1] != 0 )); then
  echo "无法将文件打包到 ${dir}" >&2
fi
```

然而，由于 `PIPESTATUS` 会在执行任何其他命令后被覆盖，如果你需要根据管道中错误发生的位置采取不同的行动，你需要在运行命令后立即将 `PIPESTATUS` 赋值给另一个变量（不要忘记 `[` 是一个命令，会清除 `PIPESTATUS`）。

```shell
tar -cf - ./* | ( cd "${DIR}" && tar -xf - )
return_codes=( "${PIPESTATUS[@]}" )
if (( return_codes[0] != 0 )); then
  do_something
fi
if (( return_codes[1] != 0 )); then
  do_something_else
fi
```

<a id="s8.2-builtin-commands-vs-external-commands"></a>

### 内置命令与外部命令

在调用 shell 内置命令和调用单独进程之间有选择时，选择内置命令。

我们更倾向于使用内置命令，例如 `bash` 提供的 [*参数扩展*](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) 功能，因为它更高效、更健壮、更便携（特别是与 `sed` 等相比）。另见 [`=~` 操作符](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#index-_005b_005b)。

示例：

```shell
# 更倾向于这样：
addition="$(( X + Y ))"
substitution="${string/#foo/bar}"
if [[ "${string}" =~ foo:(\d+) ]]; then
  extraction="${BASH_REMATCH[1]}"
fi
```

```shell
# 而不是这样：
addition="$(expr "${X}" + "${Y}")"
substitution="$(echo "${string}" | sed -e 's/^foo/bar/')"
extraction="$(echo "${string}" | sed -e 's/foo:\([0-9]\)/\1/')"
```

<a id="s9-conclusion"></a>
## 当有疑问时：保持一致性

在整个代码库中始终如一地使用一种风格，可以让我们专注于其他（更重要）的议题。一致性还允许自动化。在许多情况下，归因于“保持一致性”的规则可以简化为“选择一种并停止为此担忧”；在这些点上允许灵活性的潜在价值被人们为此争论的成本所抵消。

然而，一致性也有其局限性。当没有明确的技术论据，也没有长期方向时，一致性是一个不错的决策依据。一般来说，不应将一致性作为理由来继续使用旧风格，而不考虑新风格的优势，或代码库随时间逐渐趋向于使用新风格的趋势。