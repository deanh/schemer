#lang racket/base

(require "lib/shared.rkt"
         "chap-2.rkt")

(provide rember
         firsts
         insertR)

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (cdr lat))
      (else (cons (car lat) 
                  (rember a (cdr lat)))))))

(define firsts
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cons (car (car l))
                  (firsts (cdr l)))))))

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      (else 
        (cond 
          ((eq? old (car lat)) (cons old 
                                     (cons new 
                                           (cdr lat))))
          (else
            (cons (car lat) 
                  (insertR new old (cdr lat)))))))))

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      (else 
        (cond 
          ((eq? old (car lat)) (cons new 
                                     (cons old 
                                           (cdr lat))))
          (else
            (cons (car lat) 
                  (insertR new old (cdr lat)))))))))

