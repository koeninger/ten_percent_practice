;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |102|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

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


(define MAX-WIDTH 500)
(define MAX-HEIGHT 500)
(define BACKGROUND (empty-scene MAX-WIDTH MAX-HEIGHT))
(define TANK (rectangle (/ MAX-WIDTH 5) (/ MAX-HEIGHT 20) "solid" "blue"))
(define TANK-SPEED 3)
(define MISSILE (triangle (/ MAX-WIDTH 20) "solid" "red"))
(define UFO (ellipse (/ MAX-WIDTH 5) (/ MAX-WIDTH 10) "solid" "green"))
(define UFO-SPEED 3)
(define INITIAL-X (/ MAX-WIDTH 2))
(define MISSILE-SPEED (* UFO-SPEED 2.5))
(define TANK-Y (- MAX-HEIGHT (/ (image-height TANK) 2)))
(define UFO-X-OFFSET (/ (image-width UFO) 2))
(define UFO-Y-OFFSET (/ (image-height UFO) 2))
(define UFO-INITIAL-Y UFO-X-OFFSET)
(define MISSILE-X-OFFSET (/ (image-width MISSILE) 2))
(define MISSILE-Y-OFFSET (/ (image-height MISSILE) 2))
(define MISSILE-INITIAL-Y (- MAX-HEIGHT (image-height TANK)))
(define GAME-OVER (text "GAME OVER" (/ MAX-WIDTH 10) "orange"))
(define UFO-DX 10)

