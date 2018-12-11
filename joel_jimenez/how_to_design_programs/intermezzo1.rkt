;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intermezzo1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 116
; 1. x is a name
; 2. (= y z) is an expression
; 3. (= (= y z) 0) is a nested expression

; Exercise 117
; 1. (3 + 4) ; primitive must come first instide paranthesis
; 2. number? ; requires paranthesis and a variable
; 3. (x) ; Name cannot come first instide paranthesis

; Exercise 118.
; 1. (define (f x) x) ; def
; 2. (define (f x) y) ; def
; 3. (define (f x y) 3) ; def

; Exercise 119.
; 1. (define (f "x") x) ; value cannot be used as name on variable
; 2. (define (f x y z) (x)) ; name cannot come first instide paranthesis

; Exercise 120. Discriminate the legal from the illegal sentences:
; 1. (x) ; Illegal expression, name cannot come first instide paranthesis
; 2. (+ 1 (not x)) legal expression
; 3. (+ 1 2 3) legal expression
