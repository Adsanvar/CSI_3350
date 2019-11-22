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
     for the problem are still present. Otherwise you may be penalized up to 25%
     of the total points for the homework.
   - you may use any number of helper functions you deem necessary.

When done, make sure that you do not get any errors when you hit the "Run" button. You will
lose up to 25% of the total points for the entire homework depending on the number of errors.
If you cannot come up with a correct solution then please make the answer-sheet
compile correctly and comment any partial solution you might have; if this is the case,
the default definitions will have to be present!

|#
;======================================01=======================================
;((3 + 3) * 9)
;equal to 54
(define (p1-1)
  (* (+ 3 3) 9)
)

;((6 * 9) / ((4 + 2) + (4 * 3)))
;equal to 3
(define (p1-2)
  (/ (* 6 9) (+ (+ 4 2) (* 4 3)))
)

;(2* ((20 - (91 / 7)) * (45 - 42)))
;equal to 42
(define (p1-3)
  (* 2 (* (- 20 (/ 91 7)) (- 45 42)))
)
;======================================02=======================================
;write your answer as a string; you do not need to write any special escape
;characters to distinguish new lines.
(define p2
  "To be simple we'll take the algebraic formula of square = a * a
   To turn that formula into Scheme notation you must first define the formula i.e. (define (square))
   Note that in scheme the first word after every opening parenthesis '(' is a function.
   When we use the algebra expression we are typically implicitly/explicitly given the value of a,
   but in scheme notation we must add a parameter to the function so we can define what is being squared.
   This will result in (define (square a) ). If we call this function as is, scheme will return nothing
   because it does not contain the code to do the squaring. So when doing any arithmetic calculations in
   scheme notation we must put our operators after the '(' because in scheme they are functions 'Prefix'.
   Our example will now look like so: (define (square a) (* a a)). In more complicated algebraic expressions
   YOU MUST ALWAYS put the root of tree on the far left   ^ 'Prefix Tree' i.e. problem 1 question 2, the root 
   of the expression is '/'. The left child has '*' as its root (sub root of '/') and the right child has '+'.
   The right child has now two more childs which have left '+' and right '*' roots. Putting into a clearer
   form 'Prefix Tree':
           /
      *       +
     6 9   +    *
          4 2  4 3
   Then translate into scheme by starting with the root and cascading down:
   (/ (* 6 9) (+ (+ 4 2) (* 4 3)) )
   You'd do the same if you have variables such as x, y, z (as long as the variables are defined somewhere)
   "
)
;======================================03=======================================
;;Write the definitions of x,y,z here:
(define x 2)

(define y 3)

(define z 4)

;======================================04=======================================
;you will need to have solved problem 3. The values x,y,z are not parameters
;of this function!
;Adrian Sandoval-Vargas's note: this will return 0 if any pair of x,y,z contain the same value.
;never the less, it computes what the requirements are. 
(define (p4)
   (cond
    ((and (> x z) (> y z)) (+ x y))
    ((and (> x y) (> z y)) (+ x z))
    ((and (> y x) (> z x)) (+ y z))
    (else 0)
   )
)

;======================================05=======================================
(define (p5)
   (cond
    ((and (< x z) (< y z)) (+ x y))
    ((and (< x y) (< z y)) (+ x z))
    ((and (< y x) (< z x)) (+ y z))
    (else 0)
   )
)

;======================================06=======================================
(define (p6)
  (and (= x y)) 
)

;======================================07=======================================
;same instructions as problem 02.
(define p7
  "1.(define thirty-five 35) => Assignment of 35 to VARIABLE 'thirty-five'. In other words,
   Defining the variable 'thirty-five' to have value 35.
   2.(define (thirty-five) 35) => FUNCTION 'thirty-five' will return 35. In other words,
   when we call '(thirty-five)' it will output 35.
   The major difference is that 1. is a VARIABLE and 2. is a FUNCTION. So when we call them
   its different:
   'thirty-five' will return the value assigned to it.
   '(thirty-five)' will return the value evaluated inside the function."
)

