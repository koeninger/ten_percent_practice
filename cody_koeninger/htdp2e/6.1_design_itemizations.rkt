;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.1_design_itemizations) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

(define WORLD-WIDTH 320)
(define WORLD-HEIGHT 240)
(define BACKGROUND
  (empty-scene WORLD-WIDTH WORLD-HEIGHT))
(define TANK-WIDTH (/ WORLD-WIDTH 8))
(define TANK-HEIGHT (/ WORLD-HEIGHT 12))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "blue"))
(define UFO-WIDTH (/ WORLD-WIDTH 12))
(define UFO-HEIGHT (/ WORLD-HEIGHT 16))
(define UFO (ellipse UFO-WIDTH UFO-HEIGHT "solid" "green"))
(define MISSLE (triangle (/ WORLD-WIDTH 20) "solid" "red"))
(define INITIAL-TANK-POSN (make-posn (/ WORLD-WIDTH 2) (- WORLD-HEIGHT TANK-HEIGHT)))
(define INITIAL-UFO-POSN (make-posn (/ WORLD-WIDTH 2) UFO-HEIGHT))
(define COLLISION-PROXIMITY (/ UFO-WIDTH 2))
(define MOVE-PER-TICK 4)

(define INITIAL-SCENE
  (place-images
   (list UFO
         TANK)
   (list INITIAL-UFO-POSN
         INITIAL-TANK-POSN)
   BACKGROUND))


(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; (make-aim (make-posn 20 10) (make-tank 28 -3))
(define EXAMPLE-96-A
    (place-images
     (list UFO
           TANK)
     (list (make-posn 20 10)
           (make-posn 28 (posn-y INITIAL-TANK-POSN)))
     BACKGROUND))

;(make-fired (make-posn 20 10)
;            (make-tank 28 -3)
;            (make-posn 28 (- HEIGHT TANK-HEIGHT)))
(define EXAMPLE-96-B
  (place-images
   (list UFO
         TANK
         MISSLE)
   (list (make-posn 20 10)
         (make-posn 28 (posn-y INITIAL-TANK-POSN))
         (make-posn 28 (- WORLD-HEIGHT TANK-HEIGHT 10)))
   BACKGROUND))

;(make-fired (make-posn 20 100)
;            (make-tank 100 3)
;            (make-posn 22 103))
(define EXAMPLE-96-C
  (place-images
   (list UFO
         TANK
         MISSLE)
   (list (make-posn 20 100)
         (make-posn 100 (posn-y INITIAL-TANK-POSN))
         (make-posn 22 103))
   BACKGROUND))

(define INITIAL-STATE (make-aim INITIAL-UFO-POSN (make-tank (posn-y INITIAL-TANK-POSN) 0)))

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BACKGROUND)))]))

; Tank Image -> Image 
; adds t to the given image im
(check-expect (tank-render (make-tank 100 3) BACKGROUND)
              (place-image TANK 100 (posn-y INITIAL-TANK-POSN) BACKGROUND))
(define (tank-render t im)
  (place-image TANK (tank-loc t) (posn-y INITIAL-TANK-POSN) im))
 
; UFO Image -> Image 
; adds u to the given image im
(check-expect (ufo-render (make-posn 10 20) BACKGROUND)
              (place-image UFO 10 20 BACKGROUND))
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; Missile Image -> Image 
; adds m to the given image im
(check-expect (missile-render (make-posn 20 40) BACKGROUND)
              (place-image MISSLE 20 40 BACKGROUND))
(define (missile-render m im)
  (place-image MISSLE (posn-x m) (posn-y m) im))


; SIGS -> Boolean
; stops if the UFO lands or collides with missle
(check-expect (si-game-over? (make-aim (make-posn 0 0) (make-tank 100 3))) false)
(check-expect (si-game-over? (make-aim (make-posn 0 WORLD-HEIGHT) (make-tank 100 3))) true)
(check-expect (si-game-over? (make-fired (make-posn 0 0) (make-tank 100 3) (make-posn 0 COLLISION-PROXIMITY))) true)
(check-expect (si-game-over? (make-fired (make-posn 0 0) (make-tank 100 3) (make-posn 0 (add1 COLLISION-PROXIMITY)))) false)
(define (si-game-over? s)
  (cond
    [(aim? s)
     (>= (posn-y (aim-ufo s)) WORLD-HEIGHT)]
    [(fired? s)
     (or (>= (posn-y (fired-ufo s)) WORLD-HEIGHT)
         (collided? (fired-ufo s) (fired-missile s)))]))

