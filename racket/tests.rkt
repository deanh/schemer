#lang racket/base

(require rackunit
         "lib/shared.rkt"
         "chap-2.rkt"
         "chap-3.rkt"
         "chap-4.rkt"
         "chap-5.rkt"
         "chap-6.rkt")

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

;; rember-star
(check-equal? (rember-star 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
              '((coffee) ((tea)) (and (hick))))

(check-equal? (rember-star 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
              '(((tomato)) ((bean)) (and ((flying)))))

;; insertR-star
(check-equal? (insertR-star 'roast 'chuck '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
              '((how much (wood)) could ((a (wood) chuck roast)) (((chuck roast))) (if (a) ((wood chuck roast))) could chuck roast wood))

;; occur-star
(check-equal? (occur-star 'banana '((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy)))
              5)

;; subst-star
(check-equal? (subst-star 'orange 'banana '((banana) (split ((((banana ice))) (cream (banana)) sherbert)) (banana) (bread) (banana brandy)))
              '((orange) (split ((((orange ice))) (cream (orange)) sherbert)) (orange) (bread) (orange brandy)))

;; insertL-star
(check-equal? (insertL-star 'pecker 'chuck '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
              '((how much (wood)) could ((a (wood) pecker chuck)) (((pecker chuck))) (if (a) ((wood pecker chuck))) could pecker chuck wood))

;; member-star
(check-equal? (member-star 'chips '((potato) (chips ((with) fish) (chips))))
              #t)

;; leftmost
(check-equal? (leftmost '((potato) (chips ((with) fish) (chips))))
              'potato)
(check-equal? (leftmost '(((hot) (tuna (and))) cheese))
              'hot)

;; eqlist?
(check-equal? (eqlist? '(strawberry ice cream) '(strawberry ice cream))
              #t)

(check-equal? (eqlist? '(strawberry ice cream) '(strawberry cream ice))
              #f)

(check-equal? (eqlist? '((banana) split) '(banana (split)))
              #f)

(check-equal? (eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))
              #f)

(check-equal? (eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))
              #t)

;; infix-value
(check-equal? (infix-value '(1 + 1))
              2)

(check-equal? (infix-value '(1 x 2))
              2)

(check-equal? (infix-value '(2 ^ 3))
              8)

(check-equal? (infix-value '((1 + 2) x 4))
              12)

(check-equal? (infix-value '(1 + (3 x 4)))
             13)

;; prefix-value
(check-equal? (prefix-value '(+ 1 1))
             2)

(check-equal? (prefix-value '(x 1 2))
              2)

(check-equal? (prefix-value '(^ 2 3))
              8)

(check-equal? (prefix-value '(x (+ 1 2) 4))
              12)

(check-equal? (prefix-value '(+ 1 (x 3 4)))
              13)

;; value
(check-equal? (value '(+ 1 1))
             2)

(check-equal? (value '(x 1 2))
              2)

(check-equal? (value '(^ 2 3))
              8)

(check-equal? (value '(x (+ 1 2) 4))
              12)

(check-equal? (value '(+ 1 (x 3 4)))
              13)