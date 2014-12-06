---
layout: post
title: "（common）lisp 简介"
description: "lisp programming"
category: "lisp"
tags: [lisp]
---
{% include JB/setup %}

<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Lisp</a>
<ul>
<li><a href="#sec-1-1">1.1. S表达式(symbolic expression)</a></li>
<li><a href="#sec-1-2">1.2. 表</a></li>
<li><a href="#sec-1-3">1.3. lambda 表达式</a></li>
<li><a href="#sec-1-4">1.4. 符号</a></li>
<li><a href="#sec-1-5">1.5. 过程抽象(函数式编程)</a>
<ul>
<li><a href="#sec-1-5-1">1.5.1. 函数作为参数</a></li>
<li><a href="#sec-1-5-2">1.5.2. 函数作为返回值</a></li>
<li><a href="#sec-1-5-3">1.5.3. currying (多元函数规约到一元函数)</a></li>
<li><a href="#sec-1-5-4">1.5.4. 闭包,词法作用域,动态作用域</a></li>
</ul>
</li>
<li><a href="#sec-1-6">1.6. 数据抽象</a>
<ul>
<li><a href="#sec-1-6-1">1.6.1. 函数表达</a></li>
</ul>
</li>
<li><a href="#sec-1-7">1.7. 特殊形式</a></li>
<li><a href="#sec-1-8">1.8. 宏</a>
<ul>
<li><a href="#sec-1-8-1">1.8.1. 特殊之处</a></li>
<li><a href="#sec-1-8-2">1.8.2. 示例</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

# Lisp<a id="sec-1" name="sec-1"></a>

Lisp，最初被拼为LISP，一个历史悠久的电脑编程语言家族，以波兰表示法编写。最早由约翰·麦卡锡在1958年基于λ演算创造，是历史第二悠久的高级语言，仅次于Fortran。也是第一个函数式编程语言。
-wiki

为了研究可计算性问题，阿隆左·丘奇提出了一个被称为 lambda 演算的形式系统。这个系统本质上是一种虚拟的机器的编程语言，他的基础是一些以函数为参数和返回值的函数。函数用希腊字母 lambda 标识，这个形式系统因此得名.
1958年，基于lambda演算，约翰·麦卡锡在麻省理工学院发明了Lisp这个编程语言.约翰·麦卡锡的学生史帝芬·罗素在阅读完此论文后，认为Lisp编程语言当中的eval函数可以用机器码来实做。他在IBM 704机器上，写出了第一个LISP解释器。1962年，提姆·哈特（Tim Hart）与麦克·莱文（Mike Levin）在麻省理工学院，以Lisp语言，实做出第一个完整的lisp编译器。

"Hello world"

'(Hello World)

(format t "hello world")

## S表达式(symbolic expression)<a id="sec-1-1" name="sec-1-1"></a>

