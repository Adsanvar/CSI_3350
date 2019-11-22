#lang racket
(define down
  (lambda (lst)
    (if (null? lst)
        '()
        (cons (list (car lst)) (downII (cdr lst))))))


(define (downII lst) (map list lst))

