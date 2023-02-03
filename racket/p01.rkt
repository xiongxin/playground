#lang racket

(require "cake.rkt")
(require (submod "cake.rkt" extras))

(print-cake (random 30))

(show "  ~a   " 10 #\])