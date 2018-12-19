;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 115|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given some other value")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
 
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
 
(define (light=? a-value another-value)
  (cond
    [(not (light? a-value)) (error "traffic light expected, first value is some other value")]
    [(not (light? another-value)) (error "traffic light expected, second value is some other value")]
    [(string=? a-value another-value) #true]
    [else #false]))

x
; a variable

(= y z)
; (primitive variable variable)

(= (= y z) 0)
; (primitive expr value)

(3 + 4)
; (value primitive value) is not an expr

number?
; primitive requires an expr

(x)
; (variable expr) requires an expr

(define (f x) x)
; (primitive (variable variable) variable)

(define (f x) y)
; (primitive (variable variable) variable)

(define (f x y) 3)
; (primitive (variable variable variable) value)

(define (f "x") x)
; define requires only variables in the parens

(define (f x y z) (x))
; (variable) is illegal

(x)
; illegal - (variable expr) requires an expr

(+ 1 (not x))
; legal (primitive value expr), but will throw error

(+ 1 2 3)
; legal (primitive value value value)