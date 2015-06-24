#lang racket/base

(require rackunit
         "lib/shared.rkt"
         "chap-2.rkt")

;; Chapter 1


;; Chapter 2
(check-true (lat? '(Jack Sprat could eat no chicken fat)))
(check-false (lat? '((Jack) Sprat could eat no chicken fat)))
(check-false (lat? '(Jack (Sprat could) eat no chicken fat)))
(check-true (lat? '()))

(check-true (member? 'tea '(coffee tea or milk)))
(check-false (member? 'poached '(fried eggs and scrambled eggs)))
(check-false (member? 'liver '(bagels and lox)))