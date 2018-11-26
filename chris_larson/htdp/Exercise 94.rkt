;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 94|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 400)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 5)
(define UFO-SPEED 2)

(define UFO (rectangle UFO-WIDTH UFO-HEIGHT "solid" "blue"))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK-SPEED 2)

(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "green"))

(define MISSILE-WIDTH 10)
(define MISSILE-SPEED -5)

(define MISSILE (triangle MISSILE-WIDTH "solid" "red"))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

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


; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image
    TANK
    (tank-loc t) HEIGHT-OF-WORLD
    im))
 
; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image
    UFO
    (posn-x u) (posn-y u)
    im))

; MISSILE Image -> Image 
; adds m to the given image im
(define (missile-render m im)
  (place-image
    MISSILE
    (posn-x m) (posn-y m)
    im))

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

; SIGS -> Boolean
; stop when UFO and MISSILE are near or UFO reaches ground
(define (si-game-over? s)
  (cond
    [(aim? s)
     (>= (posn-y (aim-ufo s)) HEIGHT-OF-WORLD)]
    [(fired? s)
     (or
      (>= (posn-y (fired-ufo s)) HEIGHT-OF-WORLD)
      (direct-hit? s)
      )]))
(check-expect (si-game-over? (make-fired (make-posn 20 50) (make-tank 28 -3) (make-posn 25 55))) #true)
(check-expect (si-game-over? (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 40 90))) #false)
(check-expect (si-game-over? (make-aim (make-posn 20 50) (make-tank 28 -3))) #false)
(check-expect (si-game-over? (make-aim (make-posn 20 HEIGHT-OF-WORLD) (make-tank 28 -3))) #true)

; SIGS -> Boolean
; are the missile and ufo near?
(define (direct-hit? s)
  (and
   (<= (abs (- (posn-y (fired-ufo s)) (posn-y (fired-missile s)))) 10)
   (<= (abs (- (posn-x (fired-ufo s)) (posn-x (fired-missile s)))) 10)))
(check-expect (direct-hit? (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT)))) #false)
(check-expect (direct-hit? (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 25 15))) #true)

(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3))) (place-image
 TANK
  28 HEIGHT-OF-WORLD
  (place-image
   UFO
   20 10
   BACKGROUND)))
(check-expect (si-render (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT)))) (place-image
 TANK
  28 HEIGHT-OF-WORLD
  (place-image
   UFO
   20 10
   (place-image
    MISSILE
    28 (- HEIGHT-OF-WORLD TANK-HEIGHT)
    BACKGROUND))))

; SIGS -> SIGS
(define (si-move w)
  (si-move-proper w (random (/ WIDTH-OF-WORLD 50))))

; SIGS Number -> SIGS 
; moves the space-invader objects predictably by delta
(define (si-move-proper s delta)
  (cond
    [(aim? s)
     (make-aim
      (make-posn (+ (posn-x (aim-ufo s)) delta) (+ (posn-y (aim-ufo s)) UFO-SPEED))
      (make-tank (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s))) (tank-vel (aim-tank s))))]
    [(fired? s)
     (make-fired
      (make-posn (+ (posn-x (fired-ufo s)) delta) (+ (posn-y (fired-ufo s)) UFO-SPEED))
      (make-tank (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s))) (tank-vel (fired-tank s)))
      (make-posn (posn-x (fired-missile s)) (+ (posn-y (fired-missile s)) MISSILE-SPEED)))]))
(check-expect (si-move-proper (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT))) 4)
              (make-fired (make-posn 24 (+ 10 UFO-SPEED)) (make-tank 25 -3) (make-posn 28 (+ (- HEIGHT-OF-WORLD TANK-HEIGHT) MISSILE-SPEED))))
(check-expect (si-move-proper (make-aim (make-posn 20 10) (make-tank 28 -3)) 4)
              (make-aim (make-posn 24 (+ 10 UFO-SPEED)) (make-tank 25 -3)))