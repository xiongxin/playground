#lang racket
 
(define amount/c
  (and/c number? integer? exact? (or/c positive? zero?)))
 
(provide (contract-out
          [deposit (-> amount/c any)]
          [balance (-> amount/c)]))