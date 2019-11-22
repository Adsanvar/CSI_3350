#lang racket
(define isSortedAscendingly?
  (lambda lst
       (if (> (cadar lst) (caar lst ))
               (isSortedAscendingly? (cdr lst))
               (#f))))

            