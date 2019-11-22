#lang racket
(define invert
  (lambda (lst)
    (if (null? lst)
        '()
(cons (list (cadar lst) (caar lst)) (invert (cdr lst)))

    )
    ))

    