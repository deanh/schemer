#lang racket/base

(require "lib/shared.rkt"
         "chap-2.rkt"
         "chap-4.rkt")

(provide rember-star
         insertR-star
         occur-star
         subst-star
         insertL-star
         member-star
         leftmost
         eqlist?)

(define rember-star
  (lambda (a l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? a (car l))
          (rember-star a (cdr l)))
         (else
          (cons (car l) (rember-star a (cdr l))))))
      (else
       (cons (rember-star a (car l))
             (rember-star a (cdr l)))))))

(define insertR-star
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons old (cons new (insertR-star new old (cdr l)))))
         (else
          (cons (car l) (insertR-star new old (cdr l))))))
      (else
       (cons (insertR-star new old (car l))
             (insertR-star new old (cdr l)))))))

(define occur-star
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
         ((eq? a (car l))
          (add1 (occur-star a (cdr l))))
         (else
          (occur-star a (cdr l)))))
      (else
       (+ (occur-star a (car l)) (occur-star a (cdr l)))))))

(define subst-star
  (lambda (new old l)
    (cond
      ((null? l)'())
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons new (subst-star new old (cdr l))))
         (else
          (cons (car l) (subst-star new old (cdr l))))))
       (else
        (cons (subst-star new old (car l))
              (subst-star new old (cdr l)))))))

(define insertL-star
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons new (cons old (insertL-star new old (cdr l)))))
         (else
          (cons (car l) (insertL-star new old (cdr l))))))
      (else
       (cons (insertL-star new old (car l))
             (insertL-star new old (cdr l)))))))

(define member-star
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (cond
         ((eq? a (car l)) #t)
         (else
          (member-star a (cdr l)))))
      (else
       (or (member-star a (car l))
           (member-star a (cdr l)))))))

(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else
       (leftmost (car l))))))
          
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else
       (eqlist? s1 s2)))))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (eq? l1 '()) (eq? l2 '())) #t)
      ((or (eq? l1 '()) (eq? l2 '())) #f)
      (else
       (and (equal? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2)))))))
  
