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

;; insertL
(check-equal? (insertL 'topping 'fudge '(ice cream with fudge for dessert)) 
              '(ice cream with topping fudge for dessert))
(check-equal? (insertL 'jalapeño 'and '(tacos tamales and salsa))
              '(tacos tamales jalapeño and salsa))
(check-equal? (insertL 'e 'd '(a b c d f g d h))
              '(a b c e d f g d h))

;; subst
(check-equal? (subst 'topping 'fudge '(ice cream with fudge for dessert)) 
              '(ice cream with topping for dessert))
(check-equal? (subst 'jalapeño 'and '(tacos tamales and salsa))
              '(tacos tamales jalapeño salsa))
(check-equal? (subst 'e 'd '(a b c d f g d h))
              '(a b c e f g d h))

;; subst2
(check-equal? (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
              '(vanilla ice cream with chocolate topping))

;; multirember
(check-equal? (multirember 'cup '(coffee cup tea cup and hick cup))
              '(coffee tea and hick))

;; multiinsertR
(check-equal? (multiinsertR 'fried 'fish '(chips and fish or fish and fried))
              '(chips and fish fried or fish fried and fried))

;; multiinsertL
(check-equal? (multiinsertL 'fried 'fish '(chips and fish or fish and fried))
              '(chips and fried fish or fried fish and fried))

;; multisubst
(check-equal? (multisubst 'fried 'fish '(chips and fish or fish and fried))
              '(chips and fried or fried and fried))
