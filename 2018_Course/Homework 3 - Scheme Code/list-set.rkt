#lang racket
(define list-set
  (lambda (lst n x)
    (if(null? lst)
       (display "Cannot Operate On Empty List")
      (if (zero? n)
          (cons x (cdr lst))
    (cons (car lst) ( list-set (cdr lst) (- n 1) x))
          ))))

    
    