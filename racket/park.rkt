#lang racket





(module* zoo racket
  (module zooo racket
    (provide tigerr)
    (define tigerr "Tonyy"))

  (require 'zooo)
  (provide tiger)
  (define tiger "Tony")
  tigerr)

(require 'zoo)
 


 