s-expression   sexp
定义参考链接[<http://en.wikipedia.org/wiki/S-expression>]

一种嵌套表（树状结构）数据的表示标记
S 表达式遵循下述规则（语法）。首先，单元是用点对（Dotted pair）来描述的。例如，car 和 cdr 都为数值 1 的单元，要写成下面这样。

(1 . 1)

其次，cdr 部分如果是一个表，则省略点和括号，也就是说：

(1 . (2 . 3))

应该写成：

(1 2 . 3)

然后，如果 cdr 部分为 nil，则省略 cdr 部分。于是：

(1 2 3 . nil)

应该写成：

(1 2 3)

通过使用前缀表达式，lisp的程序也是使用sexp来进行标记。

    <func name="say">
        <print content="hello world"/>
    </func>

    (defun say () (print "hello world"))

## 表<a id="sec-1-2" name="sec-1-2"></a>

原子就是不包含空格的符号，可以是字符，也可以是数字。
表就是用小括号包含起来的原子或者表,也就是说表可以嵌套

表实际上是一个树（二叉树）。而在S表达式中， 二叉树表示为 (Left . Right) 。

如果左支是一个表，则就会成为如下形式。

((List) . Right)

如果右支是一个表，当然也可以表示为 (Left . (List)) ，但是此时我们一般把点省略掉，写成

(Left List)

()  nil  空表

(A . ())  (A) 同时，这也是一个有序对 (cons 'A nil)

(A B) 两个元素的表 (cons 'a (cons 'b nil))

(A B (A)) 嵌套表

'( a b c (d)) &#x2013;可以认为引号代表不求值,或者是获取表达式本身的值

(setf a (cons 'a 'b))

(car a) (cdr a)

(equal a (cons (car a)(cdr a) )) ==>  T

程序与数据的间隔非常小，比如

'(+ 2 2)

(eval '(+ 2 2))  ==> (+ 2 2)  ==> 4

## lambda 表达式<a id="sec-1-3" name="sec-1-3"></a>

匿名函数
简单示例:

lambda x. x+2

(lambda x. x+2) 3 => 3+2

(lamdba x. x+2) lamdba y. y+2  => (lambda y. y+2)+2  => lambda y. (y+2)+2

## 符号<a id="sec-1-4" name="sec-1-4"></a>

参考链接:[<http://acl.readthedocs.org/en/latest/zhCN/ch8-cn.html>]

符号是变量的名字，符号本身以对象存在。但Lisp符号的可能性，要比在多数语言仅允许作为变量名来得广泛许多。实际上，符号可以用任何字符串当作名字。可以通过调用 symbol-name 来获得符号的名字：

(= 3 3)

(setf = 3)

(= = 3)  ==> t

(symbol-function '=)

(symbol-value '=)

函数，宏等均是一个命名空间中的变量名。1-lisp 中，与变量共用一个命名空间。2-lisp中，与变量独立在不同的命名空间.(Common lisp是2类，scheme是1类)

当符号是特别变量（special variable）的名字时，变量的值存在符号的 value 栏位。 symbol-value 函数引用到那个栏位，所以在符号与特殊变量的值之间，有直接的连接关系。

而对于词法变量（lexical variables）来说，事情就完全不一样了。一个作为词法变量的符号只不过是个占位符（placeholder）。编译器会将其转为一个寄存器（register）或内存位置的引用位址。在最后编译出来的代码中，我们无法追踪这个符号。因此符号与词法变量的值之间是没有连接的；只要一有值，符号就消失了。

(let ((x 3)) (defun getSymbol () (print x)(symbol-value 'x))) ==> 3 ; Evaluation aborted on #<UNBOUND-VARIABLE X {1005BDC8C3}>.

## 过程抽象(函数式编程)<a id="sec-1-5" name="sec-1-5"></a>

作为一种抽象手段(黑盒)，将这一过程的使用方式/目的与该过程究竟如何通过更基本的过程实现的具体细节相分离。

### 函数作为参数<a id="sec-1-5-1" name="sec-1-5-1"></a>

与其将通用的和专用的混在一起,不如定义一个通用的然后把专用的部分作为参数。

实用工具。

比如遍历所有元素进行操作。
比如获取部分元素。
比如排序。

示例:

(mapcan #'print '(1 2 3 4))

(remove-if-not #'evenp '(1 2 3 4))

(remove-if-not #'(lambda (x) (= x 2))  '(1 2 3 4))

(sort '(1 2 3 0) #'<)

(sort '(1 2 3 0) #'>)

### 函数作为返回值<a id="sec-1-5-2" name="sec-1-5-2"></a>

如何更方便的生产函数。

例：

(remove-if #'evenp '(1 2 3 4))

(remove-if-not #'evenp '(1 2 3 4))

(defun remove-if-not<sub>2</sub> (fn ls) (remove-if (complement fn) ls))

complement需要一个 谓词 作为参数,它返回一个函数,这个函数的返回值总是和谓词得到的返回值相反

记忆化函数:

    (defun memoize (fn)
        (let ((cache (make-hash-table :test #'equal)))
          #'(lambda (&rest args)
              (multiple-value-bind (val win) (gethash args cache)
                (if win
                    val
                    (setf (gethash args cache)
                          (apply fn args)))))))
    (defun fib (n)
      (if (<= n 1)
          1
          (+ (fib (- n 1))
             (fib (- n 2)))))

    (setf (symbol-function 'fib) (memoize #'fib))

### currying (多元函数规约到一元函数)<a id="sec-1-5-3" name="sec-1-5-3"></a>

lambda 演算是基于一元函数进行推演。而curry就是一个将多元函数规约到一元函数的定义。从而保证lambda演算对于任何函数都成立.

    (defun curry (fn &rest args)
      #'(lambda (&rest args2)
          (apply fn (append args args2))))
    (curry #'+ 3)

    var foo = function(a) {
        return function(b) {
            return a * a + b * b;
        }
    }

### 闭包,词法作用域,动态作用域<a id="sec-1-5-4" name="sec-1-5-4"></a>

参考链接：[<http://acl.readthedocs.org/en/latest/zhCN/ch6-cn.html#closures>]

当函数引用到外部定义的变量时，这外部定义的变量称为自由变量（free variable）。函数引用到自由的词法变量时，称之为闭包（closure）。只要函数还存在，变量就必须一起存在。
闭包结合了函数与环境（environment）；无论何时，当一个函数引用到周围词法环境的某个东西时，闭包就被隐式地创建出来了。

闭包示例：
见上文。

动态作用域示例:

    (defparameter *x* 100)
    (let ((*x* 10))
      (defun foo ()
        (declare (special *x*))
        *x*))
    (foo)
    (let ((*x* 20)) (foo))

动态作用域什么时候会派上用场呢？通常用来暂时给某个全局变量赋新值。举例来说，有 11 个变量来控制对象印出的方式，包括了 **print-base** ，缺省是 10 。如果你想要用 16 进制显示数字，你可以重新绑定 **print-base**

(let ((**print-base** 16)) (princ 32))

## 数据抽象<a id="sec-1-6" name="sec-1-6"></a>

### 函数表达<a id="sec-1-6-1" name="sec-1-6-1"></a>

通常说来,数据结构被用来描述事物。可以用数组描述坐标,用树结构表示命令的层次结构,而用图来表示铁路网。在Lisp里,我们常会使用闭包作为表现形式。在闭包里,变量绑定可以保存信息,也能扮演在复杂数据结构中指针的角色。如果让一组闭包之间共享绑定,或者让它们之间能相互引用,那么我们就可以创建混合型的对象类型。

这就是函数语言里一个非常重要的观点：Data as Procedure。在函数语言中，可以构造一种非常类似于对象的高阶函数：

    (defun rat (x y)
       (lambda (m) (cond ((= m 0) x)
                         ((= m 1) y)
                         (t "Not Support"))))
    (setf (symbol-function 'rat-instance) (rat 2 3))

## 特殊形式<a id="sec-1-7" name="sec-1-7"></a>

Lisp 程序是由形式（Form）排列起来构成的。形式就是 S 表达式，它通过下面的规则来进行求值。

符号（Symbol）会被解释为变量，求出该变量所绑定的值。

除符号以外的原子，则求出其自身的值。即：整数的话就是该整数本身，字符串的话就是该字符串本身。

如果形式为表，则头一个符号为“函数名”，表中剩余的元素为参数。

Lisp 中用于赋值的 setq 特殊形式，写法如下：

(setq a 128)

setq 并不会对 a 进行求值，而是将其作为变量名来对待，这是 Lisp 语言中直接设定好的规则，像这样拥有特殊待遇的形式就被称为特殊形式。除了 setq 以外，特殊形式还有用于条件分支的 if 和用于定义局部变量的 let。

## 宏<a id="sec-1-8" name="sec-1-8"></a>

(defun test () '(+ 1 2))

(eval (test))

(defmacro test () '(+ 1 2))

(test)

宏和函数最本质的区别是：宏求值返回的是一个表，然后将表作为程序执行。而函数求值之后就结束了。

宏定义在本质上,是能生成lisp代码的函数,换句话说，一个能写程序的程序。

求值规则：

1.  按照定义的要求构造表达式,接着
2.  在调用宏的地方求值该表达式。

Lisp的代码的表示形式，S表达式本身就是Lisp可以方便操作的数据形式。

### 特殊之处<a id="sec-1-8-1" name="sec-1-8-1"></a>

1.  宏可以控制或阻止对其参数的求值

2.  并且它可以展开进入到主调方的上下文中。

### 示例<a id="sec-1-8-2" name="sec-1-8-2"></a>

        (macroexpand-1 '(cond ((= x 2) (/ x 0)) (t 1)))

        (defun inc (var)
           (setq var ( 1+ var)))

        (defmacro inc (var)
           (list 'setq var (list '1+ var)))
    (defmethod)

        (defmacro _f (op place &rest args)
          (multiple-value-bind (vars forms var set access)
                               (get-setf-expansion place)
            `(let* (,@(mapcar #'list vars forms)
                    (,(car var) (,op ,access ,@args)))
               ,set)))

        (_f memoize (symbol-function 'fib))