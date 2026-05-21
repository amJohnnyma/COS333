#lang racket

(define sumAbsNegativeFracPositivesCountZeros
  (lambda (lst)
    (if (null? lst) ; check if list is empty
        0 ; if empty return 0
        (let ((val (car lst))) ; get the first item
          (+ (cond ; start transofmr
               ((zero? val) 1) ; rule: 0-> 1
               ((positive? val) (/ 1.0 val)) ; rule : pos -> 1/val
               ((negative? val) (abs val)) ; rule : neg = abs
               (else 0))
             (sumAbsNegativeFracPositivesCountZeros (cdr lst))))))) ; recurse


(sumAbsNegativeFracPositivesCountZeros '())
(sumAbsNegativeFracPositivesCountZeros '(2 4))
(sumAbsNegativeFracPositivesCountZeros '(-2 -4))
(sumAbsNegativeFracPositivesCountZeros '(0 2 -4))