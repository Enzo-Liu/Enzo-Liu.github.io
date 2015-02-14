---
layout: post
title: "fall in love with haskell"
description: ""
category: "haskell"
tags: [programming, haskell]
---
{% include JB/setup %}

## 简介

最近有些爱上了haskell，在体验这个纯粹的函数式语言中，确实发现了一些不一样的`美感`。

话拙，直接看代码。

## 示例
一句话，表现力上，的确很强。
### 快排
``` haskell
qs :: (Ord a) => [a] -> [a]
qs [] = []
qs (x:xs) = qs [gt | gt <- xs, gt>=x] ++ [x] ++ qs [lt | lt <-xs , lt<x]
```
> 快排就是将哨兵两边的数据都排好序后再拼接起来。

### 斐波那契数列
这个是最最 **`惊艳`** 到我的！！！

``` haskell
fibs :: [Int]
fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]
```

> 翻译成中文就是，f(n) = f(n-1) + f(n-2), f(0) = 0 , f(1) = 1. 哈哈

看过SICP的兄弟可能会知道，里面讲过一个延时计算的无限的流，递归的定义数据结构本身.
用commonLisp实现的话，首先要定义一个延时的流。然后基于其上可以来定义斐波的流。大
概如下，可以对比一下haskell的实现。

(当然，这样的算法本质都是一样，只是表现形式上有些微的差异, 不过，haskell的，看上去，有一种奇特的帅~）

``` lisp
(defparameter *fib*
  (cons-stream 0
               (cons-stream 1
                            (add-streams (cdr-stream *fib*)
                                         *fib*))))
```

## 实践
上面的都有些偏理论，那看看稍微偏使用中的代码是什么样的。

### project euler
[参考地址](http://projecteuler.net/problems)

话不多说，直接看代码

> 学习`haskell`两天, 可能代码不是很符合专家的美感 :)

#### [euler 206](https://projecteuler.net/problem=206)

``` haskell
import Data.Char (intToDigit)

alternates (x:y:zs) = x : alternates zs
alternates (x:_)    = [x]
alternates _        = []

target = (map intToDigit [1..9]) ++ "0"

passes i = (alternates . show $ i^2) == target

solution = head . filter passes $ [1010101010, 1010101020 ..]
```

#### [euler 55](https://projecteuler.net/problem=55)

``` haskell
import Data.Char
palindromicNumber :: Integer -> Bool
palindromicNumber a = a == reverseNumber a

digits :: Integer -> [Int]
digits = map (read . (:[])) . show

reverseNumber :: Integer -> Integer
reverseNumber a = read (map intToDigit $ reverse . digits $ a) :: Integer

next :: Integer -> Integer
next a = a + (reverseNumber a)

isLychrel :: Integer -> Int -> Int
isLychrel number times
  | times >= 50 = times + 1
  | palindromicNumber $ next number = times + 1
  | otherwise = isLychrel (next number) $ times + 1

lychrel :: Integer -> Maybe Int
lychrel a =
  if times > 50 then Nothing else Just times
  where times = isLychrel a 0

main :: IO()
main = print $ length $ filter (== Nothing) $ map lychrel [1..10000]
```

#### [euler 56](https://projecteuler.net/problem=56)

``` haskell
digits :: Integer -> [Int]
digits = map (read . (:[])) . show

powerSum :: (Integer ,Integer) -> Int
powerSum (x,y) = sum $ digits (x^y)

main :: IO()
main = print $ maximum $ map powerSum [(x,y) | x <- [1..100], y <-[1..100]]
```

从后面的论坛里看到一个更帅的 :)

``` haskell
import Data.Char ( digitToInt )

main = print $ maximum [sum $ map digitToInt $ show $ a^b | a <- [1..99], b <- [1..99]]
```

#### [euler 57](https://projecteuler.net/problem=56)
``` haskell
pairs :: [(Integer,Integer)]
pairs = pairsFrom (1,1)

pairsFrom :: (Integer,Integer) -> [(Integer,Integer)]
pairsFrom (a,b) = (a,b):pairsFrom (a+2*b , a+b)

--In love with haskell, 这个和上面的pairs定义的效果是一样的
pairs' :: [(Integer,Integer)]
pairs' = (1,1):(map (\(x,y) -> (x+2*y,x+y)) pairs')

digits :: Integer -> [Int]
digits = map (read . (:[])) . show

numberLen :: Integer -> Int
numberLen = length . digits

longer :: (Integer,Integer) -> Bool
longer (x,y) =  numberLen x > numberLen y

main ::IO()
main = print $ (length . filter longer . take 1000) pairs
```

## 总结
尝试了使用，情难自禁，强力推荐。有机会体验一下，应该会不虚此行。
