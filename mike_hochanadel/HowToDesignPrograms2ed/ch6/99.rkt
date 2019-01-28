;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |99|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(define BACKGROUND_WIDTH 200)
(define BACKGROUND_HEIGHT 200)
(define BACKGROUND (empty-scene BACKGROUND_WIDTH BACKGROUND_HEIGHT))

(define MISSILE_SIZE 10)
(define MISSILE (triangle MISSILE_SIZE "solid" "red"))
(define MISSILE_SPEED 5)

(define UFO_WIDTH 30)
(define UFO_HEIGHT 20)
(define UFO (overlay
             (circle (/ UFO_HEIGHT 2) "solid" "green")
             (rectangle UFO_WIDTH (/ UFO_HEIGHT 2) "solid" "green")))
(define UFO_MOVE_RANGE 10)
(define UFO_LANDING_SPEED 2)

(define TANK_HEIGHT 20)
(define TANK_WIDTH 30)
(define TANK_TOP_WIDTH 10)
(define TANK (overlay/align
              "center"
              "bottom"
              (rectangle TANK_TOP_WIDTH TANK_HEIGHT "solid" "black")
              (rectangle TANK_WIDTH (/ TANK_HEIGHT  2) "solid" "black")))

(define GAME_OVER (text "Game OVER!" 12 "black"))
(define YOU_WIN (text "You Win!" 12 "green"))
(define YOU_LOSE (text "You Lose!" 12 "red"))


; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; tank, Image -> Image
; renders the tank on top of the given Image
(check-expect (tank-render (make-tank 60 3) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank 60 3))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(check-expect (tank-render (make-tank 0 56) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank 0 56))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(check-expect (tank-render (make-tank BACKGROUND_WIDTH 0) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank BACKGROUND_WIDTH 0))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(define (tank-render t im)
  (place-image
   TANK
   (tank-loc t)
   (- (image-height im) (/ TANK_HEIGHT 2))
   im))

; UFO, Image -> Image
; renders UFO on top of the given Image
(check-expect (ufo-render (make-posn 100 35) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 100 35))
   (- (image-height BACKGROUND) (posn-y (make-posn 100 35)))
   BACKGROUND))
(check-expect (ufo-render (make-posn 0 0) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 0 0))
   (- (image-height BACKGROUND) (posn-y (make-posn 0 0)))
   BACKGROUND))
(check-expect (ufo-render (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   (- (image-height BACKGROUND) (posn-y (make-posn  BACKGROUND_WIDTH BACKGROUND_HEIGHT)))
   BACKGROUND))
(define (ufo-render u im)
  (place-image
   UFO
   (posn-x u)
   (- (image-height im) (posn-y u))
   im))

; Missile, Image -> Image
; renders Missile on top of the given Image
(check-expect (missile-render (make-posn 67 34) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn 67 34))
   (- (image-height BACKGROUND) (posn-y (make-posn 67 34)))
   BACKGROUND))
(check-expect (missile-render (make-posn 0 0) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn 0 0))
   (- (image-height BACKGROUND) (posn-y (make-posn 0 0)))
   BACKGROUND))
