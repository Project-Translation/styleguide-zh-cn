;;; google-c-style.el --- Google的C/C++风格设置，用于c-mode

;; 关键词: c, 工具

;; google-c-style.el版权所有(C) 2008 Google Inc. 保留所有权利。
;;
;; 这是一个自由软件；您可以根据以下任一许可条款重新分发和/或修改它：
;;
;; a) 自由软件基金会发布的GNU通用公共许可证；版本1，或（由您选择）任何后续版本，或
;;
;; b) “艺术许可证”。

;;; 注释：

;; 提供Google C/C++编码风格。您可能希望在加载此文件后，将`google-set-c-style'添加到您的`c-mode-common-hook'中。例如：
;;
;;    (add-hook 'c-mode-common-hook 'google-set-c-style)
;;
;; 如果您希望RETURN键跳转到下一行并自动缩进到正确的位置，请在load-file之后将以下内容添加到您的.emacs文件中：
;;
;;    (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;; 代码：

;; 由于某些原因1) c-backward-syntactic-ws是一个宏，2) 在Emacs 22下，字节码在运行时无法调用（未展开的）宏：
(eval-when-compile (require 'cc-defs))

;; 需要一个包装函数来适配Emacs 21和XEmacs（Emacs 22提供了更优雅的解决方案，即通过运算符如“add”来组合一系列对齐函数或量）
(defun google-c-lineup-expression-plus-4 (langelem)
  "将缩进设置到当前C表达式开头再加4个空格。

这实现了Google C++风格指南中标题为“函数声明和定义”的部分，
适用于前一行以左括号结尾的情况。

根据Google风格指南以及后续讨论的澄清，“当前C表达式”指的是整个表达式，
不论嵌套括号的数量，但不包括非表达式材料，如“if(”和“for(”控制结构。

适合包含在`c-offsets-alist'中。"
  (save-excursion
    (back-to-indentation)
    ;; 移动到*前一*行的开头：
    (c-backward-syntactic-ws)
    (back-to-indentation)
    (cond
     ;; 我们合理假设，如果有需要缩进过去的控制结构，它必须位于行的开头。
     ((looking-at "\\(\\(if\\|for\\|while\\)\\s *(\\)")
      (goto-char (match-end 1)))
     ;; 对于构造函数初始化列表，排列的参考点是初始冒号后的标记。
     ((looking-at ":\\s *")
      (goto-char (match-end 0))))
    (vector (+ 4 (current-column)))))
```elisp
;;;###autoload
(defconst google-c-style
  `((c-recognize-knr-p . nil)
    (c-enable-xemacs-performance-kludge-p . t) ; 在 XEmacs 中加速缩进
    (c-basic-offset . 2)
    (indent-tabs-mode . nil)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (inexpr-class-open after)
                               (inexpr-class-close before)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . t)
    (comment-column . 40)
    (c-indent-comment-alist . ((other . (space . 2))))
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . ((arglist-intro google-c-lineup-expression-plus-4)
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case 无 {
                        (access-label . /)
                        (innamespace . 0))))
  "Google C/C++ 编程风格。")

;;;###autoload
(defun google-set-c-style ()
  "将当前缓冲区的 c-style 设置为 Google C/C++ 编程风格。旨在添加到 `c-mode-common-hook' 中。"
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-add-style "Google" google-c-style t))

;;;###autoload
(defun google-make-newline-indent ()
  "设置首选的换行行为。默认未设置。旨在添加到 `c-mode-common-hook' 中。"
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret] 'newline-and-indent))

(provide 'google-c-style)
;;; google-c-style.el 结束于此
```