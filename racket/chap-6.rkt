#lang racket/base

(require "lib/shared.rkt"
         "chap-2.rkt"
         "chap-4.rkt")

(provide numbered?
         infix-value
         prefix-value
         value)

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))))))

(define infix-value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+)
       (add 
        (infix-value (car nexp))
        (infix-value (car (cdr (cdr nexp))))))
      ((eq? (car (cdr nexp)) 'x)
       (mult 
        (infix-value (car nexp))
        (infix-value (car (cdr (cdr nexp))))))
      ((eq? (car (cdr nexp)) '^)
       (pow 
        (infix-value (car nexp))
        (infix-value (car (cdr (cdr nexp)))))))))

(define prefix-value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car nexp) '+)
       (add
        (prefix-value (car (cdr nexp)))
        (prefix-value (car (cdr (cdr nexp))))))
      ((eq? (car nexp) 'x)
       (mult
        (prefix-value (car (cdr nexp)))
        (prefix-value (car (cdr (cdr nexp))))))
      ((eq? (car nexp) '^)
       (pow
        (prefix-value (car (cdr nexp)))
        (prefix-value (car (cdr (cdr nexp)))))))))
     
(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))

(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))

(define operator
  (lambda (aexp)
    (car aexp)))

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
       (add 
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp nexp))))
      ((eq? (operator nexp) 'x)
       (mult 
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp nexp))))
      ((eq? (operator nexp) '^)
       (pow 
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp nexp)))))))

(define sero?
  (lambda (n)
    (eq? n '())))

(define edd1
  (lambda (n)
    (cons '() n)))

(define zub1
  (lambda (n)
    (cdr n)))

(define edd
  (lambda (n m)
    (cond
      ((sero? n) m)
      (else
       (edd1 (edd m (zub1 n)))))))