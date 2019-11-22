#lang racket

(define (invalid-args-msg step cause data)
    (define p1 "Invalid arguments in: ")
    (define p2 " --- expected: ")
    (define p3 " --- received: ")
    (string-append p1 step p2 cause p3 data)
)


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
;this code works in my environment without running tests.rtk
;ie: (move-proc '(0 0) (seq-step-proc (up-step-proc 10) (seq-step-proc (left-step-proc 7) (right-step-proc 4))))
;returns '(-3 10) but idk why it fails with tests.rtk But it says it passes the test...

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



;;; (define (rec-proc2 step-proc vec)

;;;     (if (seq-step-proc? (seq-step-proc->st-2 step-proc))

;;;         (calc-proc (seq-step-proc->st-2 (seq-step-proc->st-2 step-proc))   (calc-proc (seq-step-proc->st-1 (seq-step-proc->st-2 step-proc))  (calc-proc (seq-step-proc->st-1 step-proc) vec)))

;;;        (calc-proc (seq-step-proc->st-2 step-proc) (calc-proc (seq-step-proc->st-1 step-proc) vec))
;;;     )

;;; )

;(calc-proc (seq-step-proc->st-1 (seq-step-proc (up-step-proc 3)(right-step-proc 3))) '(0 0))

;(seq-step-proc? (seq-step-proc->st-2 (seq-step-proc (up-step-proc 3)(right-step-proc 3))))
(move-proc '(0 0) (seq-step-proc (up-step-proc 3)(right-step-proc 3)))
(move-proc '(0 0) (seq-step-proc (up-step-proc 10) (seq-step-proc (left-step-proc 7) (right-step-proc 4))))