;======================================08=======================================
;same instructions as problem 02.
(define p8
  " ' (quote) is Scheme's representation of a LITERAL expression. That being said,
   It is an escape character that coverts any expression into a literal (list) format no matter the type.
   "
)

;======================================09=======================================
;same instructions as problem 02.
(define p9
  "The difference between list and ' (quote) is:
   ' : Is literal so '(+ 5 6) => '(+ 5 6). No computation is done on the characters proceeding the '.
   list : Generates a list of the parameters given.
          (list '(+ 5 6) 'is (+ 5 6) ) => '((+ 5 6) is 11)
          list takes in literals, variables, and other functions computes them and returns the
          final evalution."
)

;======================================10=======================================
;same instructions as problem 02.
(define p10
  "We can determine the length of a string. We can also pick out a character at an index of the string
   (as long as it is within range of a zero-indexed string).
   There is a distinction between Symbols and Strings becasue symbols are the object representation of
   the string i.e 'hello can be considered an object of a string if we do
   (symbol->string 'hello) => ''hello'' if we do (string->symbol ''hello'') => 'hello .
   This can be seen by:
   (list ''hello'' 'hi) => '(''hello'' hi) where the output (in the command) is a symbol of the list
   containing string ''hello'' and symbol hi. It is important to know this distinction because if we
   just see characters together we cannot automatically assume it is a string."
)

;======================================11=======================================
;(4 2 6 9)
(define (p11-1)
  (list 4 2 6 9)
)

;(spaceship
;  (name(serenity))
;  (class(firefly)))
(define (p11-2)
  (list 'spaceship (list 'name (list 'serenity)) (list 'class (list 'firefly)))
)

;(2 * ((20 - (91 / 7)) * (45 - 42)))
(define (p11-3)
  (list 2 '* (list (list 20 '- (list 91 '/ 7)) '* (list 45 '- 42)))
)

;======================================12=======================================
(define example '(a b c))

;(d a b c)
(define (p12-1 lst)
  (cons 'd lst)
)

;(a b d a b)
(define (p12-2 lst)
  (append (reverse (cdr (reverse lst))) (append '(d) (reverse (cdr (reverse lst)))))
)

;(b c d a)
(define (p12-3 lst)
  (append (cdr lst) (cons 'd (list (car lst))))
)


;======================================13=======================================
(define p13
  "eq? : equates objects by reference. For example using x from current homework:
         (eq? x 2) => #t, (eq? x '2) => #t, but (eq? x '(2)) => #f.
         As you can see x and '(2) are different data types and thus different
         objects so eq? => #f.
   What if:
   (define lst1 (list 1))
   (define lst2 (list 1))
   Same data types same value inside data types.
         (eq? lst1 lst2) => #f,
         As you can see they are two different objects with different references.
   equal? : equates the contents. Using lst1 and lst2 as define above:
            (equal? lst1 lst2) => #t. Although they are different objects, the
            lists have the same value inside.
   In summary, eq? takes in the references of the objects and equates them where as
   equal? ignores the references and equates the value inside the object."
)
; write your answer as a string; you do not need to write any special escape
; characters to distinguish new lines.


;======================================14=======================================
(define (create-error-msg sym val)
  (define p1 "This is a custom error message we will be using next. Symbol '")
    (define p2 " was not paired with value ")
    (string-append p1 (symbol->string sym) p2 (number->string val))
)
;======================================15=======================================
(define (check-correctness pair)
 (if
   (equal? (car pair) 'answer-to-everything)
   
   (if
    (equal? (cadr pair) 42)
     #t
    (create-error-msg (car pair) 42)  )
   
   #f)
)

;======================================16=======================================
;No answer necessary - just experiment it as instructed in hw01.pdf file

