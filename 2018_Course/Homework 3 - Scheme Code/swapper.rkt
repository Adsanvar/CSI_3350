#lang racket
(define swapper
  (lambda (s1 s2 slist)
   (map
    ;proc
    (lambda (exp)

      (if (symbol? exp)

          (if (eqv? exp s1)
                   s2

                   (if (eqv? exp s2)
                       s1 exp)
          )

          (swapper s1 s2 exp)
      ) ;end of proc
   )
         slist) ;intial list
    ))