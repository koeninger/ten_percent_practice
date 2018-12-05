;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; ExpectsToSee is one of:
; – AA
; – BB
; – DD
; – ER 

(define AA "Start, ...")
(define BB "Expect ...")
(define DD "Finished.")
(define ER "Error!")
(define SIZE 100)

; ExpectsToSee -> Image
; renders a rectangle based on the state
(check-expect (render AA) (rectangle SIZE SIZE "solid" "white"))
(check-expect (render BB) (rectangle SIZE SIZE "solid" "yellow"))
(check-expect (render DD) (rectangle SIZE SIZE "solid" "green"))
(check-expect (render ER) (rectangle SIZE SIZE "solid" "red"))
(define (render s)
  (rectangle SIZE SIZE "solid" (cond
    [(eq? s AA) "white"]
    [(eq? s BB) "yellow"]
    [(eq? s DD) "green"]
    [(eq? s ER) "red"])))

; ExpectsToSee, KeyEvent -> ExpectsToSee
; renders a rectangle based on the state
(check-expect (press AA "a") BB)
(check-expect (press AA " ") ER)
(check-expect (press BB "b") BB)
(check-expect (press BB "c") BB)
(check-expect (press BB "d") DD)
(check-expect (press BB " ") ER)
(define (press s ke)
  (cond
    [(eq? s AA)(cond
       [(key=? ke "a") BB]
       [else ER])]
    [(eq? s BB)(cond
       [(key=? ke "b") BB]
       [(key=? ke "c") BB]
       [(key=? ke "d") DD]
       [else ER])]))

; ExpectsToSee -> Boolean
; ends program if state reaches DD or ER
(check-expect (end? AA) #false)
(check-expect (end? DD) #true)
(check-expect (end? ER) #true)
(define (end? s)
  (or (eq? s DD) (eq? s ER)))

(define (fms state)
  (big-bang state
    [to-draw render]
    [on-key press]
    [stop-when end? render]))

(fms AA)
