;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex115) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Any -> Boolean
; is the given value an element of TrafficLight
(check-expect (light? "red") #true)
(check-expect (light? "green") #true)
(check-expect (light? "yellow") #true)
(check-expect (light? "test") #false)
(check-expect (light? 1) #false)
(define (light? x)
  (and (string? x)
       (or (string=? "red" x)
           (string=? "green" x)
           (string=? "yellow" x))))


(define (MESSAGE value)
  (string-append "traffic light expected, given " value))

; Any Any -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? "blue" "yellow") "traffic light expected, given blue")
(check-error (light=? "red" "orange") "traffic light expected, given orange")

(define (light=? a-value another-value)
  (cond
    [(not (light? a-value)) (error (MESSAGE a-value))]
    [(not (light? another-value)) (error (MESSAGE another-value))]
    [else (string=? a-value another-value)]))
