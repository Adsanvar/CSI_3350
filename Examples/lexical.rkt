#lang racket
(#%require (lib "eopl.ss" "eopl"))

(define lexical-spec
  '(
    (whitespace (whitespace) skip)
    (comments (";" (arbno (not #\newline))) skip)
    (num ((or "-""+") digit (arbno digit)) number)) ;number has plus or minus with arbituary digit - token called number
    (identifier (letter (arbno (or letter digit "_" "-" "?")  ) ; 
  )

;how to allow number like +23 and - 23
;how to define identifier token?

(define grammar-spec
  '(
    (program (step) a-program)
    (step ("left" num) left-step)
    (step ("right" num) right-step)))