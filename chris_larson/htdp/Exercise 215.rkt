;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 215|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 600)
(define WIDTH 600)
(define STEP 15)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define DOT (circle STEP "solid" "red"))

; WorldState: data that represents the state of the world (cw)
; POSN p, Direction d
(define-struct WorldState [p d])

; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render cw)
  (place-image DOT (posn-x (WorldState-p cw)) (posn-y (WorldState-p cw)) BACKGROUND))
 
; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw)
  (cond
    [(string=? (WorldState-d cw) "down") (make-WorldState (make-posn (posn-x (WorldState-p cw)) (+ (posn-y (WorldState-p cw)) STEP)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "up") (make-WorldState (make-posn (posn-x (WorldState-p cw)) (- (posn-y (WorldState-p cw)) STEP)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "right") (make-WorldState (make-posn (posn-x (WorldState-p cw)) (+ (posn-y (WorldState-p cw)) STEP)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "left") (make-WorldState (make-posn (- (posn-x (WorldState-p cw)) STEP) (posn-y (WorldState-p cw))) (WorldState-d cw))]
    [else (make-WorldState (make-posn (+ (posn-x (WorldState-p cw)) STEP) (posn-y (WorldState-p cw))) (WorldState-d cw))]))
 
; WorldState String -> WorldState 
; for each keystroke, big-bang obtains the next state 
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke)
    (cond
      [(key=? ke "up") (make-WorldState (WorldState-p cw) "up")]
      [(key=? ke "down") (make-WorldState (WorldState-p cw) "down")]
      [(key=? ke "right") (make-WorldState (WorldState-p cw) "right")]
      [(key=? ke "left") (make-WorldState (WorldState-p cw) "left")]
      [else cw]))
 
; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
(define (end? cw)
  (cond
    [(> (posn-x (WorldState-p cw)) WIDTH) #true]
    [(< (posn-x (WorldState-p cw)) 0) #true]
    [(> (posn-y (WorldState-p cw)) HEIGHT) #true]
    [(< (posn-x (WorldState-p cw)) 0) #true]
    [else #false]))
    

(define (main y)
  (big-bang y
    [on-tick clock-tick-handler 1]
    [stop-when end?]
    [to-draw render]
    [on-key keystroke-handler]))

; (main (make-WorldState (make-posn 300 300) ""))