; posn -> posn -> Boolean
; whether p and p2 are within COLLISION-PROXIMITY of each other
(define (collided? p p2)
  (<= (sqrt (+ (expt (- (posn-x p2) (posn-x p)) 2)
               (expt (- (posn-y p2) (posn-y p)) 2)))
      COLLISION-PROXIMITY))

; SIGS -> Image
; render final state after game ends
(define (si-render-final s)
  (place-image
   (if (and (fired? s) (collided? (fired-ufo s) (fired-missile s)))
       (text "A WINNER IS YOU" 24 "purple")
       (text "YOU DIED" 32 "red"))
   (/ WORLD-WIDTH 2)
   (/ WORLD-HEIGHT 2)
   (si-render s)))

; SIGS -> SIGS
; move objects per clock tick, non-testable randomness for ufo move
(define (si-move s)
  (si-move-proper s (* (random MOVE-PER-TICK) (if (even? (random 2)) 1 -1))))

; SIGS -> number -> SIGS
; move objects per clock tick, with number indicating amount of ufo movement
(check-expect (si-move-proper (make-aim (make-posn 0 0) (make-tank 100 3)) 4)
              (make-aim (make-posn 4 4) (make-tank 103 3)))
(check-expect (si-move-proper (make-fired (make-posn 10 0) (make-tank 100 -3) (make-posn 100 200)) -3)
              (make-fired (make-posn 7 4) (make-tank 97 -3) (make-posn 100 196)))
(define (si-move-proper s n)
  (cond
    [(aim? s)
     (make-aim
      (make-posn (+ n (posn-x (aim-ufo s))) (+ (posn-y (aim-ufo s)) MOVE-PER-TICK))
      (make-tank (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s))) (tank-vel (aim-tank s))))]
    [(fired? s)
     (make-fired
      (make-posn (+ n (posn-x (fired-ufo s))) (+ (posn-y (fired-ufo s)) MOVE-PER-TICK))
      (make-tank (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s))) (tank-vel (fired-tank s)))
      (make-posn (posn-x (fired-missile s)) (- (posn-y (fired-missile s)) MOVE-PER-TICK)))]))

; SIGS -> Key -> SIGS
; new game state in response to key
(check-expect (si-control (make-aim (make-posn 0 0) (make-tank 100 3)) "left")
              (make-aim (make-posn 0 0) (make-tank 100 (* -1 MOVE-PER-TICK))))
(check-expect (si-control (make-aim (make-posn 0 0) (make-tank 100 -3)) "right")
              (make-aim (make-posn 0 0) (make-tank 100 MOVE-PER-TICK)))
(check-expect (si-control (make-aim (make-posn 0 0) (make-tank 100 -3)) " ")
              (make-fired (make-posn 0 0) (make-tank 100 -3) (make-posn 100 (- WORLD-HEIGHT TANK-HEIGHT))))
(check-expect (si-control (make-fired (make-posn 0 0) (make-tank 100 3) (make-posn 0 0)) "left")
              (make-fired (make-posn 0 0) (make-tank 100 (* -1 MOVE-PER-TICK)) (make-posn 0 0)))
(check-expect (si-control (make-fired (make-posn 0 0) (make-tank 100 -3) (make-posn 0 0)) "right")
              (make-fired (make-posn 0 0) (make-tank 100 MOVE-PER-TICK) (make-posn 0 0)))
(check-expect (si-control (make-fired (make-posn 0 0) (make-tank 100 -3) (make-posn 100 10)) " ")
              (make-fired (make-posn 0 0) (make-tank 100 -3) (make-posn 100 10)))
(define (si-control s k)
  (cond
    [(and (aim? s) (key=? k "left"))
     (make-aim (aim-ufo s) (make-tank (tank-loc (aim-tank s)) (* -1 MOVE-PER-TICK)))]
    [(and (aim? s) (key=? k "right"))
     (make-aim (aim-ufo s) (make-tank (tank-loc (aim-tank s)) MOVE-PER-TICK))]
    [(and (aim? s) (key=? k " "))
     (make-fired (aim-ufo s) (aim-tank s) (make-posn (tank-loc (aim-tank s)) (- WORLD-HEIGHT TANK-HEIGHT)))]
    [(and (fired? s) (key=? k "left"))
     (make-fired (fired-ufo s) (make-tank (tank-loc (fired-tank s)) (* -1 MOVE-PER-TICK)) (fired-missile s))]
    [(and (fired? s) (key=? k "right"))
     (make-fired (fired-ufo s) (make-tank (tank-loc (fired-tank s)) MOVE-PER-TICK) (fired-missile s))]
    [else s]))


(define (si-main s)
  (big-bang s
    (on-tick si-move 0.1)
    (on-key si-control)
    (to-draw si-render)
    (stop-when si-game-over? si-render-final)))