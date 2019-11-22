#lang racket
;Question 1
;;; (define (list-of-even-numbers? lst)
;;;     (define (helper lst1)
;;;         (if (null? lst1) #t 
;;;             (if (number? (car lst1))  
;;;                 (if (even? (car lst1)) (helper (cdr lst1)) #f)    
;;;             #f)
;;;         )
;;;     )
;;;     (if (list? lst) (helper lst) #f)
;;; )

;;; (list-of-even-numbers? '(4 20 16 2))
;;; (list-of-even-numbers? '(4 1 16 2))
;;; (list-of-even-numbers? '(4 2 16 "two"))
;;; (list-of-even-numbers? '(4 2 16 'two))
;;; (list-of-even-numbers? '(4 1 16 '(2 4)))
;;; (list-of-even-numbers? 2)

;;; ;Question 2.a
;;; (define (series-a n)
;;;     (define (formula n)
;;;         (/ 1 (* n n))    
;;;     )
;;;     (if (= n 0) 0 (+ (series-a (- n 1)) (formula n)))
;;; )
;;; (series-a 4)

;;; ;Question 2.b
;;; (define (fact n prod)
;;;     (if (= n 0)
;;;         prod
;;;         (fact (- n 1) (* n prod))
;;;     )    
;;; )
;;; (define (series-b n)
;;;     (define (formula n)
;;;         (/ (expt -1 n) (fact (+ n 1) 1) ) )
;;;     (if (= n 0) 1 (+ (series-b (- n 1)) (formula n)))
;;; )

;;; (series-b 5)

;Question 3
;;; (define (carpet n)
;;;  (define sym '%)
;;;  (if (even? n) (set! sym '%) (set! sym '+))
;;;    (define base (list '(%)))
;;;   (if (= n 0)
;;;     base
;;;     (add_top_bottom sym (double_append_each_line sym (carpet (- n 1))))
;;;   )
;;; )

;;; ;(double_append_each_line '% '((+ + +) (+ % +) (+ + +)))
;;; ;=> '( (% + + + %) (% + % + %) (% + + + %))
;;; (define (double_append_each_line sym carpet)
;;;     (if (null? carpet) 
;;;         '()
;;;         (cons 
;;;         (double_append_one_line sym (car carpet)) ; '(% + + + %)
;;;         (double_append_each_line sym (cdr carpet)) ; '((% + % + %) (% + + + %))
;;;         )
;;;     )
;;; )
;;; ;(double_append_one_line '% '(+ % +) => '(% + % + %))
;;; (define (double_append_one_line sym lst)
;;;     (reverse (cons sym (reverse (cons sym lst))))
;;; )

;;; (define (add_top_bottom sym lst)
;;;      (reverse (cons (line_generation sym (length (car lst))) (reverse (cons (line_generation sym (length (car lst))) lst))))
;;; )

;;; (define (line_generation sym len)
;;;     (if (= len 0)
;;;         '()
;;;         (cons sym (line_generation sym (- len 1)))
;;;     )
;;; )
;;; ;(reverse (cons (add_top_bottom '((+ % +)) (length (car (double_append_each_line '% '((+ % +)))))) (reverse (cons (add_top_bottom '((+ % +)) (length (car (double_append_each_line '% '((+ % +)))))) (double_append_each_line '% '((+ % +))) )) ))

;;; ;(add_top_bottom (caar (double_append_each_line '% '((+ + +) (+ % +) (+ + +)))) (double_append_each_line '% '((+ + +) (+ % +) (+ + +))))
;;; ;(double_append_each_line '+ (double_append_each_line '% '((+ + +) (+ % +) (+ + +))))

;Question 4
;;; (define (pascal n) 

;;;     (if (= n 1) '((1))
;;;         (concat (pascal (- n 1)))
;;;     )
;;; )

;;; (define (concat lst)

;;;     (append lst (list(line lst)))
   
;;; )

;;; (define (line lst)
;;;      (reverse (cons '1 (reverse (cons '1 (core (last lst))))))
;;; )
;;; ;generates core
;;; (define (core lst)
;;;     (if (= (length lst) 1)
;;;         '()
;;;         (cons
;;;             (+ (first lst) (second lst))
;;;             (core (cdr lst))
;;;         )
;;;     )
;;; )
;;; (pascal 6)

;Question 5
;;; (define (balanced? in)
;;;     (checker (parser (string->list in)) 0 0  #f)
;;; )

;;; (define (checker lst n m state) 
;;;      (if (null? lst) 
;;;         (if (= n m) #t #f)
;;;         (if (equal? state #f)
;;;             (if (equal? (string (first lst)) "(") 
;;;                 (checker (cdr lst) (+ n 1) m #f)
;;;                 (checker (cdr lst) n (+ m 1) #t)
;;;             )
;;;             (if (equal? (string (first lst)) ")")
;;;                 (checker (cdr lst) n (+ m 1) #t)
;;;                 #f
;;;             )
;;;         )
      
;;;     )
;;; )

;;; (define (parser lst)
;;;     (if (null? lst) '()
;;;         (if (equal? (string (first lst)) "(") 

;;;         (cons (first lst) (parser (cdr lst)) ) 
        
;;;             (if (equal? (string (first lst)) ")")
;;;                 (cons (first lst) (parser (cdr lst))) 
;;;                 (parser (cdr lst))
;;;             )
;;;         )
;;;     )
    
;;; )
;;; (balanced? "()")

;Question 6
;;; (define (list-of-all? predicate lst)
;;;     (if (null? lst) #t
;;;         (if (predicate (car lst)) (list-of-all? predicate (cdr lst)) #f)
;;;     )
;;; )
;;; (list-of-all? string? '("a" "b" "42"))
;;; (list-of-all? string? '('a "b" "42"))

;;; (define (F) 
;;; (lambda (x) (+ x 1))
;;; )

;;; ((F) 2)

;Question 7
;;; (define (create-mapping keys vals)
;;;     (if (valid? keys)
;;;         (if (= (length keys) (length vals) )
;;;             (lambda (x)
;;;                 (if (null? keys)
;;;                     (create-error-msg "Could not find mapping for symbol" x)
;;;                     (if (equal? (car keys) x) (car vals) ((create-mapping (cdr keys) (cdr vals)) x))) )
;;;             (create-error-msg "The lists are not of equal length." '0)
;;;         )
;;;         (create-error-msg "The keys are not all symbols." '0)
    
;;;     )
;;; )
;;; (define (valid? keys)
;;;     (if (null? keys) #t
;;;         (if (symbol? (car keys)) (valid? (cdr keys)) #f)
;;;     )
;;; )

;;; (define (create-error-msg val sym)
;;;     (if (equal? sym '0)
;;;         val
;;;         (string-append val " '" (symbol->string sym))
;;;     ) 
;;; )

;;; (define roman '(I II III IV))
;;; (define arabic '(1 2 3 4))
;;; (define invalid-keys '(a b "c" d))

;;;  ((create-mapping roman arabic) 'I)
;;;  ((create-mapping roman arabic) 'II)
;;;  ((create-mapping roman arabic) 'III)
;;;  ((create-mapping roman arabic) 'IV)
;;;  (create-mapping invalid-keys arabic)
;;;  (create-mapping '(a b c) '(1 2 3 4))
;;;  ((create-mapping roman arabic) 'not-in-the-map)
