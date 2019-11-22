#lang racket
(#%provide (all-defined))

#|
IMPORTANT:
Overall, you are allowed to change this file in any way that does *not* affect the
compilation of the accompanying test file. Changes that are almost certain to break
the above restriction are:
  - changing the names of any definitions that are explicitely used in the tests
    (e.g. function names, relevant constants)

If there are any specific instructions for a problem, please read them carefully. Otherwise,
follow these general rules:

   - replace the 'UNIMPLEMENTED symbol with your solution
   - you are NOT allowed to change the number of arguments of the pre-defined functions,
     because changing the number of arguments automatically changes the semantics of the 
     function. Changing the name of the arguments is permitted since that change only
     affects the readability of the function, not the semantics.
   - you may write any number of helper functions as you want.

When done, make sure that the accompanying test file compiles. 
|#
;======================================01=======================================
(define (foldl-335 op default-el lst)
   (if (null? lst) default-el
    (foldl-335 op (op (car lst) default-el) (cdr lst))
   )
)

;---
(define (foldr-335 op default-el lst)
     (if (null? lst) default-el
        (foldr-335 op (op (last lst) default-el) (reverse (cdr (reverse lst)))) 
    )
)

;======================================02=======================================
(define (andmap-335 test-op lst)
    (if (null? lst) #t
    (if (test-op (car lst)) (andmap-335 test-op (cdr lst)) #f)
  )
)

;======================================03=======================================
(define (filter-335 test-op lst)
  (if (null? lst)
        '()
        (if (test-op (car lst)) (cons (car lst) (filter-335 test-op (cdr lst))) (filter-335 test-op (cdr lst))) 
  )
)

;======================================04=======================================
(define (map-reduce m-op r-op default-el lst)
  (foldl r-op default-el (map m-op lst))
)

;======================================05=======================================
(define (series n)
(define (fact n prod)
    (if (= n 0)
        prod
        (fact (- n 1) (* n prod))
    )    
)
 (define An
        (lambda (n) (/ (expt -1 n) (fact (+ n 1) 1) ))
    )
  (foldl + 0 (map An (range (+ n 1)))) 
)

;======================================06=======================================
(define (zip lst1 lst2)
  (map list lst1 lst2)  
)

;======================================07=======================================
(define (matrix-to-vector op mat)
  (if (null? mat)
        (if (eq? op +) '(0 0 0 0) '("" "" ""))
        (map op (car mat) (matrix-to-vector op (cdr mat))) 
    )
)
