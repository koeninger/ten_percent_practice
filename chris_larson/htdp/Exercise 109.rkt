;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 109|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define SCENE (empty-scene 100 100))

; AnimationState String -> AnimationState
; for each keystroke, big-bang obtains the next state
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler as ke)
  (cond
    [(string=? AA as)
     (cond
       [(key=? ke "a") BB]
       [else ER])]
    [(string=? BB as)
     (cond
       [(key=? ke "d") DD]
       [(key=? ke "b") BB]
       [(key=? ke "c") BB]
       [else ER])]
    [else ER]))
(check-expect (keystroke-handler AA "a") BB)
(check-expect (keystroke-handler AA "b") ER)
(check-expect (keystroke-handler BB "a") ER)
(check-expect (keystroke-handler BB "b") BB)
(check-expect (keystroke-handler BB "c") BB)
(check-expect (keystroke-handler BB "d") DD)
(check-expect (keystroke-handler BB "e") ER)

(define (tock as)
  as)

(define (render as)
  (cond
    [(string=? AA as) (place-image (square 50 "solid" "white") 50 50 SCENE)]
    [(string=? BB as) (place-image (square 50 "solid" "yellow") 50 50 SCENE)]
    [(string=? DD as) (place-image (square 50 "solid" "green") 50 50 SCENE)]
    [else (place-image (square 50 "solid" "red") 50 50 SCENE)]))

; State -> Bool
; stop when state is DD or ER
(define (end? as)
     (cond
       [(string=? DD as) #true]
       [(string=? ER as) #true]
       [else #false]))
(check-expect (end? DD) #true)
(check-expect (end? ER) #true)
(check-expect (end? AA) #false)
(check-expect (end? BB) #false)

; AnimationState -> AnimationState
; launches the program from some initial state
(define (main as)
  (big-bang as
    [on-tick tock]
    [on-key keystroke-handler]
    [to-draw render]))