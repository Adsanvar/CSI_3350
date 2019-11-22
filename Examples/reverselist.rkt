#lang racket
(define (list-reversal lst)

  ;base case
  (if (null? lst)
      '()
  ;recursion
      (append (list-reversal (cdr lst)) (list (car lst))))
  )

(define (l lst)

  (reverse lst))

