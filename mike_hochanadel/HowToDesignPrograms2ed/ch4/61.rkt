;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |61|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")
 
; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-numeric RED) GREEN)
(check-expect (tl-next-numeric YELLOW) RED)
(check-expect (tl-next-numeric GREEN) YELLOW)
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic YELLOW) RED)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; The symbolic one all the way as it is more flexible and doesn't rely
; on the integer math for coming up with the next value.  The symbolic
; one also directly calls back to the original data definition which
; also makes it cleaner to read and interpret.