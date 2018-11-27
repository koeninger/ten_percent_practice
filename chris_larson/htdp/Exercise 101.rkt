;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 101|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

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

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s 
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (missile-render m s)]))
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- HEIGHT-OF-WORLD TANK-HEIGHT)) BACKGROUND) (place-image MISSILE 32 (- HEIGHT-OF-WORLD TANK-HEIGHT) BACKGROUND))

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
     (tank-render
       (sigs-tank s)
       (ufo-render (sigs-ufo s)
                   (missile-render.v2 (sigs-missile s)
                                   BACKGROUND))))

; SIGS -> Boolean
; stop when UFO and MISSILE are near or UFO reaches ground
(define (si-game-over? s)
  (cond
    [(boolean? (sigs-missile s))
     (>= (posn-y (sigs-ufo s)) HEIGHT-OF-WORLD)]
    [(posn? (sigs-missile s))
     (or
      (>= (posn-y (sigs-ufo s)) HEIGHT-OF-WORLD)
      (direct-hit? s)
      )]))
(check-expect (si-game-over? (make-sigs (make-posn 20 50) (make-tank 28 -3) (make-posn 25 55))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 40 90))) #false)
(check-expect (si-game-over? (make-sigs(make-posn 20 50) (make-tank 28 -3) #false)) #false)
(check-expect (si-game-over? (make-sigs (make-posn 20 HEIGHT-OF-WORLD) (make-tank 28 -3) #false)) #true)

; SIGS -> Boolean
; are the missile and ufo near?
(define (direct-hit? s)
  (cond
    [(posn? (sigs-missile s))
     (and
      (<= (abs (- (posn-y (sigs-ufo s)) (posn-y (sigs-missile s)))) 10)
      (<= (abs (- (posn-x (sigs-ufo s)) (posn-x (sigs-missile s)))) 10))]
    [else #false]))
(check-expect (direct-hit? (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT)))) #false)
(check-expect (direct-hit? (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 25 15))) #true)

(check-expect (si-render (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT)))) (place-image
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
  (si-move-proper w (ufo-random 1)))

; Number
(define (ufo-random u)
  (- (random (/ WIDTH-OF-WORLD 50)) (/ (/ WIDTH-OF-WORLD 50) 2)))
  
; SIGS Number -> SIGS 
; moves the space-invader objects predictably by delta
(define (si-move-proper s delta)
  (cond
    [(boolean? (sigs-missile s))
     (make-sigs
      (move-ufo (sigs-ufo s) delta)
      (move-tank (sigs-tank s))
      #false)]
    [(posn? (sigs-missile s))
     (make-sigs
      (move-ufo (sigs-ufo s) delta)
      (move-tank (sigs-tank s))
      (move-missile (sigs-missile s)))]))
(check-expect (si-move-proper (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT))) 4)
              (make-sigs (make-posn 24 (+ 10 UFO-SPEED)) (make-tank 25 -3) (make-posn 28 (+ (- HEIGHT-OF-WORLD TANK-HEIGHT) MISSILE-SPEED))))

; tank -> tank
(define (move-tank t)
  (cond
    [(< (tank-loc t) 0) (make-tank 0 0)]
    [(> (tank-loc t) WIDTH-OF-WORLD) (make-tank WIDTH-OF-WORLD 0)]
    [else (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t))]))

; ufo -> ufo
(define (move-ufo u delta)
  (cond
    [(< (posn-x u) 0) (make-posn 0 (+ (posn-y u) UFO-SPEED))]
    [(> (posn-x u) WIDTH-OF-WORLD) (make-posn WIDTH-OF-WORLD (+ (posn-y u) UFO-SPEED))]
    [else (make-posn (+ (posn-x u) delta) (+ (posn-y u) UFO-SPEED))]))

; missile -> missile
(define (move-missile m)
  (make-posn (posn-x m) (+ (posn-y m) MISSILE-SPEED)))

; SIGS KeyEvent -> SIGS
(define (si-control s ke)
  (cond
    [(posn? (sigs-missile s))
     (cond
       [(key=? ke "left") (make-sigs (sigs-ufo s) (make-tank (tank-loc (sigs-tank s)) (- 0 TANK-SPEED)) (sigs-missile s))]
       [(key=? ke "right") (make-sigs (sigs-ufo s) (make-tank (tank-loc (sigs-tank s)) TANK-SPEED) (sigs-missile s))]
       [else s]
       )]
    [(boolean? (sigs-missile s))
     (cond
       [(key=? ke "left") (make-sigs (sigs-ufo s) (make-tank (tank-loc (sigs-tank s)) (- 0 TANK-SPEED)) #false)]
       [(key=? ke "right") (make-sigs (sigs-ufo s) (make-tank (tank-loc (sigs-tank s)) TANK-SPEED) #false)]
       [(key=? ke " ") (make-sigs (sigs-ufo s) (sigs-tank s) (make-posn (tank-loc (sigs-tank s)) (- HEIGHT-OF-WORLD TANK-HEIGHT)))]
       [else s]
       )]))

; AnimationState -> AnimationState
; launches the program from some initial state
(define (main s)
  (big-bang s
    [on-tick si-move]
    [on-key si-control]
    [to-draw si-render]
    [stop-when si-game-over?]))

(main (make-sigs (make-posn 200 0) (make-tank 100 -3) #false))