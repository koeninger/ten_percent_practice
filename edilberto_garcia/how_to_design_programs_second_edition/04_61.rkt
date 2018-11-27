;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 61. As From Functions to Programs says, programs must define constants
;    and use names instead of actual constants. In this spirit, a data definition
;    for traffic lights must use constants, too:

(define RED 0)
(define GREEN 1)
(define YELLOW 2)
 
; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW



;Figure 27 displays two different functions that switch the state of a traffic light
;    in a simulation program. Which of the two is properly designed using the recipe
;    for itemization? Which of the two continues to work if you change the constants
;    to the following

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; Does this help you answer the questions?


; Ans: The second definition, using the constants rather than the numbers will keep working.
