#求值模型

## 代换模型


## 环境模型

## lambda

(define cons (x y)
  (lambda (m) (m x y)))

(define car (x)
  (x (lambda(a b) a)))

(define cdr (x)
  (x (lambda(a b) b)))

### js equivalent
function cons(x,y){
    return function(method) {
          return method(x,y)
            }
}

function car(c){
    return c(function(x,y){return x})
}

function cdr(c){
    return c(function(x,y){return y})
}

## 元语言循环


abstraction, abstraction, abstraction” are the three most important things in programming

一名程序员最大的价值， 不在于他对某些编程语言和工具的熟练运用，而在于拥有一个 冷静而清晰、 严谨而灵活、抽象而深刻的头脑.
