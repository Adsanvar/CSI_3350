#lang racket

(define (p n)

  (cond
    ((< n 0) "Negative")
    ((= n 0) "Zero")
    ((= n 1) "One")
    ((= n 2) "Two")
    (else "ETC")
  )

)

;(p 9)
;Doing the same as cond with 'if'
(define (pIf n)
  (if
   ;A case
   (< n 0)
      ;B Case, "If n < 0 = true. If true."
      "Negative"
      ;C Case
      (if (= n 0)
          "Zero"
          (if (= n 1)
              "One"
              (if (= n 2)
                  "Two"
                  "ETC.,")
          )
       )
    )
)

;(pIf 4)
;Below is test for homework
(define x 2)

(define y 3)

(define z 4)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (p4)
  (cond
    ((and (> x z) (> y z)) (+ x y))
    ((and (> x y) (> z y)) (+ x z))
    ((and (> y x) (> z x)) (+ y z))
    (else 0)
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (p5)
  (cond
    ((and (< x z) (< y z)) (+ x y))
    ((and (< x y) (< z y)) (+ x z))
    ((and (< y x) (< z x)) (+ y z))
    (else 0)
   )
)
;;;;;p6
;(and (= x y))
;;;;;;;;;
;p7
;(define thirty-five 35)
;(define (thirty-five) 35)
;thirty-five
;(thirty-five)
;;;;;;;;;

;p8
;'name
;'+
;'(/ 4 2)
;'gargleblaster

;;;;;;;;;;;;

;p9
;(string->list "hello")
; (list 1 1 1)

;;;;;;;;;;;;
;p11
;(list 4 2 6 9)
;(list 'spaceship (list 'name (list 'serenity)) (list 'class (list 'firefly)))
;(list 2 '* (list (list 20 '- (list 91 '/ 7)) '* (list 45 '- 42)))

;;;;;;;;;;;;;;;;;;;
;p12
;(define lst '(a b c))
;(cons 'd lst)
;(append (reverse (cdr (reverse lst))) (append '(d) (reverse (cdr (reverse lst)))))
;(append (cdr lst) (cons 'd (list (car lst))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;p13 is answered through description.
;(define lst1 (list 1))
;(define lst2 (list 1))

;;;;;;;;;;;;;;;;;;;;;;;
;p14
(define (create-error-msg sym val)
    (define p1 "This is a custom error message we will be using next. Symbol '")
    (define p2 " was not paired with value ")
    (string-append p1 (symbol->string sym) p2 (number->string val))
  )


(define (check-correctness pair)
  (if
   ;A - Statement
   (equal? (car pair) 'answer-to-everything)
   ;B Case - if true, answer-to-everything matches then check for the next value
   (if
    ;A1 - Statement
    (equal? (cadr pair) 42)
    ;B1 - if they match return true
    #t
    ;C1 - Return an error if 42 doesn't match
    (create-error-msg (car pair) 42)

    )
   ;C Case - Fails at the first.
   #f)

)


