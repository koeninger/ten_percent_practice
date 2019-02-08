;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex99) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct ufo [x y])
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define-struct missile [x y])
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


(define-struct aim [ufo tank])
;     (make-aim (make-posn 20 10) (make-tank 28 -3))

(define-struct fired [ufo tank missile])
;(make-fired (make-posn 20 10)
 ;(make-tank 28 -3)
  ;(make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT)))



(define CANVAS-WIDTH 400)
(define CANVAS-HEIGHT 400)
(define BACKGROUND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT))


(define TANK-HEIGHT 20)
(define TANK (rectangle 40 TANK-HEIGHT "solid" "green"))
(define TANK-SPEED 2)

(define MISSILE (triangle (* TANK-HEIGHT .5) "solid" "black"))

(define UFO-WIDTH 40)
(define UFO-HEIGHT 20)
(define UFO-IMPACT 15)
(define UFO (ellipse UFO-WIDTH UFO-HEIGHT "solid" "red"))
(define UFO-SPEED 1)

(define START-GAME (make-aim
  (make-posn 200 100)
  (make-tank 200 TANK-SPEED)))

(define (si-render-missile s)
  (place-images
   (list
      TANK
      MISSILE
      UFO )
   (list
    (make-posn  (tank-loc (fired-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
    (fired-missile s)
    (fired-ufo s))
   BACKGROUND)
  )


(define (si-render-aim s)
  (place-images
   (list
      TANK
      UFO 
      )
   (list (make-posn (tank-loc (aim-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
         (aim-ufo s))
   BACKGROUND)
  )


; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (si-render-aim s)]
    [(fired? s)
      (si-render-missile s)]))


	

; Tank Image -> Image 
; adds t to the given image im
;(define (tank-render t im)
;  (place-image
;    TANK
;    (tank-loc t) CANVAS-HEIGHT
;    im));

;; UFO Image -> Image 
;; adds u to the given image im
;(define (ufo-render u im)
;  (place-image
;    UFO
;    (posn-x u) (posn-y u)
;    im));

;; Missile Image -> Image 
;; adds m to the given image im
;(define (missile-render m im)
;  (place-image
;    MISSILE
;    (posn-x m) (posn-y m)
;    im))


(define (missil-impact m u)
  (cond
    [ (>= UFO-IMPACT ( sqrt ( + (sqr(-(posn-x m) (posn-x u)) )
                                (sqr(- (posn-y m) (posn-y u)) )))
          ) #true]
    [else #false]
  ))

(define (ufo-landed u)
  (cond
    [ (<= (posn-y u) (- CANVAS-HEIGHT (* UFO-HEIGHT .5)) ) #false ]
    [else #true])
  )

(define (si-game-over? s)
  (cond
    [(aim? s)
     (ufo-landed (aim-ufo s))]
    [(fired? s)
      (missil-impact (fired-ufo s) (fired-missile s) )]))

(define (si-render-final s) s)





(define (move-ufo pos delta)
  (cond
    [ delta
      (make-posn (+ (posn-x pos) 5) (+ (posn-y pos) UFO-SPEED))]
    [else
      (make-posn (- (posn-x pos) 5) (+ (posn-y pos) UFO-SPEED))]
  ))


(define (move-tank t)
  (cond
    [(< (tank-loc t) 0) (make-tank 0 0)]
    [(> (tank-loc t) CANVAS-WIDTH) (make-tank CANVAS-WIDTH 0)]
    [else (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t))]))


(define (random-move n)
  (cond
    [(even? (random n)) #true ]
    [else #false])
  )

(define (si-move s)
  (si-move-proper s (random-move 6) )
  )

(define (si-move-proper s delta)
  (cond
    [(aim? s)
     (make-aim
      (move-ufo (aim-ufo s) delta)
      (move-tank (aim-tank s)))
     ]
    [(fired? s)
    (make-fired
      (move-ufo (fired-ufo s) delta)
      (move-tank (fired-tank s))
      (make-posn (posn-x (fired-missile s)) (posn-y (fired-missile s))))
     ])
  )


 
(define (main s)
  (big-bang s
    [on-tick si-move]
    ;[on-key si-control]
    [to-draw si-render]
    [stop-when si-game-over?]))

(main START-GAME)

