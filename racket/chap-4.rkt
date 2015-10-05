#lang racket/base

(require "lib/shared.rkt")

(define add1
  (lambda (n)
    (+ n 1)))

(define sub1
  (lambda (n)
    (- n 1)))

(define add
  (lambda (m n)
    (cond
     ((zero? n) m)
     (else (add1 (add m (sub1 n)))))))

(define sub
  (lambda (m n)
    (cond
      ((zero? n) m)
      (else (sub1 (sub m (sub1 n)))))))

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else
       (add (car tup) (addtup (cdr tup)))))))

(define mult
  (lambda (m n)
    (cond 
      ((zero? n) 0)
      (else
       (add m (mult m (sub1 n)))))))

(define tupadd
  (lambda (t1 t2)
    (cond
      ((null? t1) t2) 
      ((null? t2) t1)
      (else
       (cons (add (car t1) (car t2))
             (tupadd (cdr t1) (cdr t2)))))))

(define lessthan
  (lambda (m n)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else
       (lessthan (sub1 m) (sub1 n))))))

(define greaterthan
  (lambda (m n)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else
       (greaterthan (sub1 m) (sub1 n))))))

(define equal
  (lambda (m n)
    (not
     (or (greaterthan m n) (lessthan m n)))))

(define pow
  (lambda (m n)
    (cond
      ((zero? n) 1)
      (else
        (mult m (pow m (sub1 n)))))))

(define div
  (lambda (m n)
    (cond
      ((lessthan m n) 0)
      (else
       (add1 (div m (sub m n)))))))

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else
       (add1 (length (cdr lat)))))))

(define pick
  (lambda (n lat)
    (cond
      ((null? lat) #f)
      ((zero? (sub1 n)) (car lat))
      (else
       (pick (sub1 n) (cdr lat))))))

(define rempick
  (lambda (n lat)
    (cond
      ((null? lat) #f)
      ((zero? (sub1 n)) (cdr lat))
      (else
       (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat)) (no-nums (cdr lat)))
      (else
       (cons (car lat) (no-nums (cdr lat)))))))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else
       (all-nums (cdr lat))))))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2))
       (= a1 a2))
      ((or (number? a1) (number? a2))
       #f)
      (else
       (eq? a1 a2)))))

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      (else
       (cond
         ((eqan? a (car lat)) (add1 (occur a (cdr lat))))
         (else
          (occur a (cdr lat))))))))

(define one?
  (lambda (n)
    (eqan? 1 n)))

(define rempick2
  (lambda (n lat)
    (cond
      ((null? lat) #f)
      ((zero? (sub1 n)) (cdr lat))
      (else
       (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
       
          


