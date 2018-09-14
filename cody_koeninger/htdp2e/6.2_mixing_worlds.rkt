;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.2_mixing_worlds) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; states in FSM
(define AA "start, expect a")
(define BB "expect b c or d")
(define DD "finish")
(define ER "error")

; fsm -> key -> fsm
(check-expect (transition AA "a") BB)
(check-expect (transition AA " ") ER)
(check-expect (transition BB "b") BB)
(check-expect (transition BB "c") BB)
(check-expect (transition BB "d") DD)
(check-expect (transition BB " ") ER)
(define (transition f k)
  (cond
    [(eq? f AA)
     (cond
       [(key=? "a" k) BB]
       [else ER])]
    [(eq? f BB)
     (cond
       [(key=? "b" k) BB]
       [(key=? "c" k) BB]
       [(key=? "d" k) DD]
       [else ER])]
    [(eq? f DD) DD]
    [(eq? f ER) ER]))

; fsm -> image
(define (render f)
  (rectangle 100 100 "solid"
             (cond
               [(eq? f AA) "white"]
               [(eq? f BB) "yellow"]
               [(eq? f DD) "green"]
               [(eq? f ER) "red"])))

(define (main f)
  (big-bang f
    (on-key transition)
    (to-draw render)))