#lang racket

(define (coneVolume r h)
  (cond
    ((<= r 0) 0)
    ((<= h 0) 0)
    (else
     (let ((pi (/ 22 7)))
       (* (/ 1 3) pi r r h)))))

; Tests
(coneVolume 1.5 2.1)   ; expect ~4.95
(coneVolume 0 5)       ; expect 0
(coneVolume 3 0)       ; expect 0
(coneVolume -1 5)      ; expect 0
(coneVolume 3 -2)      ; expect 0
(coneVolume 7 3)       ; expect 154


(define (countNonZeroValues lst)
  (cond
    ((null? lst) 0)
    ((= (car lst) 0)
     (countNonZeroValues (cdr lst)))
    (else
     (+ 1 (countNonZeroValues (cdr lst))))))

; Tests
(countNonZeroValues '())          ; expect 0
(countNonZeroValues '(0 0))       ; expect 0
(countNonZeroValues '(3 0 -8 0))  ; expect 2
(countNonZeroValues '(1 2 3))     ; expect 3
(countNonZeroValues '(0))         ; expect 0
(countNonZeroValues '(-5))        ; expect 1

(define (getSecondElements lst)
  (cond
    ((null? lst) '())
    ((null? (cdr lst)) '())
    (else
     (cons (car (cdr lst)) (getSecondElements (cdr (cdr lst)))))))

(define (doubleAll lst)
  (cond
    ((null? lst) '())
    (else
     (cons (* 2 (car lst)) (doubleAll (cdr lst))))))

(define (doubleEverySecondElement lst)
  (doubleAll (getSecondElements lst)))

; Tests
(doubleEverySecondElement '())          ; expect ()
(doubleEverySecondElement '(4))         ; expect ()
(doubleEverySecondElement '(4 6))       ; expect (12)
(doubleEverySecondElement '(4 6 8))     ; expect (12)
(doubleEverySecondElement '(4 6 8 10))  ; expect (12 20)
(doubleEverySecondElement '(4 6 2 3))   ; expect (12 6)