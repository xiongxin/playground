#lang typed/racket

(define-type-alias BT (U mt node))
(struct mt ())
(struct node ([v : Number] [l : BT] [r : BT]))


(define (size-tr [t : BT]) : Number
  (cond
    [(mt? t) 0]
    [(node? t) (+ 1 (size-tr (node-l t)) (size-tr (node-r t)))]))