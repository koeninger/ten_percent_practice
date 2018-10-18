;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

;(define RED "red")
;(define GREEN "green")
;(define YELLOW "yellow")


; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
    
(check-expect (tl-next-numeric RED) GREEN)
(check-expect (tl-next-numeric YELLOW) RED)
(check-expect (tl-next-numeric GREEN) YELLOW)
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))


(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic YELLOW) RED)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; Which of the two is properly designed using the recipe for itemization?
; tl-next-symbolic. It properly itemizes each state into a line of cond.

; Which of the two continues to work if you change the constants to the following..
; tl-next-symbolic. tl-next-numeric depends specifically on numbers as states,
; whereas symbolic can take an arbitrary representation of state, so long as it can be compared
; using equal?