(check-expect (missile-render (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   (- (image-height BACKGROUND) (posn-y (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT)))
   BACKGROUND))
(define (missile-render m im)
  (place-image
   MISSILE
   (posn-x m)
   (- (image-height im) (posn-y m))
   im))

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(check-expect (si-render (make-aim (make-posn 34 40) (make-tank 150 3)))
              (tank-render (aim-tank (make-aim (make-posn 34 40) (make-tank 150 3)))
                  (ufo-render (aim-ufo (make-aim (make-posn 34 40) (make-tank 150 3))) BACKGROUND)))
(check-expect (si-render (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
              (tank-render
       (fired-tank (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
       (ufo-render (fired-ufo (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                   (missile-render (fired-missile (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                                   BACKGROUND))))
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

; SIGS -> Image
; renders the final state of the given game on top of BACKGROUND
(check-expect (si-render-final (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 36)))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))
(check-expect (si-render-final (make-aim (make-posn 34 190) (make-tank 14 0)))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-aim (make-posn 34 190) (make-tank 14 0))) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))
(check-expect (si-render-final (make-fired (make-posn 50 190) (make-tank 14 0) (make-posn 100 100)))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-fired (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))
(define (si-render-final s)
  (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? s) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))

; SIGS -> boolean
; ufo-hit states if the UFO has been hit by the missile
(check-expect (ufo-hit? (make-aim (make-posn 34 190) (make-tank 14 0))) #false)
(check-expect (ufo-hit? (make-aim (make-posn 34 100) (make-tank 14 0))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 50))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 50))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 35))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 65))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 35))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 65))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 65))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 35))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 34))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 69 35))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 71 35))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 64))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 66))) #false)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 31 65))) #true)
(check-expect (ufo-hit? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (ufo-hit? s)
  (cond
    [(fired? s)
       (cond
        [(and
         (and
          (>=
           (+ (posn-y (fired-ufo s)) (/ UFO_HEIGHT 2))
           (- (posn-y (fired-missile s)) (/ MISSILE_SIZE 2))
          )
          (<=
           (- (posn-y (fired-ufo s)) (/ UFO_HEIGHT 2))
           (+ (posn-y (fired-missile s)) (/ MISSILE_SIZE 2)))
          )
         (and
          (>=
           (+ (posn-x (fired-missile s)) (/ MISSILE_SIZE 2))
           (- (posn-x (fired-ufo s)) (/ UFO_WIDTH 2))
          )
          (<=
           (- (posn-x (fired-missile s)) (/ MISSILE_SIZE 2))
           (+ (posn-x (fired-ufo s)) (/ UFO_WIDTH 2)))
          ))
          #true]
       [else #false])]
      [else #false]))

; SIGS -> boolean
; ufo-landed states if the UFO has landed in the scene
(check-expect (ufo-landed? (make-aim (make-posn 34 190) (make-tank 14 0))) #true)
(check-expect (ufo-landed? (make-aim (make-posn 34 100) (make-tank 14 0))) #false)
(check-expect (ufo-landed? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-landed? (make-fired (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #true)
(check-expect (ufo-landed? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (ufo-landed? s)
  (cond
    [(fired? s)
     (cond
      [(>= (posn-y (fired-ufo s)) (- BACKGROUND_HEIGHT (/ UFO_HEIGHT 2))) #true]
      [else #false]
     )
    ]
    [else
     (cond
       [(>= (posn-y (aim-ufo s)) (- BACKGROUND_HEIGHT (/ UFO_HEIGHT 2))) #true]
       [else #false]
     )
    ]))
       

; SIGS -> boolean
; si-game-over? takes the game state and reports whether the game is over or not
;  the game is over if a Missile hits the target or the UFO lands
(check-expect (si-game-over? (make-aim (make-posn 34 190) (make-tank 14 0))) #true)
(check-expect (si-game-over? (make-aim (make-posn 34 100) (make-tank 14 0))) #false)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (si-game-over? (make-fired (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 50))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 50))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 35))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 65))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 35))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 65))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 65))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 35))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 70 34))) #false)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 69 35))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 71 35))) #false)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 64))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 30 66))) #false)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 31 65))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (si-game-over? s)
  (cond
    [(ufo-hit? s) #true]
    [else (ufo-landed? s)]))

; SIGS -> Number 
; get the x coordinate change for the UFO
(check-random (si-ufo-delta (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 50)))
   (cond
    [(= (random 1) 1) (+ 
      (posn-x (fired-ufo (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))))      
      (random UFO_MOVE_RANGE))]
    [else (-
      (posn-x (fired-ufo (make-fired (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))))   
      (random UFO_MOVE_RANGE))]))
(check-random (si-ufo-delta (make-aim (make-posn 34 100) (make-tank 14 0)))
   (cond
    [(= (random 1) 1) (+ 
      (posn-x (aim-ufo (make-aim (make-posn 34 100) (make-tank 14 0))))      
      (random UFO_MOVE_RANGE))]
    [else (-
      (posn-x (aim-ufo (make-aim (make-posn 34 100) (make-tank 14 0))))   
      (random UFO_MOVE_RANGE))]))
(define (si-ufo-delta w)
  (cond
    [(= (random 1) 1) (+ 
      (posn-x (cond
                [(fired? w) (fired-ufo w)]
                [else (aim-ufo w)]))
      (random UFO_MOVE_RANGE))]
    [else (-
      (posn-x (cond
                [(fired? w) (fired-ufo w)]
                [else (aim-ufo w)]))
      (random UFO_MOVE_RANGE))]))

; Number -> boolean
; detects the left boundary for the x plane of the game area
(check-expect (left-boundary-hit? -3) #true)
(check-expect (left-boundary-hit? 0) #true)
(check-expect (left-boundary-hit? BACKGROUND_WIDTH) #false)
(check-expect (left-boundary-hit? (+ 3 BACKGROUND_WIDTH)) #false)
(check-expect (left-boundary-hit? (- BACKGROUND_WIDTH 34)) #false)
(define (left-boundary-hit? x)
  (cond
    [(<= x 0) #true]
    [else #false]
   ))

; Number -> boolean
; detects the right boundary for the x plane of the game area
(check-expect (right-boundary-hit? -3) #false)
(check-expect (right-boundary-hit? 0) #false)
(check-expect (right-boundary-hit? BACKGROUND_WIDTH) #true)
(check-expect (right-boundary-hit? (+ 3 BACKGROUND_WIDTH)) #true)
(check-expect (right-boundary-hit? (- BACKGROUND_WIDTH 34)) #false)
(define (right-boundary-hit? x)
  (cond
    [(>= x BACKGROUND_WIDTH) #true]
    [else #false]
   ))

; Number Number -> Number
; gets the x position given the current position
(check-expect (new-x-position 0 -3) 0)
(check-expect (new-x-position -3 -3) 0)
(check-expect (new-x-position 3 -3) 0)
(check-expect (new-x-position 43 -3) 40)
(check-expect (new-x-position BACKGROUND_WIDTH 3) BACKGROUND_WIDTH)
(check-expect (new-x-position (+ BACKGROUND_WIDTH 10) 3) BACKGROUND_WIDTH)
(check-expect (new-x-position 34 3) 37)
(define (new-x-position x u-x)
   (cond
     [(left-boundary-hit? x) 0]
     [(right-boundary-hit? x) BACKGROUND_WIDTH]
     [else (+ x u-x)]))

; Number -> boolean
; tells if the missile fired off the scene
(check-expect (missile-gone? 0) #false)
(check-expect (missile-gone? 30) #false)
(check-expect (missile-gone? (- BACKGROUND_HEIGHT 20)) #false)
(check-expect (missile-gone? (+ BACKGROUND_HEIGHT 10)) #true)
(check-expect (missile-gone? BACKGROUND_HEIGHT) #true)
(define (missile-gone? y)
  (cond
    [(>= y BACKGROUND_HEIGHT) #true]
    [else #false]))

; SIGS Number -> SIGS
; moves the space-invader objects predictably by delta
(check-expect
 (si-move-proper
  (make-fired (make-posn 12 34) (make-tank 45 3) (make-posn 45 BACKGROUND_HEIGHT))
  9)
 (make-aim
  (make-posn (new-x-position 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)))
(check-expect
 (si-move-proper
  (make-fired (make-posn 12 34) (make-tank 45 3) (make-posn 45 56))
  9)
 (make-fired
  (make-posn (new-x-position 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)
  (make-posn 45 (- 56 MISSILE_SPEED))))
(check-expect
 (si-move-proper
  (make-aim (make-posn 12 34) (make-tank 45 3))
  9)
 (make-aim
  (make-posn (new-x-position 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)))
(define (si-move-proper w u-x)
  (cond
    [(fired? w)
      (cond
        [(false? (missile-gone? (posn-y (fired-missile w))))
              (make-fired
                 (make-posn
                  (new-x-position (posn-x (fired-ufo w)) u-x)
                  (+ (posn-y (fired-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (fired-tank w)) (tank-vel (fired-tank w)))
                  (tank-vel (fired-tank w)))
                 (make-posn
                  (posn-x (fired-missile w))
                  (- (posn-y (fired-missile w)) MISSILE_SPEED)))]
        [else
         (make-aim
                 (make-posn
                  (new-x-position (posn-x (fired-ufo w)) u-x)
                  (+ (posn-y (fired-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (fired-tank w)) (tank-vel (fired-tank w)))
                  (tank-vel (fired-tank w))))])]
     [else (make-aim
                 (make-posn
                  (new-x-position (posn-x (aim-ufo w)) u-x)
                  (+ (posn-y (aim-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (aim-tank w)) (tank-vel (aim-tank w)))
                  (tank-vel (aim-tank w))))]))

;SIGS -> SIGS
; move handler for the objecs in the game
(define (si-move w)
  (si-move-proper w (si-ufo-delta w)))
 