#lang racket
(#%provide (all-defined))
#|
If there are any specific instructions for a problem, please read them carefully. Otherwise,
follow these general rules:
   - replace the 'UNIMPLEMENTED symbol with your solution
   - you are NOT allowed to change the names of any definition
   - you are NOT allowed to change the number of arguments of the pre-defined functions,
     but you can change the names of the arguments if you deem it necessary.
   - make sure that you submit an asnwer sheet that compiles! If you cannot write
     a correct solution at least make it compile, if you cannot make it compile then
     comment it out. In the latter case, make sure that the default definitions
     for the problem are still present. 
   - you may use any number of helper functions you deem necessary.

When done, make sure that you do not get any errors when you hit the "Run" button. 
If you cannot come up with a correct solution then please make the answer-sheet
compile correctly and comment any partial solution you might have; if this is the case,
the default definitions will have to be present!
|#
;======================================01=======================================
(define (list-of-even-numbers? lst)
   (define (helper lst1)
        (if (null? lst1) #t 
            (if (number? (car lst1))  
                (if (even? (car lst1)) (helper (cdr lst1)) #f)    
            #f)
        )
    )

    (if (list? lst) (helper lst) #f)
)

;======================================02=======================================
;;for n > 0
;Sn = 1/1 + 1/4 + 1/9 + 1/16 + ...
(define (series-a n)
  (define (formula n) 
        (/ 1 (* n n))    
    )
    (if (= n 0) 0 (+ (series-a (- n 1)) (formula n)))
)

;====
;;for n >= 0
;Sn = 1 - 1/2 + 1/6 - 1/24 + ...
(define (fact n prod)
    (if (= n 0)
        prod
        (fact (- n 1) (* n prod))
    )    
)

(define (series-b n)
  (define (formula n)
        (/ (expt -1 n) (fact (+ n 1) 1) ) )
    (if (= n 0) 1 (+ (series-b (- n 1)) (formula n)))
)

;======================================03=======================================
(define (carpet n)
  (define sym '%)
  (if (even? n) (set! sym '%) (set! sym '+))
   (define base (list '(%)))
  (if (= n 0)
    base
    (add_top_bottom sym (append_each_line sym (carpet (- n 1))))
  )
)

(define (append_each_line sym carpet)
    (if (null? carpet) 
        '()
        (cons 
        (append_one_line sym (car carpet)) 
        (append_each_line sym (cdr carpet)) 
        )
    )
)

(define (append_one_line sym lst)
    (reverse (cons sym (reverse (cons sym lst))))
)

(define (add_top_bottom sym lst)
     (reverse (cons (line_generation sym (length (car lst))) (reverse (cons (line_generation sym (length (car lst))) lst))))
)

(define (line_generation sym len)
    (if (= len 0)
        '()
        (cons sym (line_generation sym (- len 1)))
    )
)

;======================================04=======================================
(define (pascal n) 
    
    (if (= n 1) '((1))
        (concat (pascal (- n 1)))
    )
)

(define (concat lst)

    (append lst (list(line lst)))
   
)

(define (line lst)
     (reverse (cons '1 (reverse (cons '1 (core (last lst))))))
)
;generates core
(define (core lst)
    (if (= (length lst) 1)
        '()
        (cons
            (+ (first lst) (second lst))
            (core (cdr lst))
        )
    )
)

;======================================05=======================================
(define (balanced? in)
    (checker (parser (string->list in)) 0 0  #f)
)

(define (checker lst n m state) 
     (if (null? lst) 
        (if (= n m) #t #f)
        (if (equal? state #f)
            (if (equal? (string (first lst)) "(") 
                (checker (cdr lst) (+ n 1) m #f)
                (checker (cdr lst) n (+ m 1) #t)
            )
            (if (equal? (string (first lst)) ")")
                (checker (cdr lst) n (+ m 1) #t)
                #f
            )
        )
      
    )
)

(define (parser lst)
    (if (null? lst) '()
        (if (equal? (string (first lst)) "(") 

        (cons (first lst) (parser (cdr lst)) ) 
        
            (if (equal? (string (first lst)) ")")
                (cons (first lst) (parser (cdr lst))) 
                (parser (cdr lst))
            )
        )
    )
    
)

;======================================06=======================================
(define (list-of-all? predicate lst)
    (if (null? lst) #t
        (if (predicate (car lst)) (list-of-all? predicate (cdr lst)) #f)
    )
  
)

;======================================07=======================================
(define (create-mapping keys vals)
    (if (valid? keys)
        (if (= (length keys) (length vals) )
            (lambda (x)
                (if (null? keys)
                    (create-error-msg "Could not find mapping for symbol" x)
                    (if (equal? (car keys) x) (car vals) ((create-mapping (cdr keys) (cdr vals)) x))) )
            (create-error-msg "The lists are not of equal length." '0)
        )
        (create-error-msg "The keys are not all symbols." '0)
    
    )
)
(define (valid? keys)
    (if (null? keys) #t
        (if (symbol? (car keys)) (valid? (cdr keys)) #f)
    )
)
(define (create-error-msg val sym)
    (if (equal? sym '0)
        val
        (string-append val " '" (symbol->string sym))
    ) 
)