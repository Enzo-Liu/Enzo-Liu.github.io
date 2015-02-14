# 如何解题
## 知识
## 推理 (策略)
## 信息
## HOW TO SOLVE IT

# 如何编程
## 代码逻辑(策略？)
## 数据


# want to get recursion in lambda
    F(f) = f

    lambda  n. n * <self>(n-1)
    if g is good expt
    the F(g) = n * g(n-1) is also a good one
    so F(g) = g
    if we can calculate F's fix point
    the we can get g.

think a contructor like this:
    Y = lambda f. lambda x. f (x x)
                  lambda x. f (x x)

    Y(F) = F (x x) F(x x) = F (F(x x) F(x x)) = F(F(F(x x) F(x x)))
    = F(Y(F))
    so Y(F) is F's Fix point
    then Y(F) is expt for F(g) = n * g(n-1)

    P(P n) = n * P(p, n-1)
    lambda   n. lambda   p. p p n
              lambda   p n.

    (defvar factorial
      (lambda   (n)
        ((lambda   (fact)
           (funcall fact fact n))
         (lambda   (ft k)
           (if (= k 1)
               1
               (* k (funcall ft ft (- k 1))))))))

    (funcall factorial 3)