(define INITIAL-STATE (make-sigs
  (make-posn INITIAL-X UFO-INITIAL-Y)
  (make-tank INITIAL-X TANK-SPEED)
  #false))

(define STATE1 (make-sigs
  (make-posn 20 10)
  (make-tank 28 -3)
  #false))

(define STATE2 (make-sigs
  (make-posn 20 10)
  (make-tank 28 -3)
  (make-posn 28 MISSILE-INITIAL-Y)))

(define STATE3 (make-sigs
  (make-posn 20 100)
  (make-tank 50 3)
  (make-posn 22 125)))

(define STATE4 (make-sigs
  (make-posn 20 100)
  (make-tank 50 3)
  (make-posn 22 99)))

(define STATE5 (make-sigs
  (make-posn 30 MAX-HEIGHT)
  (make-tank 60 3)
  (make-posn 30 20)))

(define STATE6 (make-sigs
  (make-posn 30 MAX-HEIGHT)
  (make-tank 60 3)
  #false))


; SIGS.v2 -> Image
; renders the given game state on top of BACKGROUND
; for examples see figure 32
(check-expect (si-render.v2 STATE1)
  (tank-render (sigs-tank STATE1)(ufo-render (sigs-ufo STATE1) BACKGROUND)))
(check-expect (si-render.v2 STATE2)
  (tank-render (sigs-tank STATE2)(ufo-render (sigs-ufo STATE2) (missile-render.v2 (sigs-missile STATE2) BACKGROUND))))
(check-expect (si-render.v2 STATE3)
  (tank-render (sigs-tank STATE3)(ufo-render (sigs-ufo STATE3) (missile-render.v2 (sigs-missile STATE3) BACKGROUND))))
(define (si-render.v2 s)
  (tank-render (sigs-tank s)
    (ufo-render (sigs-ufo s)
      (missile-render.v2 (sigs-missile s) BACKGROUND))))

; Tank Image -> Image
; adds t to the given image im
(check-expect (tank-render (make-tank 5 0) BACKGROUND)
  (place-image TANK 5 TANK-Y BACKGROUND))
(check-expect (tank-render (make-tank 0 0) BACKGROUND)
  (place-image TANK 0 TANK-Y BACKGROUND))
(check-expect (tank-render (make-tank 50 0) BACKGROUND)
  (place-image TANK 50 TANK-Y BACKGROUND))
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))

; UFO Image -> Image
; adds u to the given image im
(check-expect (ufo-render (make-posn 5 5) BACKGROUND)
  (place-image UFO 5 5 BACKGROUND))
(check-expect (ufo-render (make-posn 0 0) BACKGROUND)
  (place-image UFO 0 0 BACKGROUND))
(check-expect (ufo-render (make-posn 50 50) BACKGROUND)
  (place-image UFO 50 50 BACKGROUND))
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; MissileOrNot Image -> Image
; adds an image of missile m to scene
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 30 40) BACKGROUND) (place-image MISSILE 30 40 BACKGROUND))
(define (missile-render.v2 m s)
  (if (posn? m)
    (place-image MISSILE (posn-x m) (posn-y m) s)
    s))


; Missile Image -> Image
; adds m to the given image im
(check-expect (si-game-over? STATE1) #false)
(check-expect (si-game-over? STATE2) #false)
(check-expect (si-game-over? STATE3) #true)
(check-expect (si-game-over? STATE4) #true)
(check-expect (si-game-over? STATE5) #true)
(check-expect (si-game-over? STATE6) #true)
(define (si-game-over? s)
  (cond
    [(>= (+ (posn-y(sigs-ufo s)) UFO-Y-OFFSET) MAX-HEIGHT) #true]
    [(and (posn? (sigs-missile s))(ufo-missile-collision? (sigs-ufo s) (sigs-missile s))) #true]
    [else #false]))

(define (ufo-missile-collision? u m)
  (if (and
      (range-ovelap?
        (- (posn-x u) UFO-X-OFFSET) (+ (posn-x u) UFO-X-OFFSET)
        (- (posn-x m) MISSILE-X-OFFSET) (+ (posn-x m) MISSILE-X-OFFSET))
      (range-ovelap?
        (- (posn-y u) UFO-Y-OFFSET) (+ (posn-y u) UFO-Y-OFFSET)
        (- (posn-y m) MISSILE-Y-OFFSET) (+ (posn-y m) MISSILE-Y-OFFSET)))
    #true #false))

(check-expect (range-ovelap? 5 10 5 9) #true)
(check-expect (range-ovelap? 5 10 5 10) #true)
(check-expect (range-ovelap? 5 10 5 11) #true)
(check-expect (range-ovelap? 5 10 4 9) #true)
(check-expect (range-ovelap? 5 10 4 10) #true)
(check-expect (range-ovelap? 5 10 4 11) #true)
(check-expect (range-ovelap? 5 10 6 9) #true)
(check-expect (range-ovelap? 5 10 6 10) #true)
(check-expect (range-ovelap? 5 10 6 11) #true)
(check-expect (range-ovelap? 5 10 1 3) #false)
(check-expect (range-ovelap? 5 10 11 15) #false)
(define (range-ovelap? a1 a2 b1 b2)
  (if (or
      (and (>= a1 b1) (< a1 b2))
      (and (> a2 b1) (<= a2 b2))
      (and (>= b1 a1) (< b1 a2))
      (and (> b2 a1) (<= b2 a2)))
    #true #false))

; SIGS.v2 -> Image
; renders the given game state on top of BACKGROUND
; and adds the text GAME OVER on top
(define (si-render-final s)
  (overlay GAME-OVER (si-render.v2 s)))


; SIGS.v2 -> SIGS.v2
; called for every clock tick to determine
; to which position the objects move
(define (si-move s)
  (make-sigs
    (UFO-move (sigs-ufo s))
    (sigs-tank s)
    (missile-move (sigs-missile s))))

; Tank, KeyEvent -> Tank
; updates tank-loc based on tank-vel and ke
; and sets it between MAX-WIDTH
(define (tank-move t ke)
  (make-tank (cond
      [(string=? "left" ke)
        (if (> (- (tank-loc t) (tank-vel t)) 0)
          (- (tank-loc t) (tank-vel t)) 0)]
      [(string=? "right" ke)
        (if (< (+ (tank-loc t) (tank-vel t)) MAX-WIDTH)
          (+ (tank-loc t) (tank-vel t)) MAX-WIDTH)]
      [else (tank-loc t)])
    (tank-vel t)))

; UFO -> UFO
; Move UFO down at constant speed
; but moves horizontaly at random direction
(define (UFO-move u)(make-posn
    (+ (posn-x u) (random-dx (posn-x u)))
    (+ (posn-y u) UFO-SPEED)))

; Missile -> Missile
; Move Missile up at constant speed
(define (missile-move m)
  (cond
    [(posn? m)
      (make-posn (posn-x m)(- (posn-y m) MISSILE-SPEED))]
    [else m]))

; Number -> Number
(check-random (random-dx 0) (+ (random UFO-DX) 1))
(check-random (random-dx MAX-WIDTH) (* (+ (random UFO-DX) 1) -1))
(check-random (random-dx (+ UFO-DX 1)) (* (+ (random UFO-DX) 1) (- (random 3) 1)))
(define (random-dx x)
  (* (+ (random UFO-DX) 1) (cond
    [(< (- x UFO-DX) 0) 1]
    [(> (+ x UFO-DX) MAX-WIDTH) -1]
    [else (- (random 3) 1)])))


; SIGS, KeyEvent -> SIGS
(define (si-control s ke)
  (cond
    [(string=? " " ke)
      (make-sigs (sigs-ufo s) (sigs-tank s)
        (make-posn (tank-loc (sigs-tank s)) MISSILE-INITIAL-Y))]
    [else (make-sigs
      (sigs-ufo s)
      (tank-move (sigs-tank s) ke)
      (sigs-missile s))]))

(define (space-invaders si)
  (big-bang si
    (on-tick si-move)
    (on-key si-control)
    (to-draw si-render.v2)
    (stop-when si-game-over? si-render-final)))
