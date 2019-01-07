;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; ExpectsToSee is one of:
; AA - expect an "a" (start)
; BB - expect "b", "c", or "d"
; DD - finished
; ER - error (illegal key)

(define AA "start, expect a")
(define BB "expect b | c")
(define DD "finished")
(define ER "error")

(define SQR-DIM 100)

; ExpectsToSee -> Image
; renders a 100 x 100 square, color based on current state:
; AA - white
; BB - yellow
; DD - green
; ER - red
(check-expect (render AA) (square SQR-DIM "solid" "white"))
(check-expect (render BB) (square SQR-DIM "solid" "yellow"))
(check-expect (render DD) (square SQR-DIM "solid" "green"))
(check-expect (render ER) (square SQR-DIM "solid" "red"))
(define (render s)
  (cond
    [(equal? AA s) (square SQR-DIM "solid" "white")]
    [(equal? BB s) (square SQR-DIM "solid" "yellow")]
    [(equal? DD s) (square SQR-DIM "solid" "green")]
    [else (square SQR-DIM "solid" "red")]))


; ExpectsToSee -> ExpectsToSee
; given a state and a key input, compute next state
; AA: "a" -> BB
;    else -> ER
; BB: "b" -> BB
;     "c" -> BB
;     "d" -> DD
;    else -> ER
; DD: stay (return DD)
; ER: stay (return ER)
(check-expect (key-handler AA "a") BB)
(check-expect (key-handler AA "b") ER)
(check-expect (key-handler AA "c") ER)
(check-expect (key-handler AA "d") ER)
(check-expect (key-handler BB "a") ER)
(check-expect (key-handler BB "b") BB)
(check-expect (key-handler BB "c") BB)
(check-expect (key-handler BB "d") DD)
(check-expect (key-handler BB "e") ER)
(check-expect (key-handler DD "a") DD)
(check-expect (key-handler DD "b") DD)
(check-expect (key-handler ER "a") ER)
(check-expect (key-handler ER "b") ER)
(define (key-handler s key)
  (cond
    [(equal? AA s)
     (cond
       [(key=? "a" key) BB]
       [else ER])]
    [(equal? BB s)
     (cond
       [(key=? "b" key) BB]
       [(key=? "c" key) BB]
       [(key=? "d" key) DD]
       [else ER])]
    [else s]))

(define (main s)
  (big-bang s
    [to-draw render]
    [on-key key-handler]))