#lang racket

(define atom?
  (λ (m)
    (and
     (not (pair? m))
     (not (null? m)))
    ))

