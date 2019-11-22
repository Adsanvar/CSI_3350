#lang racket

;;; (map list '(1 2 3) '(1 2 3) )

;;; (foldl string-append "" '("3" "I" "C") '("5" "3" "S"))
;;; (foldl string-append "" '("C" "E" "4") '("5" "3" "3"))

;;; (define add2 (lambda (x) (+ x 2)))
;;; (map add2 '(1 3 4))
;Question 1a
;;; (define (foldl-335 op default-el lst)
;;;    (if (null? lst) default-el
;;;     (foldl-335 op (op (car lst) default-el) (cdr lst))
;;;    )
;;; )
;;; (foldl-335 string-append "" (list "!!!" "42"  "is " "answer " "the " ))
;Question 1b
;;; (define (foldr-335 op default-el lst)
;;;      (if (null? lst) default-el
;;;         (foldr-335 op (op (last lst) default-el) (reverse (cdr (reverse lst))) )
;;;     )
;;; )
;;; (foldr - 0 '(1 2 3 4))
;;; (foldr-335 - 0 '(1 2 3 4))
;;; (foldr-335 string-append "" (list "the " "answer " "is " "42" "!!!"))
;Question 2
;;; (define (andmap-335 test-op lst)
;;;   (if (null? lst) #t
;;;     (if (test-op (car lst)) (andmap-335 test-op (cdr lst)) #f)
;;;   )
;;; )
;;; (andmap-335 odd? '(1 3 5))
;;; (andmap-335 odd? '(1 3 6))
;;; (andmap-335 odd? '())

;Question 3
;;; (define (filter-335 test-op lst)
;;;     (if (null? lst)
;;;         '()
;;;         (if (test-op (car lst)) (cons (car lst) (filter-335 test-op (cdr lst))) (filter-335 test-op (cdr lst))) 
;;;     )
  
;;; )
;;; (filter-335 odd? '(1 2 3 4 5 6 7 8 9 10))
;;; (filter-335 number? '(42 'not-a-number "not-a-number"))
;;; (filter-335 number? '( 'not-a-number "not-a-number"))
;Question 4

;;; (define add-forty-two
;;;   (lambda (x) (+ x 42)))
;;; ;Need to add 42 to each element in lst
;;; ;Then add all the elements in the lst
;;; (define (map-reduce m-op r-op default-el lst)
;;;     (foldl r-op default-el (map m-op lst))
;;; )

;;; ;(foldl + 0 '(1 2 3))
;;; ;(map + '(1 3) '(1 2) )
;;; ;(map (add-forty-two (car '(1 2 3))) 
;;; ;(map-reduce add-forty-two + 0 '(1))
;;; (map-reduce add-forty-two + 0 '(0 1 2))
;;; ;(foldl + 0 (map-reduce add-forty-two + 0 '(0 1 2)))

;Question 5
;;; (define (fact n prod)
;;;     (if (= n 0)
;;;         prod
;;;         (fact (- n 1) (* n prod))
;;;     )    
;;; )

;;; (define (series n)
;;;     (define An
;;;         (lambda (n) (/ (expt -1 n) (fact (+ n 1) 1) ))
;;;     )
;;;     (foldl + 0 (map An (range (+ n 1))))   
;;; )

;;; (series 0)
;;; (series 5)

;Question 6
;;; (define (zip lst1 lst2)
;;;   (map list lst1 lst2) 
;;; )

;;; (zip '(1 2 3) '(one two three))
;;; (zip '() '())


;Question 7
(define n-matrix 
   '((1 2 3 4)
     (5 6 7 8)
     (9 0 1 2))
)

(define str-matrix
  '(("a" "c" "e")
    ("b" "d" "f"))
)

(define (matrix-to-vector op mat)
  
    (if (null? mat)
        (if (eq? op +) '(0 0 0 0) '("" "" ""))
        (map op (car mat) (matrix-to-vector op (cdr mat))) 
    )

  
)
(matrix-to-vector + n-matrix)
(matrix-to-vector string-append str-matrix)