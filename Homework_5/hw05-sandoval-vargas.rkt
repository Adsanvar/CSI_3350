#lang racket
(#%provide (all-defined))
(#%require (lib "eopl.ss" "eopl"))

#|
IMPORTANT:
Overall, you are allowed to change this file in any way that does not affect the
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
   - please rename this file to hw05-yourlastname.rkt prior to submission
   - also rename hw05-tests.rkt to hw05-yourlastname-tests.rkt
   - upload both hw05-yourlastname.rkt and hw05-tests.rkt
|#
;=======================================01======================================
(define (invalid-args-msg fun-name-as-string
                          expected-value-type-as-predicate-string
                          received)
  (string-append "Invalid arguments in: " fun-name-as-string " --- "
                 "expected: " expected-value-type-as-predicate-string " --- "
                 "received: " (~a received)
                 )
)

;You can compare the contents of this answer sheet with the answer sheet of the
;previous homework to infer what is generated automatically by define-datatype.

(define-datatype step step?
 (seq-step (st-1 step?) (st-2 step?))
 (up-step  (n number?))
 (down-step  (n number?))
 (left-step  (n number?))
 (right-step  (n number?))
)

(define (up-step? st)
  (if (equal? (single-step->n st) (invalid-args-msg "single-step->n" "single-step?" st))
    #f
    (equal? (up-step (single-step->n st)) st)
   
  )
 
)

(define (down-step? st)
 (if (equal? (single-step->n st) (invalid-args-msg "single-step->n" "single-step?" st))
    #f
    (equal? (down-step (single-step->n st)) st)
    
  )
  
)

(define (left-step? st)
  (if (equal? (single-step->n st) (invalid-args-msg "single-step->n" "single-step?" st))
    #f
    (equal? (left-step (single-step->n st)) st)
    
  )
  
)

(define (right-step? st)

  (if (equal? (single-step->n st) (invalid-args-msg "single-step->n" "single-step?" st)) 
    #f
    (equal? (right-step (single-step->n st)) st)
  )
      
  
)

(define (seq-step? st)
  (if (or (right-step? st) (left-step? st) (up-step? st) (down-step? st) (not (step? st)))
    #f
    (equal? (seq-step (seq-step->st-1 st) (seq-step->st-2 st)) st)
  )
  
)
;;to avoid needless duplication we will only implement one extractor to handle all the
;;simple steps, rather than 4. So this should take: up, down, left and right steps.
(define (single-step->n st)
(if (step? st)
    (cases step st
        (up-step (n) n)
        (down-step (n) n)
        (right-step (n) n)
        (left-step (n) n)
        (seq-step (st-1 st-2) (invalid-args-msg "single-step->n" "single-step?" st))
    )
    (invalid-args-msg "single-step->n" "single-step?" st) 
   )

)

;;two extractors, one for each piece of data representing a sequential step
(define (seq-step->st-1 st)
     (cases step st
        (up-step (n)  (invalid-args-msg "seq-step->st-1" "seq-step?" st))
        (down-step (n) (invalid-args-msg "seq-step->st-1" "seq-step?" st))
        (right-step (n) (invalid-args-msg "seq-step->st-1" "seq-step?" st))
        (left-step (n) (invalid-args-msg "seq-step->st-1" "seq-step?" st))
        (seq-step (st-1 st2) st-1)
    )
)


(define (seq-step->st-2 st)
       (cases step st
        (up-step (n)  (invalid-args-msg "seq-step->st-2" "seq-step?" st))
        (down-step (n) (invalid-args-msg "seq-step->st-2" "seq-step?" st))
        (right-step (n) (invalid-args-msg "seq-step->st-2" "seq-step?" st))
        (left-step (n) (invalid-args-msg "seq-step->st-2" "seq-step?" st))
        (seq-step (st-1 st-2) st-2)
      )
)
;;===================================

(define (move start-p step)
  (if (seq-step? step)
    (move (move start-p (seq-step->st-1 step)) (seq-step->st-2 step))
    (if (up-step? step)
      (list (first start-p) (+ (second start-p) (single-step->n step)))
      (if (down-step? step)
        (list (first start-p) (- (second start-p) (single-step->n step)))
        (if (right-step? step)
          (list (+ (first start-p) (single-step->n step)) (second start-p))
          (if (left-step? step)
            (list (- (first start-p) (single-step->n step)) (second start-p))
            (invalid-args-msg "move" "move?" step) 
          )
        )
      )
    )
  )
)
;=======================================02======================================
;2.a
(define (exception-no-binding-msg sym)
  (string-append "No binding for '" (~a sym))
  )

;
(define-datatype environment environment?
 (empty-env)
 (extend-env (sym symbol?)(val number?) (environment environment?))
 (extend-env-final (sym symbol?) (val number?) (saved-env environment?))
)

(define (apply-env env search-sym)
    (cases environment env
      (empty-env () (exception-no-binding-msg search-sym))
        (extend-env
          (saved-sym saved-val saved-env)
            (if (eqv? search-sym saved-sym)
              saved-val
              (apply-env saved-env search-sym)))
        (extend-env-final (saved-sym saved-val saved-env)
         (if (eqv? search-sym saved-sym)
             saved-val
             (apply-env saved-env search-sym))
      )          
    )
)

;==========
;2.b
(define (exception-sym-final-msg sym)
  (string-append "Symbol '" (~a sym) " is final and cannot be overriden.")
  )

;It is prefered to give meaningfull names to marker values.
;In the tests we will be using these two values to invoke
;the extend-env-wrapper function
(define FINAL #t)
(define NON-FINAL #f)

(define (extend-env-wrapper sym val old-env final?)

    (define (is-final? env)
      (cases environment env
        (empty-env () #f)
        (extend-env (saved-sym saved-val saved-env) (is-final? saved-env))
        (extend-env-final (saved-sym saved-val saved-env)
          (if (equal? sym saved-sym)
            #t
            (is-final? saved-env)
          )
        )
      )
    )

  (if (is-final? old-env)
      (exception-sym-final-msg sym)
      (if final?
        (extend-env-final sym val old-env)
        (extend-env sym val old-env)
      )
  )

)

