#lang racket

(define zero (lambda () 0))
(define is-zero?
  (lambda (n) (zero? n)))
(define successor (lambda (n) (+ n 1)))
(define predecessor (lambda (n) (- n 1)))


(define plus
  (lambda (x y)
    (if(is-zero? x)
       y
       (successor(plus(predecessor x) y)))))