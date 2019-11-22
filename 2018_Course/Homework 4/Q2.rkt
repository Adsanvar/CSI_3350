#lang eopl

;definition of bintree
(define-datatype bintree bintree?
  (leaf-node
    (num integer?))
  (interior-node
    (key symbol?)
    (left bintree?)
    (right bintree?)))

;takes the max node of the tree and returns the "symbol" of the defined tree
(define (key-of tree)
  (cases bintree tree
    (leaf-node (num) (eopl:error 'key-of "Leaf: ~s" num))
    (interior-node (key left right) key)))

;sums values of bintree
(define (sum tree)
  (cases bintree tree
    (leaf-node (num) num)
    (interior-node (key left right)
      (+ (sum left) (sum right)))))

;does it have an interior?
(define (interior? tree)
  (cases bintree tree
    (leaf-node (num) #f);leaf node must be a number
    (interior-node (key left right) #t)))

;Returns the max node in the tree
(define (max-node tree)
  (cases bintree tree
    (leaf-node (num) #f) ;leaf node must be a number
    (interior-node (key left right)
      (let ((max-leaf (cond ((and (interior? left) (interior? right))
                              (if (< (sum left) (sum right))
                                  right
                                  left))
                             ((and (interior? left)) left)
                             ((and (interior? right)) right)
                             (else #f))))
        (cond ((not max-leaf) tree)
              ((< (sum max-leaf) (sum tree)) tree)
              (else max-leaf))))))

;Entry to program.
(define (max-interior tree)
  (key-of (max-node tree)))
