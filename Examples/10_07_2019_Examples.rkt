#lang racket

;;; (define (generate_top n sym)

;;;     (map (lambda (x) sym) (range (+ (* 2 n) 1))  )
;;; )

;(foldl string-append "" '("3" "I" "C") '("5" "3" "S") )

;(foldr string-append "" '("3" "I" "C") '("5" "3" "S") )

(define (op-op-between op1 op2 a b start) ;start = default for foldl
    (foldl op1 start (map op2 (range a (+ b 1))))
)

(op-op-between + (lambda (x) (* x x x)) 3 5 0)