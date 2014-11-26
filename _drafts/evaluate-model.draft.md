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
