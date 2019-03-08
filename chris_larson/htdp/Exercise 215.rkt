;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 215|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 600)
(define WIDTH 600)
(define STEP 15)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define DOT (circle (/ STEP 2) "solid" "red"))

; WorldState: data that represents the state of the world (cw)
; Worm p, Direction d
(define-struct WorldState [p d])

; a worm is one of:
; - '()
; - (cons posn worm)

; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render cw)
  (render-worm (WorldState-p cw) BACKGROUND))

; List-of-posn -> Image
; places dots at list-of-posn
(define (render-worm lop image)
  (cond
    [(empty? lop) image]
    [else (place-image DOT (posn-x (first lop)) (posn-y (first lop)) (render-worm (rest lop) image))]))
  
(define (game-over-render cw)
  (place-image (text "worm hit border" 24 "orange")  120 (- HEIGHT 50) (render-worm (WorldState-p cw) BACKGROUND)))

; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw)
  (cond
    [(string=? (WorldState-d cw) "down") (make-WorldState (pop-push (make-posn (posn-x (first (WorldState-p cw))) (+ (posn-y (first (WorldState-p cw))) STEP)) (WorldState-p cw)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "up") (make-WorldState (pop-push (make-posn (posn-x (first (WorldState-p cw))) (- (posn-y (first (WorldState-p cw))) STEP)) (WorldState-p cw)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "right") (make-WorldState (pop-push (make-posn (+ (posn-x (first (WorldState-p cw))) STEP) (posn-y (first (WorldState-p cw)))) (WorldState-p cw)) (WorldState-d cw))]
    [(string=? (WorldState-d cw) "left") (make-WorldState (pop-push (make-posn (- (posn-x (first (WorldState-p cw))) STEP) (posn-y (first (WorldState-p cw)))) (WorldState-p cw)) (WorldState-d cw))]
    [else (make-WorldState (pop-push (make-posn (+ (posn-x (first (WorldState-p cw))) STEP) (posn-y (first (WorldState-p cw)))) (WorldState-p cw)) "right")]))
(check-expect (clock-tick-handler (make-WorldState (list (make-posn 300 300)) "")) (make-WorldState (list (make-posn (+ STEP 300) 300)) "right"))
(check-expect (clock-tick-handler (make-WorldState (list (make-posn 300 300)) "right")) (make-WorldState (list (make-posn (+ STEP 300) 300)) "right"))
(check-expect (clock-tick-handler (make-WorldState (list (make-posn 300 300)) "down")) (make-WorldState (list (make-posn 300 (+ STEP 300))) "down"))
(check-expect (clock-tick-handler (make-WorldState (list (make-posn 300 300)) "up")) (make-WorldState (list (make-posn 300 (- 300 STEP))) "up"))
(check-expect (clock-tick-handler (make-WorldState (list (make-posn 300 300)) "left")) (make-WorldState (list (make-posn (- 300 STEP) 300)) "left"))

; List-of-posn posn -> List-of-posn
(define (pop-push p lop)
  (cons p (pop lop)))
(check-expect (pop-push 6 (list 1 2 3 4 5)) (list 6 1 2 3 4))

; List-of-posn posn -> List-of-posn
(define (pop lop)
  (cond
    [(empty? (rest lop)) '()]
    [else (cons (first lop) (pop (rest lop)))]))
(check-expect (pop (list 1 2 3 4 5)) (list 1 2 3 4))


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
    [(> (posn-x (first (WorldState-p cw))) WIDTH) #true]
    [(< (posn-x (first (WorldState-p cw))) 0) #true]
    [(> (posn-y (first (WorldState-p cw))) HEIGHT) #true]
    [(< (posn-y (first (WorldState-p cw))) 0) #true]
    [else #false]))
(check-expect (end? (make-WorldState (list (make-posn (- WIDTH STEP) (- HEIGHT STEP))) "")) #false)  
(check-expect (end? (make-WorldState (list (make-posn (+ WIDTH STEP) (- HEIGHT STEP))) "")) #true)
(check-expect (end? (make-WorldState (list (make-posn (- WIDTH STEP) (+ HEIGHT STEP))) "")) #true)
(check-expect (end? (make-WorldState (list (make-posn 0 0)) "")) #false)
(check-expect (end? (make-WorldState (list (make-posn (- WIDTH STEP) (- 0 STEP))) "")) #true)
(check-expect (end? (make-WorldState (list (make-posn (- 0 STEP) (- HEIGHT STEP))) "")) #true)

(define (main y)
  (big-bang y
    [on-tick clock-tick-handler 1]
    [stop-when end? game-over-render]
    [to-draw render]
    [on-key keystroke-handler]))

; (main (make-WorldState (cons (make-posn 300 300) (cons (make-posn 285 300) (cons (make-posn 270 300 '()))) ""))
; (main (make-WorldState (cons (make-posn 500 300)'()) ""))