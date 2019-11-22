#lang racket

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

;Question 1
;;; (define-syntax-rule (for {var <- value-range} yield result)
;;;   (map (lambda (var) result) value-range)
;;; )

;;;  (for {a <- '(0 1 2 3)} yield (+ a 42))


;Question 2a
;;; (define-syntax-rule (seq expr1 expr2)
;;;   ((lambda () expr1 expr2))
;;; )
;;; (seq 'to-be-ignored (* 5 6))

;Question 2b
;;; (define-syntax-rule (while condition body)
;;;     (letrec ;tells compiler that we have a bounding variable to compute
;;;         (loop ;defines loop function
;;;             (lambda () 
;;;                 (if condition (lambda () body (loop))  0)
;;;             );lambda function that takes in nothing and returns:
;;;              ;if condition is met -> another function that computes body first then calls loop again
;;;              ;Once it's done or condition isn't met -> return 0 and end the function
;;;         )     
;;;         (loop);calls the fuction part of the letrec structure.
;;;     )
;;; )
;;; (let ([a 3]) (+ a 3))

;;; (define (f a) (+ a 3))
;;; (f 4)
;;; ((lambda (a) (+ a 3)) 4)

;Question 3
(define (invalid-args-msg step cause data)
    (define p1 "Invalid arguments in: ")
    (define p2 " --- expected: ")
    (define p3 " --- received: ")
    (string-append p1 step p2 cause p3 data)
)
;Rest in answersheet
;;; ;constructor
;;; (define (up-step n)
;;;    (if (number? n)
;;;      (list 'up-step n)
;;;      (invalid-args-msg "up-step" "number?" n)
;;;     ) 
;;; )

;;; (define (down-step n)
;;;     (if (number? n)
;;;      (list 'down-step n)
;;;      (invalid-args-msg "down-step" "number?" n)
;;;     ) 
;;; )

;;; (define (left-step n)
;;;     (if (number? n)
;;;      (list 'left-step n)
;;;      (invalid-args-msg "left-step" "number?" n)
;;;     ) 
;;; )

;;; (define (right-step n)
;;;     (if (number? n)
;;;      (list 'right-step n)
;;;      (invalid-args-msg "right-step" "number?" n)
;;;     )
;;; )


;;; ;;; ;Predicate
;;; (define (up-step? st)
;;;     (if (list? st) 
;;;         (if (equal? (car st) 'up-step)
;;;             (if (number? (second st))
;;;                 #t
;;;                 #f
;;;             )
;;;         #f)
;;;      #f)
;;; )

;;; (define (seq-step st-1 st-2)
;;;   (if (and (list? st-1) (list? st-2))
;;;     (list  st-1 st-2)
;;;     (if (equal? (list? st-1) #f) (invalid-args-msg "seq-step" "step?" st-1)
;;;         (invalid-args-msg "seq-step" "step?" st-2)
;;;     )
;;;   )
;;; )

;;; ;(for {a <- '(0 1 2 3)} yield (+ a 42))
;;; ; (for {a <- steps} yield (equal? a 'right-step))
;;; ;;; (define steps '(up-step down-step right-step left-step ))
;;; ;;; (define found #f)
;;; ;;; (for-each (lambda (val) (if (equal? 'right-sep val) (set! found #t) #f ) ) steps
;;; ;;; )


;;; (define (step? st)
;;;   (define steps '(up-step down-step right-step left-step ))
;;;   (define found #f)
;;;   (if (list? st)
;;;     (for-each (lambda (val) (if (equal? (if (list? (car st)) (caar st) (car st)) val) (set! found #t) #f ) ) steps)
;;;     #f
;;;   )
;;;   (if (list? st) 
;;;         (if (equal? found #t) 
;;;             (if (number? (if (list? (second st)) (second (car st)) (second st) )  )
;;;                 #t
;;;                 #f
;;;             )
;;;         #f)
;;;      #f)
;;; )


;;; (define (seq-step? st)
;;;     (if (step? (car st)) (if (step? (second st)) #t #f) #f) 
;;; )
;;; ;(seq-step? (seq-step (right-step 3) (up-step 4)))

;;; (define (single-step->n st)
;;;   (if (step? st)
;;;     (second st)
;;;       (invalid-args-msg "single-step->n" "single-step?" st)
;;;   )
;;; )
 
;;; ;(single-step->n "not-a-single-step")
       
;;; (define (seq-step->st-1 st)
;;;   (if (seq-step? st)
;;;     (car st)
;;;     (invalid-args-msg "seq-step->st-1" "seq-step?" st)
;;;   )
;;; )

;;; (define (seq-step->st-2 st)
;;;   (if (seq-step? st)
;;;     (second st)
;;;     (invalid-args-msg "seq-step->st-1" "seq-step?" st)
;;;   )
;;; )

;(seq-step->st-1 (seq-step (left-step 3) (right-step 4)))
;(seq-step->st-2 (seq-step (left-step 3) (right-step 4)))

;(for {a <- '(0 1 2 3)} yield (+ a 42))
;Question 3b
;;; (define (calc)
;;;    (lambda (st vec)
;;;      (if (equal? (car st) 'up-step) (list (first vec) (+ (second vec) (second st)))
;;;         (if (equal? (car st) 'down-step) (list (first vec) (- (second vec) (second st)))
;;;             (if (equal? (car st) 'right-step) (list (+ (first vec) (second st)) (second vec) )
;;;                 (if (equal? (car st) 'left-step) (list (- (first vec) (second st)) (second vec))
;;;                     (invalid-args-msg "move" "step?" st)
;;;                 )
;;;             )
;;;         )
;;;      )  
;;;     ) 
;;; )

;;; (define (move start-p step)
;;;     (if (seq-step? step)
;;;         (rec step start-p)
;;;         (if (step? step) ((calc) step start-p) (invalid-args-msg "move" "step?" step))
;;;     )
;;; )


;;; (define (rec st var)
;;;     (if (null? st)
;;;         var
;;;         (if (seq-step? (car st))
;;;             (rec (cdar st) ((calc) (caar st) var))
;;;             (rec (cdr st) ((calc) (car st) var) )
;;;         )
;;;     )
;;; )

;;; (move '(0 0) (up-step 3))

;;; ;(rec (seq-step (up-step 10) (seq-step (left-step 7) (right-step 4))) '(0 0))
;;; ;(right-step 4)
;;; ;(car (cdr (seq-step (up-step 10) (seq-step (left-step 7) (right-step 4))))
;;; (move '(0 0) (down-step 3))

;;; (move '(0 0) (left-step 3))

;;; (move '(0 0) (right-step 3))

;;; (move '(0 0) (seq-step (up-step 3)(right-step 3)))

;;; ;(rec (seq-step (up-step 3)(right-step 3))'(0 0))
;;; (move '(0 0) (seq-step (up-step 3)(down-step 3)))

;;; (move '(0 0) (seq-step (up-step 10) (seq-step (left-step 7) (right-step 4))))

;Question 4
(define (singleton-set x)
  (lambda (y) (if (equal? x y) #t #f))
)

(define (union s1 s2)
  (lambda (x)
    (if (or (s1 x) (s2 x)) #t #f)
  )
)

(define (intersection s1 s2)
    (lambda (x) 
     (if (and (s1 x) (s2 x)) #t #f)
    )
)

(define (diff s1 s2)
  (lambda (x) 
     (if (and (s1 x) (not (s2 x))) #t #f)
  )
)

(define (filter predicate s)
    (lambda (x)
        (if (predicate x) (s x) #f)
    )
)

;  (ormap (filter predicate s) (range bound))
    ;;;     (letrec 
    ;;;  (
    ;;;      (loop
    ;;;      (lambda (x)
    ;;;         (if (null? x)
    ;;;             #f 
    ;;;             (if (predicate (car x)) 
    ;;;                 (if 
    ;;;                     (s (car x))
    ;;;                     #t
    ;;;                     (loop (cdr x))
    ;;;                 ) 
    ;;;                 (loop (cdr x))
    ;;;             )
    ;;;         )
    ;;;      )
    ;;;      )
     
    ;;;  )
    ;;; (loop (range bound))
    ;;; )
;(ormap (filter predicate s) (range bound))

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
    (loop (range bound))
    )
)     

(define bound 100)

;;; (define s4 (singleton-set 4))
;;; (define s6 (singleton-set 6))
;;; (define s7 (singleton-set 7))
;;; (define test-set (union (union s4 s6) s7))

;;; (exists? prime? test-set)
;;; (exists? string? test-set)

;(andmap (filter string? test-set) (range bound))

;;; (define (all? predicate s)
;;;       (letrec 
;;;      (
;;;          (loop
;;;          (lambda (x)
;;;             (if (null? x)
;;;                 #t
;;;                 (if (and (not (predicate (car x))) (s (car x))) 
;;;                    #f
;;;                     (loop (cdr x))
;;;                 )
;;;             )
;;;          )
;;;          )
     
;;;      )
;;;     (loop (range 1 bound))
;;;     )
;;; )

;;; (define s3 (singleton-set 3))
;;; (define s7 (singleton-set 7))
;;; (define s13 (singleton-set 13))
;;; (define s4 (singleton-set 4))
;;; (define primes (union (union s3 s7) s13))
;;; (define mixed (union primes s4))

;;; (all? prime? primes)
;;; (all? prime? mixed)

;;; (define (map-set op s)
;;;   (lambda (p)
;;;     (letrec 
;;;      (
;;;          (loop
          
;;;             (lambda (x)
;;;                 (if (null? x)
;;;                     #f
;;;                     (if (s (car x))  (if ((singleton-set (op (car x))) p) #t (loop (cdr x))) (loop (cdr x)))

                
;;;                 )
;;;             )
;;;          )
     
;;;      )
;;;     (loop (range bound))
;;;     )
;;;   )

;;; )

;======================
;Question 5
(define steps '(up-step down-step right-step left-step ))
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
(define ex1 'st-1)
(define ex2 'st-2)
(define seq 'seq)
(define (seq-step-proc st-1 st-2)
    (define (prc) st-1 st-2)
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

(define (seq-step-proc? st)
    (if (procedure? (st 'seq)) 
        #t
        #f
    )
)

(define (step-proc? st)
  
  (if (seq-step-proc? st)
    #f
      (if (or 
        (up-step-proc? st)
        (down-step-proc? st)
        (right-step-proc? st)
        (left-step-proc? st)
        
      )
    #t
    #f
  )
  
  )

)

(step-proc? (seq-step-proc (right-step-proc 3) (up-step-proc 4)))

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

(define (seq-step-proc->st-1 st)
    (st ex1)
)

(define (seq-step-proc->st-2 st)
    (st ex2)
)

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
        (if (step-proc? step-proc)
            (calc-proc step-proc vec) 
            (if (step-proc? (seq-step-proc->st-1 step-proc))
                (rec-proc (seq-step-proc->st-2 step-proc) (calc-proc (seq-step-proc->st-1 step-proc) vec))
                "Something"

            )
        )
)


(define (move-proc start-p step-proc)

    (if (seq-step-proc? step-proc)
        (rec-proc step-proc start-p)
        (calc-proc step-proc start-p) 
    )

)


;(move-proc '(0 0) (seq-step-proc (up-step-proc 3)(right-step-proc 3)))
(step-proc? (seq-step-proc (right-step-proc 3) (up-step-proc 4)))