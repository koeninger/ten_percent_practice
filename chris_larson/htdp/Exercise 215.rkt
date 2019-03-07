;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 215|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 600)
(define WIDTH 600)
(define STEP 15)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define DOT (circle STEP "solid" "red"))

; WorldState: data that represents the state of the world (cw)
 
; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render ws)
  (place-image DOT (posn-x ws) (posn-y ws) BACKGROUND))
 
; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw) cw)
 
; WorldState String -> WorldState 
; for each keystroke, big-bang obtains the next state 
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke)
    (cond
      [(key=? ke "up") (make-posn (posn-x cw) (+ (posn-y cw) STEP))]
      [(key=? ke "down") (make-posn (posn-x cw) (- (posn-y cw) STEP))]
      [(key=? ke "right") (make-posn (- (posn-x cw) STEP) (posn-y cw))]
      [(key=? ke "left") (make-posn (+ (posn-x cw) STEP) (posn-y cw))]
      [else cw]))
 
; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
(define (end? cw)
  (cond
    [(> (posn-x cw) WIDTH) #true]
    [(< (posn-x cw) 0) #true]
    [(> (posn-y cw) HEIGHT) #true]
    [(< (posn-x cw) 0) #true]
    [else #false]))
    

(define (main y)
  (big-bang y
    [on-tick clock-tick-handler]
    [stop-when end?]
    [to-draw render]
    [on-key keystroke-handler]))