#lang racket
(#%provide (all-defined))
(#%require "test-infrastructure.rkt")
(#%require rackunit)

(#%require "hw03-sandoval-vargas.rkt")

;as you can probably figure out, this function will run
;all the tests.
(define (test-all)
  (test p1-a)
  (test p1-b)
  (test p2)
  (test p3)
  (test p4)
  (test p5)
  (test p6)
  (test p7)
)

;======================================01=======================================
(define p1-a
  (test-suite
    "fold left"
    (335-check-equal?
       (foldl-335 + 0 '(1 2 3 4))
       10
       "foldl with addition"
     )
    
    (335-check-equal?
       (foldl-335 + 0 '())
       0
       "foldl over an empty list"
     )
    
    (335-check-equal?
       (foldl-335 + 42 '())
       42
       "foldl over an empty list with zero element = 42"
     )
    
    (335-check-equal?
       (foldl-335 string-append "" (list "!!!" "42"  "is " "answer " "the " ))
       "the answer is 42!!!"
       "foldl over strings"
     )
    
    (335-check-equal?
       (foldl-335 - 0 '(1 2 3 4))
        2
       "foldl with subtraction in order list"
     )
    
    (335-check-equal?
       (foldl-335 - 0 '(4 3 2 1))
        -2
       "foldl with subtraction reverse order list"
     )
  )
)
;---

(define p1-b
  (test-suite
    "fold right"
    (335-check-equal?
       (foldr-335 + 0 '(1 2 3 4))
       10
       "foldr with addition"
     )
    
    (335-check-equal?
       (foldr-335 + 0 '())
       0
       "foldr over an empty list"
     )
    
    (335-check-equal?
       (foldr-335 + 42 '())
       42
       "foldr over an empty list with zero element = 42"
     )
    
    (335-check-equal?
       (foldr-335 string-append "" (list "the " "answer " "is " "42" "!!!"))
       "the answer is 42!!!"
       "foldr over strings"
     )
    
    (335-check-equal?
       (foldr-335 - 0 '(1 2 3 4))
        -2
       "foldr with subtraction in order list"
     )
    
    (335-check-equal?
       (foldr-335 - 0 '(4 3 2 1))
        2
       "foldr with subtraction reverse order list"
     )
  )
)
;======================================02=======================================
(define p2
  (test-suite
    "andmap"
    (335-check-equal?
      (andmap-335 odd? '(1 3 5))
      #t
      "list containing only odd numbers"
   )
    
    (335-check-equal?
      (andmap-335 odd? '(1 3 6))
      #f
      "list of odds containing one even number"
    )
    
    (335-check-equal?
      (andmap-335 odd? '())
      #t
      "empty list"
    )
    
  )
)
;======================================03=======================================
(define p3
  (test-suite
    "filter"

   (335-check-equal?
      (filter-335 odd? '(1 2 3 4 5 6 7 8 9 10))
      '(1 3 5 7 9)
      "filter odds"
    )

   (335-check-equal?
      (filter-335 number? '(42 'not-a-number "not-a-number"))
      '(42)
      "filter numbers"
    )
   
   (335-check-equal?
      (filter-335 number? '( 'not-a-number "not-a-number"))
      '()
      "no elements fit the filter"
    )
  )
)
;======================================04=======================================
(define add-forty-two
  (lambda (x) (+ x 42)))

(define p4
  (test-suite
    "map reduce"
    
    (335-check-equal?
      (map-reduce add-forty-two + 0 '(0 1 2))
      129
      "we add 42 to each number then add them together"
    )
    
    (335-check-equal?
      (map-reduce add-forty-two + 0 '())
      0
      "map reduce over an empty list with zero element 0"
    )
    
    (335-check-equal?
      (map-reduce add-forty-two + 42 '())
      42
      "map reduce over an empty list with zero element = 42"
    )
  )
)
;======================================05=======================================
(define p5
  (test-suite
    "revisiting series: Sn = 1 - 1/2 + 1/6 - 1/24 + ..."
    
    (335-check-equal?
       (series 0)
       1
     "test 0"
     )
    
    (335-check-equal?
       (series 1)
       1/2
     "test 1"
     )
    
    (335-check-equal?
       (series 2)
       2/3
     "test 2"
     )
    
    (335-check-equal?
       (series 3)
       5/8
     "test 3"
     )
    
    (335-check-equal?
       (series 4)
       19/30
     "test 4"
     )
    
    (335-check-equal?
       (series 5)
       91/144
     "test 5"
     )
  )
)
;======================================06=======================================
(define p6
  (test-suite
    "zip"
    
    (335-check-equal?
      (zip '(1 2 3) '(one two three))
      '((1 one) (2 two) (3 three))
    )
    
    (335-check-equal?
      (zip '() '())
      '()
    )
  )
)
;======================================07=======================================
(define n-matrix 
   '((1 2 3 4)
     (5 6 7 8)
     (9 0 1 2))
)

(define str-matrix
  '(("a" "c" "e")
    ("b" "d" "f"))
)

(define p7
  (test-suite
    "matrix to vector"
    
    (335-check-equal?
      (matrix-to-vector + n-matrix)
      '(15 8 11 14)
    )
    
    (335-check-equal?
      (matrix-to-vector string-append str-matrix)
      '("ab" "cd" "ef")
    )
  )
)
(test-all)