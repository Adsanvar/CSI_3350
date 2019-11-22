#lang racket
(define step-into-list
  (lambda (s sexp)
    (if (symbol? sexp)
        (if (eqv? sexp s) 1 0)
        (count-occurrences s sexp))))

(define count-occurrences
  (lambda (s slist)
    (if (null? slist)
        0
        (+ (step-into-list s (car slist))
           (count-occurrences s (cdr slist))))))