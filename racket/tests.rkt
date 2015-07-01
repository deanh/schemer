#lang racket/base

(require rackunit
         "lib/shared.rkt"
         "chap-2.rkt"
         "chap-3.rkt")

;; Chapter 1

;; Chapter 2
(check-true (lat? '(Jack Sprat could eat no chicken fat)))
(check-false (lat? '((Jack) Sprat could eat no chicken fat)))
(check-false (lat? '(Jack (Sprat could) eat no chicken fat)))
(check-true (lat? '()))

(check-true (member? 'tea '(coffee tea or milk)))
(check-false (member? 'poached '(fried eggs and scrambled eggs)))
(check-false (member? 'liver '(bagels and lox)))

;; Chapter 3
;; rember
(check-equal? (rember 'bacon '(bacon lettuce and tomato)) '(lettuce and tomato))
(check-equal? (rember 'and '(bacon lettuce and tomato)) '(bacon lettuce tomato))
(check-equal? (rember 'sauce '(soy sauce and tomato sauce)) '(soy and tomato sauce))

;; firsts
(check-equal? (firsts '((apple peach pumpkin)
                        (plum pear cherry)
                        (grape raisin pea)
                        (bean carrot eggplant))) '(apple plum grape bean))
(check-equal? (firsts '((a b) (c d) (e f))) '(a c e))
(check-equal? (firsts '()) '())
(check-equal? (firsts '((five plums)
                        (four)
                        (eleven green oranges))) '(five four eleven))
(check-equal? (firsts '(((five plums) four)
                        (eleven green oranges)
                        ((no) more))) '((five plums) eleven (no)))

;; insertR
(check-equal? (insertR 'topping 'fudge '(ice cream with fudge for dessert)) 
              '(ice cream with fudge topping for dessert))
(check-equal? (insertR 'jalapeño 'and '(tacos tamales and salsa))
              '(tacos tamales and jalapeño salsa))
(check-equal? (insertR 'e 'd '(a b c d f g d h))
              '(a b c d e f g d h))


