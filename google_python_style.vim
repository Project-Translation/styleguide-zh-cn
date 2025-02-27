版权所有 2019 Google LLC

根据Apache许可证2.0版（以下简称“许可证”）获得许可；
除非遵守许可证，否则您不得使用此文件。
您可以在以下位置获取许可证的副本：

   https://www.apache.org/licenses/LICENSE-2.0

除非适用法律要求或书面同意，根据许可证分发的软件
均按“原样”分发，不附带任何明示或暗示的担保或条件。
请参阅许可证，了解许可证下规定的权限和限制的具体语言。

按照Google的方式缩进Python。

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " 向后查找的最大行数。

function GetGooglePythonIndent(lnum)

  " 在括号内缩进。
  " 除非括号位于行尾，否则与打开的括号对齐。
  " 例如
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " 将其余部分委托给原始函数。
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"