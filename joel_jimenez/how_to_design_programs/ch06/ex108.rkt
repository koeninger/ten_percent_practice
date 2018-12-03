;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |ex108|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Timer is a number from 0 to 20

(define SIZE 100)
(define BACKGROUND
  (rectangle SIZE SIZE "solid" "black"))
(define STOP
  (regular-polygon (/ SIZE 3) 8 "solid" "red"))
(define GO
  (triangle (* SIZE .8) "solid" "green"))

; Timer -> Image
; renders image on background based on Timer value
(check-expect (render 0) (overlay STOP BACKGROUND))
(check-expect (render 20) (overlay GO BACKGROUND))
(check-expect (render 10) (overlay GO BACKGROUND))
(check-expect (render 5) (overlay (text "5" SIZE "orange") BACKGROUND))
(check-expect (render 2) (overlay (text "2" SIZE "green") BACKGROUND))
(define (render t)
  (overlay (cond
    [(<= t 0) STOP]
    [(>= t 10) GO]
    [else (text (number->string t) SIZE (if (odd? t) "orange" "green"))])
    BACKGROUND))

; Timer, KeyEvent -> Timer
; switches from its default state when you press the space bar on your keyboard
(check-expect (press 0 " ") 20)
(check-expect (press 1 " ") 1)
(check-expect (press 0 "x") 0)
(check-expect (press 10 "x") 10)
(define (press t ke)
  (cond
    [(and (= t 0) ( key=? ke " ")) 20]
    [else t]))

; Timer -> Timer
; counts down to zero
(check-expect (tock 0) 0)
(check-expect (tock 1) 0)
(check-expect (tock 20) 19)
(define (tock t)
  (cond
    [(> t 0) (- t 1)]
    [else 0]))

(define (crossing-light timer)
  (big-bang timer
    [on-tick tock 1]
    [on-key press]
    [to-draw render]))
(crossing-light 0)
