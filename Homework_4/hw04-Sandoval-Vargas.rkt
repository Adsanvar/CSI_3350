#lang racket
(#%provide (all-defined))
;(require math/number-theory)
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
   - you may write any number of helper functions

When done, make sure that the accompanying test file compiles. 
If you cannot come up with a correct solution then please make the answer-sheet
compiles. If you have partial solutions that do not compile please comment them out,
if this is the case, the default definitions will have to be present since the tests
will be expecting functions with the names defined here.

Submission guidelines:
   - please rename the file to hw04-yourlastname-answer.rkt prior to submission
   - only the renamed file file needs to be uploaded
|#
;======================================01=======================================
(define-syntax-rule (for {var <- value-range} yield result)
  (map (lambda (var) result) value-range)
)
;======================================02=======================================
(define-syntax-rule (seq expr1 expr2)
  ((lambda () expr1 expr2))
)

;====
(define-syntax-rule (while condition body)
  (letrec 
    (  
      (loop
        (lambda () 
          (if condition ((lambda () body (loop))) 0)
        )
      )
    )
    (loop)
    )
)

;======================================03=======================================
#|
<step> ::=  <step>  <step>       "seq-step"
          | "up" number          "up-step"
          | "down" number        "down-step"
          | "left" number        "left-step"
          | "right" number       "right-step"
|#
;example of how to create the error message for the "up-step" constructor
;> (invalid-args-msg "up-step" "number?" '(1 2 3 4))
;where '(1 2 3 4) should be replaced by the actual violating value.
(define (invalid-args-msg step cause data)
    (define p1 "Invalid arguments in: ")
    (define p2 " --- expected: ")
    (define p3 " --- received: ")
    (string-append p1 step p2 cause p3 data)
)
;;you can reorder the functions below if it better suits your needs
(define (up-step n)
   (if (number? n)
     (list 'up-step n)
     (invalid-args-msg "up-step" "number?" n)
    ) 
)

(define (down-step n)
    (if (number? n)
     (list 'down-step n)
     (invalid-args-msg "down-step" "number?" n)
    ) 
)

(define (left-step n)
    (if (number? n)
     (list 'left-step n)
     (invalid-args-msg "left-step" "number?" n)
    ) 
)

(define (right-step n)
    (if (number? n)
     (list 'right-step n)
     (invalid-args-msg "right-step" "number?" n)
    )
)

(define (seq-step st-1 st-2)
 (if (and (list? st-1) (list? st-2))
    (list  st-1 st-2)
    (if (equal? (list? st-1) #f) (invalid-args-msg "seq-step" "step?" st-1)
        (invalid-args-msg "seq-step" "step?" st-2)
    )
  )
)

;;====
(define (up-step? st)
  (if (list? st) 
        (if (equal? (car st) 'up-step)
            (if (number? (second st))
                #t
                #f
            )
        #f)
     #f)
)

(define (down-step? st)
  (if (list? st) 
        (if (equal? (car st) 'down-step)
            (if (number? (second st))
                #t
                #f
            )
        #f)
     #f) 
)


(define (left-step? st)
  (if (list? st) 
        (if (equal? (car st) 'left-step)
            (if (number? (second st))
                #t
                #f
            )
        #f)
     #f)
)

(define (right-step? st)
  (if (list? st) 
        (if (equal? (car st) 'right-step)
            (if (number? (second st))
                #t
                #f
            )
        #f)
     #f) 
)

(define (seq-step? st)
  (if (step? (car st)) (if (step? (second st)) #t #f) #f) 
)

;This is a predicate that tells you whether or not something is a step,
;it should return true when given either up, down, left, right or seq steps.
(define (step? st)
 (define steps '(up-step down-step right-step left-step ))
  (define found #f)
  (if (list? st)
    (for-each (lambda (val) (if (equal? (if (list? (car st)) (caar st) (car st)) val) (set! found #t) #f ) ) steps)
    #f
  )
  (if (list? st) 
        (if (equal? found #t) 
            (if (number? (if (list? (second st)) (second (car st)) (second st) )  )
                #t
                #f
            )
        #f)
     #f)
)


;; to avoid needless duplication we will only implement one extractor to handle all the
;; simple steps, rather than four of them. 
;; So this should take: up, down, left and right steps.
(define (single-step->n st)
  (if (step? st)
    (second st)
    (invalid-args-msg "single-step->n" "single-step?" st)
  )
)

;;two extractors, one for each piece of data representing a sequential step
(define (seq-step->st-1 st)
    (if (seq-step? st)
    (car st)
    (invalid-args-msg "seq-step->st-1" "seq-step?" st)
  )
)


(define (seq-step->st-2 st)
  (if (seq-step? st)
    (second st)
    (invalid-args-msg "seq-step->st-1" "seq-step?" st)
  ) 
)
;;===================================
(define (calc)
  (lambda (st vec)
     (if (equal? (car st) 'up-step) (list (first vec) (+ (second vec) (second st)))
        (if (equal? (car st) 'down-step) (list (first vec) (- (second vec) (second st)))
            (if (equal? (car st) 'right-step) (list (+ (first vec) (second st)) (second vec) )
                (if (equal? (car st) 'left-step) (list (- (first vec) (second st)) (second vec))
                    (invalid-args-msg "move" "step?" st)
                )
            )
        )
     )  
    ) 

)
(define (rec st var)
    (if (null? st)
        var
        (if (seq-step? (car st))
            (rec (cdar st) ((calc) (caar st) var))
            (rec (cdr st) ((calc) (car st) var) )
        )
    )
)
(define (move start-p step)
   (if (seq-step? step)
        (rec step start-p)
        (if (step? step) ((calc) step start-p) (invalid-args-msg "move" "step?" step))
    )
)

;======================================04=======================================
;singleton-set should return a function that takes a number as an argument and
;tells whether or not that number is in the set
(define (singleton-set x)
  (lambda (y) (if (equal? x y) #t #f))
)


;the set of all elements that are in either 's1' or 's2'
(define (union s1 s2)
  (lambda (x) (if (or (s1 x) (s2 x)) #t #f))
)

;the set of all elements that are in both  in 's1' and 's2'
(define (intersection s1 s2)
  (lambda (x) (if (and (s1 x) (s2 x)) #t #f))
)

;the set of all elements that are in 's1', but that are not in 's2'
(define (diff s1 s2)
  (lambda (x) (if (and (s1 x) (not (s2 x))) #t #f))
)

;returns the subset of s, for which the predicate 'predicate' is true.
(define (filter predicate s)
  (lambda (x) (if (predicate x) (s x) #f))
)

;we assume that the sets can contain only numbers between 0 and bound
(define bound 100)

;returns whether or not the set contains at least an element for which
;the predicate is true. s below is the parameter standing for a given set

(define (exists? predicate s)
    (letrec 
     (
         (loop
         (lambda (x)
            (if (null? x)
                #f
                (if (predicate (car x)) 
                    (if 
                        (s (car x))
                        #t
                        (loop (cdr x))
                    ) 
                    (loop (cdr x))
                )
            )
         )
         )
     
     )
    (loop (range 1 bound))
    )
)


;returns whether or not the predicate is true for all the elements
;of the given set s
(define (all? predicate s)
        (letrec 
     (
         (loop
         (lambda (x)
            (if (null? x)
                #t
                (if (and (not (predicate (car x))) (s (car x))) 
                   #f
                    (loop (cdr x))
                )
            )
         )
         )
     
     )
    (loop (range 1 bound))
    )
)

;returns a new set where "op" has been applied to all elements
; NOTE: just because a procedure/function has the word "map" in it, it 
;       doesn't mean you have to use map higher order function to implement it. 
;       Map is a functional operation with well defined behavior that 
;       is not tied to any implementation.
(define (map-set op s)
  (lambda (p)
    (letrec 
     (
         (loop
          
            (lambda (x)
                (if (null? x)
                    #f
                    (if (s (car x))  (if ((singleton-set (op (car x))) p) #t (loop (cdr x))) (loop (cdr x)))
                )
            )
         )
     
     )
    (loop (range bound))
    )
  )
)

;just a sample predicate
(define (prime? n)
  (define (non-divisible? n)
    (lambda (i)
      (not (= (modulo n i) 0))))
  (define range-of-prime-divisors (cddr (range (+ (integer-sqrt n) 1))))
  (if (equal? n 1)
      #f
      (andmap (non-divisible? n) range-of-prime-divisors)
      )
  )

;=====================================05====================================
; FYI:
;  to emphasize the procedural-based approach to implement "step" data type and to
;  contrast it with the data structure-based approach for "step" implementation 
;  used in p3, here we add "-proc" suffix to each corresponding function name.

;====p5-a================
(define u 'up-step)
(define d 'down-step)
(define l 'left-step)
(define r 'right-step)
(define extract 'extract-size)

(define (up-step-proc n)
   (if (number? n)
   (lambda (a)
        (if (equal? a extract)
            n
            (if (equal? a u)
                #t
            #f )
        )
    ) 
 (invalid-args-msg "up-step-proc" "number?" n)
  ) 
)

(define (down-step-proc n)
  (if (number? n)
   (lambda (a)
        (if (equal? a extract)
            n
            (if (equal? a d)
                #t
            #f )
        )
    ) 
    (invalid-args-msg "down-step-proc" "number?" n)
  )   
)

(define (left-step-proc n)
  (if (number? n)
   (lambda (a)
        (if (equal? a extract)
            n
            (if (equal? a l)
                #t
            #f )
        )
    ) 
    (invalid-args-msg "left-step-proc" "number?" n)
  )   
)

(define (right-step-proc n)
  (if (number? n)
   (lambda (a)
        (if (equal? a extract)
            n
            (if (equal? a r)
                #t
            #f )
        )
    )
    (invalid-args-msg "right-step-proc" "number?" n)
  )
  
)

(define ex1 'st-1)
(define ex2 'st-2)
(define (seq-step-proc st-1 st-2)
    (define (prc) st-1 st-2)
    (define seq 'seq)
    (if (procedure? st-1)
        (if (procedure? st-2)
            (lambda (x)
                (if (equal? x ex1)
                    st-1
                    (if (equal? x ex2)
                        st-2
                        (if (equal? x seq)
                            prc
                            prc

                        )
                    )
                )
            )
            (invalid-args-msg "seq-step-proc" "step-proc?" st-2)
        )
        (invalid-args-msg "seq-step-proc" "step-proc?" st-1)

    )
)


;;====
(define (up-step-proc? st)
  (st 'up-step)
)

(define (down-step-proc? st)
  (st 'down-step) 
)

(define (left-step-proc? st)
  (st 'left-step) 
)

(define (right-step-proc? st)
  (st 'right-step) 
)

(define (seq-step-proc? st)
    ;;; (if (procedure? st) 
    ;;;     #t
    ;;;     #f
    ;;; )
 (if (procedure? (st 'seq)) 
        #t
        #f
    )
)

;This is a predicate that tells you whether or not st is a step,
; it should return true when given either up, down, left, right or seq steps.
(define (step-proc? st)
    (if (or 
        (up-step-proc? st)
        (down-step-proc? st)
        (right-step-proc? st)
        (left-step-proc? st)
        (seq-step? st)
      )
    #t
    #f
  )
    

)

;;to avoid needless duplication we will only implement one extractor to handle all the
;; simple steps, rather than four of them. So this should take: up, down, left and right 
;; steps. 
(define (single-step-proc->n st)
    (if (and (procedure? st) 
             (or 
                (up-step-proc? st)
                (down-step-proc? st)
                (right-step-proc? st)
                (left-step-proc? st)
            )
        )
        (st extract)
        (invalid-args-msg "single-step-proc->n" "single-step-proc?" st)
    )
)

;;two extractors
(define (seq-step-proc->st-1 st)
  (st ex1)
)


(define (seq-step-proc->st-2 st)
  (st ex2)
)
;;========p5-b

(define calc-proc
    (lambda (prc vec)
        (if 
            (prc u)
            (list (first vec) (+ (second vec) (prc extract)))
            (if (prc d) 
                (list (first vec) (- (second vec) (prc extract)))
                (if (prc l)
                    (list (- (first vec) (prc extract)) (second vec))
                    (if (prc r)
                        (list (+ (first vec) (prc extract)) (second vec) )
                        (invalid-args-msg "move-proc" "step" prc)
                    )
                )
            )
        )
    )

)

(define (rec-proc step-proc vec)
  (if  (seq-step-proc? (seq-step-proc->st-2 step-proc)) 
      (calc-proc (seq-step-proc->st-2 (seq-step-proc->st-2 step-proc))  (calc-proc (seq-step-proc->st-1 (seq-step-proc->st-2 step-proc)) (calc-proc (seq-step-proc->st-1 step-proc) vec)))
      (calc-proc (seq-step-proc->st-2 step-proc) (calc-proc (seq-step-proc->st-1 step-proc) vec))

  )
)

(define (move-proc start-p step-proc)
  (if (seq-step-proc? step-proc)
        (rec-proc step-proc start-p)
        (calc-proc step-proc start-p) 
    )  

)