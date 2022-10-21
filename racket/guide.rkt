#lang racket

(define (reply-non-string s)
  (if (string? s)
      (if (string-prefix? s "hello ")
          "hi"
          "huh?")
      "huh?"))


(define (reply-more s)
  (cond
    [(string-prefix? s "hello ") "hi!"]
    [(string-prefix? s "goodbye ") "bye!"]
    [(string-suffix? s "?") "I don't know"]
    [else "hub?"]))

(define (double v)
  ((if (string? v) string-append +) v v))

(define (converse s)
  (define (starts? s2) ; local to converse
    (define spaced-s2 (string-append s2 " ")); local to starts
    (string-prefix? s spaced-s2))
  (cond
    [(starts? "hello") "hi!"]
    [(starts? "goodbye") "bye!"]
    [else "hun?"]))


(let* ([x (random 4)]
       [o (random 4)]
       [diff (number->string (abs (- x o)))])
  (cond
    [(> x o) (string-append "X wins by " diff)]
    [(> o x) (string-append "O wins by " diff)]
    [else "cat's game"]))

(map (λ (i)
       (string-append i "!"))
     (list "a" "b" "c"))

(map (λ (s n) (substring s 0 n))
     (list "peanuts" "popcorn" "crackerjack")
     (list 6 3 7))

(foldl (λ (elem v)
         (+ v (* elem elem)))
       0
       '(1 2 3))


(define (mymap f l)
  (cond
    [(empty? l) empty]
    [else (cons (f (first l))
                (mymap f (rest l)))]))

(define (my-map f lst)
  (for/list ([i lst])
    (f i)))

(define (remove-dup l)
  (cond
    [(empty? l) empty]
    [(empty? (rest l)) l]
    [else (let ([i (first l)])
            (if (eq? i (first (rest l)))
                (remove-dup (rest l))
                (cons i (remove-dup (rest l)))))]))
