#lang racket/base

(require "lib/shared.rkt"
         "chap-2.rkt")

(provide set?
         makeset)

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((member? (car lat) (cdr lat))
       (makeset (cdr lat)))
      (else
       (cons (car lat) 
              (makeset (cdr lat)))))))
