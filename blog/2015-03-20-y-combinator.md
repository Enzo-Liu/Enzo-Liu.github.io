---
layout: post
title: "y-combinator"
description: "magic lambda functional-programming"
category: "haskell lisp functional-programming"
tags: [lambda,fp]
---
{% include JB/setup %}

## 简介
在一个纯粹的函数式语言环境中，只有一种元素，就是一个单参函数

``` lisp
;; id function
(lambda (x) x)
```

``` haskell
-- id function in haskll
\x -> x
```

## 问题
比如需要求解一个列表的长度，该如何实现。

算法规则很简单：
> 1. 空列表长度为0
> 2. 列表长度等于 1 + 列表除了头部元素以外的部分

常规的算法实现如下:

### common lisp
``` lisp
;; in common lisp
(defun len (ls)
  (if (null ls)
      0
      (1+ (len (cdr ls)))))
```
```
CL-USER> (len '(1 2 3))
3
CL-USER> (len '())
0
```

### haskell
``` haskell
len1 :: (Num b ) => [a] -> b
len1 [] = 0
len1 (_:xs) = 1 + len1 xs
```
```
λ> len1 []
0
λ> len1 [1,2,3]
3
```

但是，如何基于纯粹的lambda表达式实现呢？

## 第一次尝试

尝试翻译之前写过的实现

``` lisp
(lambda (ls)
  (if (null ls)
      0
      (1+ (?? (cdr ls)))))
```

**怎么办**，`?` 部分无法填充。因为现在这个匿名函数木有名字

### 神来一笔
假如有一个len的实现，不就可以了么！！！！

``` lisp
(lambda (perfectLenFunc)
  (lambda (ls)
    (if (null ls)
        0
        (1+ (perfectLenFunc (cdr ls))))))
```

哇擦，要是有`perfectLenFunc`(后续简写为`plf`...),还在这里浪费时间干神马。

**咳咳**，不急

``` lisp
;; change to scheme, due to the function namespace
(define len1
    ((lambda (plf)
    (lambda (ls)
        (if (null? ls)
            0
            (1+ (plf (cdr ls))))))
    (lambda (ls)
    (if (null? ls)
        0
        (1+ (error (cdr ls)))))))
```
```
scheme@(guile-user)> (len1 '())
$3 = 0
scheme@(guile-user)> (len1 '(a))
$4 = 1
scheme@(guile-user)> (len1 '(a b))
ERROR: In procedure scm-error:
ERROR: ()
```

咦，这样就可以支持长度为0的列表和长度为1的列表咧。

整体优化一下重复代码

``` lisp
(define mk-len
  (lambda (plf)
    (lambda (ls)
        (if (null? ls)
            0
        (1+ (plf (cdr ls)))))))
(define len0 (mk-len error))
(define len1 (mk-len len0))
(define len2 (mk-len len1))
;; output
scheme@(guile-user)>
(define len0 (mk-len error))
(define len1 (mk-len len0))
(define len2 (mk-len len1))
scheme@(guile-user)> (len2 '(1 2))
$6 = 2
```

看来,功夫不负有心人，只要足够努力, 不管多长的列表，都能写出对应的函数算出来！
>  太天真了少年 （画外音）

### 神又来一笔

时间过去了一年，少年终于写出了可以计算长度 `14239823586`以内的列表的长度！

突然一个霹雳从天而降
> 你个XX，想写到死啊！！！！ (画外音again)

咦，注意 `(define len0 (mk-len error))`, `error`耶，岂不是说不管提供神马函数,都
不影响么

``` lisp
(define len2 (mk-len (mk-len (mk-len mk-len))))
;; output
scheme@(guile-user)>
(define len2 (mk-len (mk-len (mk-len mk-len))))
scheme@(guile-user)> (len2 '(1 2))
$8 = 2
```

**哇，那岂不是可以这样！！！**

``` lisp
(define real-len
  ((lambda (mk-len)
     (mk-len mk-len))
   (lambda (mk-len)
     (lambda (l)
       (if (null? l) 0
         (1+ ((mk-len mk-len) (cdr l))))))))
scheme@(guile-user)> (real-len '(1 2 3 a b d c s))
$9 = 8
```

好棒！好陶醉！好满足！！！

### 神又来一笔!

不过，写出来的程序看着好奇怪。好多`mk-len`,`（mk-len mk-len）`, **看不懂啊**.
只有

``` lisp
     (lambda (l)
       (if (null? l) 0
         (1+ (?? (cdr l))))))))
```

这个才是我想要的呢... 那就想办法把`(mklen mklen)` 搞出去，做参数传进来好了👌

``` lisp
((lambda (mk-len)
   (mk-len mk-len))
 (lambda (mk-len)
   ((lambda (len)
      (lambda (l)
        (if (null? l) 0
          (1+ (len (cdr l))))))
    (lambda (x) ((mk-len mk-len) x)))))
```

哇，中间的代码看起来，有点像那么一回事了。想办法挪挪结构，更好看一点。

``` lisp
((lambda (len')
   ((lambda (mk-len) (mk-len mk-len))
    (lambda (mk-len) (len' (lambda (x) ((mk-len mk-len) x))))))
 (lambda (len)
   (lambda (l)
     (if (null? l) 0
       (1+ (len (cdr l)))))))
```

**BINGO** !!

## the ultimate Y-Combinator

``` lisp
(define Y
  (lambda (targetFunction)
    ((lambda (f) (f f))
     (lambda (f) (targetFunction (lambda (x) ((f f) x)))))))

(define len
  ( Y (lambda (len')
        (lambda (l)
          (if (null? l) 0
            (1+ (len' (cdr l))))))))
;; output
scheme@(guile-user)> (len '(a b d c dd s sf ad f))
$10 = 9
```

**炫酷爆棚了!** 有没有

## 实践

in haskell

``` haskell
-- here is where miracle begins
newtype Rec a = In { out :: Rec a -> a } -- for type deduction

y :: (a -> a) -> a
y tf = (\f -> out f f) $In (\f -> tf (out f f))


ylen :: (Num b) => [a]->b
ylen = y (\len' ls -> if null ls then 0 else (len'.tail$ls)+1)

ysum :: (Num a) => [a] -> a
ysum = y (\sum' ls -> if null ls then 0 else head ls + (sum'.tail $ ls))
-- output
λ> ylen [1,2,3,4]
4
λ> ysum [1,2,3,4]
10
```

## external links

[y-combinator in wikipedia](http://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator)

[the litter scheme - chapter 8](http://mitpress.mit.edu/books/little-schemer)
