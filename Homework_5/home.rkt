#lang racket

(#%require (lib "eopl.ss" "eopl"))

(define (invalid-args-msg fun-name-as-string
                          expected-value-type-as-predicate-string
                          received)
  (string-append "Invalid arguments in: " fun-name-as-string " --- "
                 "expected: " expected-value-type-as-predicate-string " --- "
                 "received: " (~a received)
                 )
)

(define-datatype step step?
 (seq-step (st-1 step?) (st-2 step?))
 (up-step  (n number?))
 (down-step  (n number?))
 (left-step  (n number?))
 (right-step  (n number?))
)

(define (up-step? st)
 (step? st)
)

(define (down-step? st)
  (step? st)  
)

(define (left-step? st)
  (step? st)
)

(define (right-step? st)
  (step? st) 
)

(define (seq-step? st)
  (step? st)
)

;;to avoid needless duplication we will only implement one extractor to handle all the
;;simple steps, rather than 4. So this should take: up, down, left and right steps.
(define (single-step->n st)

    (cases step st
        (up-step n (if (step? st) n (invalid-args-msg "single-step->n" "single-step?" st))
        (down-step n (if (step? st) n (invalid-args-msg "single-step->n" "single-step?" st))
        (right-step n (if (step? st) n (invalid-args-msg "single-step->n" "single-step?" st))
        (left-step n (if (step? st) n (invalid-args-msg "single-step->n" "single-step?" st))
    )


)

;;two extractors, one for each piece of data representing a sequential step
(define (seq-step->st-1 st)
  'UNIMPLEMENTED  
)


(define (seq-step->st-2 st)
  'UNIMPLEMENTED  
)
;;===================================
(define (move start-p step)
  'UNIMPLEMENTED  
)