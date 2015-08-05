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
       
          


