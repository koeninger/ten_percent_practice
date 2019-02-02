;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |102|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 

; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game

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
(define TANK_SPEED 3)

(define GAME_OVER (text "Game OVER!" 12 "black"))
(define YOU_WIN (text "You Win!" 12 "green"))
(define YOU_LOSE (text "You Lose!" 12 "red"))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)) BACKGROUND)
  (place-image
   MISSILE
   (posn-x (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)))
   (posn-y (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)))
   BACKGROUND)) 
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) s)]))

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
; renders UFO on top of the given Image(si
(check-expect (ufo-render (make-posn 100 35) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 100 35))
   (posn-y (make-posn 100 35))
   BACKGROUND))
(check-expect (ufo-render (make-posn 0 0) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 0 0))
   (posn-y (make-posn 0 0))
   BACKGROUND))
(check-expect (ufo-render (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   (posn-y (make-posn  BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   BACKGROUND))
(define (ufo-render u im)
  (place-image
   UFO
   (posn-x u)
   (posn-y u)
   im))

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(check-expect (si-render (make-sigs (make-posn 34 40) (make-tank 150 3) #false))
              (tank-render (sigs-tank (make-sigs (make-posn 34 40) (make-tank 150 3) #false))
                  (ufo-render (sigs-ufo (make-sigs (make-posn 34 40) (make-tank 150 3) #false))
                      (missile-render.v2 (sigs-missile (make-sigs (make-posn 34 40) (make-tank 150 3) #false)) BACKGROUND))))
(check-expect (si-render (make-sigs (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
              (tank-render
       (sigs-tank (make-sigs (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
       (ufo-render (sigs-ufo (make-sigs (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                   (missile-render.v2 (sigs-missile (make-sigs (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                                   BACKGROUND))))
(define (si-render s)
     (tank-render
       (sigs-tank s)
       (ufo-render (sigs-ufo s)
                   (missile-render.v2 (sigs-missile s)
                                   BACKGROUND))))

; SIGS -> Image
; renders the final state of the given game on top of BACKGROUND
(check-expect (si-render-final (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 36)))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))
(check-expect (si-render-final (make-sigs (make-posn 34 190) (make-tank 14 0) #false))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-sigs (make-posn 34 190) (make-tank 14 0) #false)) YOU_WIN]
     [else YOU_LOSE])
    40 34 BACKGROUND)))
(check-expect (si-render-final (make-sigs (make-posn 50 190) (make-tank 14 0) (make-posn 100 100)))
 (place-image
   GAME_OVER 40 20
   (place-image
    (cond
     [(ufo-hit? (make-sigs (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) YOU_WIN]
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
(check-expect (ufo-hit? (make-sigs (make-posn 34 190) (make-tank 14 0) #false)) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 34 100) (make-tank 14 0) #false)) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 50))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 50))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 35))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 65))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 35))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 65))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 65))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 35))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 34))) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 69 35))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 71 35))) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 64))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 66))) #false)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 31 65))) #true)
(check-expect (ufo-hit? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (ufo-hit? s)
  (cond
    [(boolean? (sigs-missile s)) #false]
    [(posn? (sigs-missile s))
       (cond
        [(and
         (and
          (>=
           (+ (posn-y (sigs-ufo s)) (/ UFO_HEIGHT 2))
           (- (posn-y (sigs-missile s)) (/ MISSILE_SIZE 2))
          )
          (<=
           (- (posn-y (sigs-ufo s)) (/ UFO_HEIGHT 2))
           (+ (posn-y (sigs-missile s)) (/ MISSILE_SIZE 2)))
          )
         (and
          (>=
           (+ (posn-x (sigs-missile s)) (/ MISSILE_SIZE 2))
           (- (posn-x (sigs-ufo s)) (/ UFO_WIDTH 2))
          )
          (<=
           (- (posn-x (sigs-missile s)) (/ MISSILE_SIZE 2))
           (+ (posn-x (sigs-ufo s)) (/ UFO_WIDTH 2)))
          ))
          #true]
       [else #false])]
      ))

; SIGS -> boolean
; ufo-landed states if the UFO has landed in the scene
(check-expect (ufo-landed? (make-sigs (make-posn 34 190) (make-tank 14 0) #false)) #true)
(check-expect (ufo-landed? (make-sigs (make-posn 34 100) (make-tank 14 0) #false)) #false)
(check-expect (ufo-landed? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (ufo-landed? (make-sigs (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #true)
(check-expect (ufo-landed? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (ufo-landed? s)
  (cond
       [(>= (posn-y (sigs-ufo s)) (- BACKGROUND_HEIGHT (/ UFO_HEIGHT 2))) #true]
       [else #false]
  ))

; SIGS -> boolean
; si-game-over? takes the game state and reports whether the game is over or not
;  the game is over if a Missile hits the target or the UFO lands
(check-expect (si-game-over? (make-sigs (make-posn 34 190) (make-tank 14 0) #false)) #true)
(check-expect (si-game-over? (make-sigs (make-posn 34 100) (make-tank 14 0) #false)) #false)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 100 100))) #false)
(check-expect (si-game-over? (make-sigs (make-posn 50 190) (make-tank 14 0) (make-posn 100 100))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 50))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 50))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 50))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 35))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 50 65))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 35))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 65))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 65))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 35))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 36))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 70 34))) #false)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 69 35))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 71 35))) #false)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 64))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 30 66))) #false)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 31 65))) #true)
(check-expect (si-game-over? (make-sigs (make-posn 50 50) (make-tank 14 0) (make-posn 29 65))) #false)
(define (si-game-over? s)
  (cond
    [(ufo-hit? s) #true]
    [else (ufo-landed? s)]))

; Number -> Number 
; get the x coordinate change for the UFO
(check-random (si-ufo-delta 5)
   (cond
    [(= (random 2) 1) (make-positive (random 5))]
    [else (make-negative (random 5))]))
(define (si-ufo-delta w)
  (cond
    [(= (random 2) 1) (make-positive (random w))]
    [else (make-negative (random w))]))

; Number -> Number
; Takes a number and forces it to negative, unless it's zero
(check-expect (make-negative 3) -3)
(check-expect (make-negative -3) -3)
(check-expect (make-negative 0) 0)
(define (make-negative n)
  (cond
    [(negative? n) n]
    [else (* n -1)]))

; Number -> Number
; Takes a number and forces it to positive, unless it's zero
(check-expect (make-positive 3) 3)
(check-expect (make-positive -3) 3)
(check-expect (make-positive 0) 0)
(define (make-positive n)
  (cond
    [(negative? n) (* -1 n)]
    [else n]))


; Number -> boolean
; detects the left boundary for the x plane of the game area
(check-expect (left-boundary-hit? -3) #true)
(check-expect (left-boundary-hit? 0) #false)
(check-expect (left-boundary-hit? BACKGROUND_WIDTH) #false)
(check-expect (left-boundary-hit? (+ 3 BACKGROUND_WIDTH)) #false)
(check-expect (left-boundary-hit? (- BACKGROUND_WIDTH 34)) #false)
(define (left-boundary-hit? x)
  (cond
    [(< x 0) #true]
    [else #false]
   ))

; Number -> boolean
; detects the right boundary for the x plane of the game area
(check-expect (right-boundary-hit? -3) #false)
(check-expect (right-boundary-hit? 0) #false)
(check-expect (right-boundary-hit? BACKGROUND_WIDTH) #false)
(check-expect (right-boundary-hit? (+ 3 BACKGROUND_WIDTH)) #true)
(check-expect (right-boundary-hit? (- BACKGROUND_WIDTH 34)) #false)
(define (right-boundary-hit? x)
  (cond
    [(> x BACKGROUND_WIDTH) #true]
    [else #false]
   ))

; Number Number -> Number
; gets the x position given the current position
(check-expect (new-x-position 0 -3) -3)
(check-expect (new-x-position -3 -3) BACKGROUND_WIDTH)
(check-expect (new-x-position 3 -3) 0)
(check-expect (new-x-position 43 -3) 40)
(check-expect (new-x-position BACKGROUND_WIDTH 3) (+ BACKGROUND_WIDTH 3) )
(check-expect (new-x-position (+ BACKGROUND_WIDTH 10) 3) 0)
(check-expect (new-x-position 34 3) 37)
(define (new-x-position x u-x)
   (cond
     [(left-boundary-hit? x) BACKGROUND_WIDTH]
     [(right-boundary-hit? x) 0]
     [else (+ x u-x)]))

; Number -> boolean
; tells if the missile fired off the scene
(check-expect (missile-gone? 0) #true)
(check-expect (missile-gone? 30) #false)
(check-expect (missile-gone? -20) #true)
(check-expect (missile-gone? (+ BACKGROUND_HEIGHT 10)) #false)
(check-expect (missile-gone? BACKGROUND_HEIGHT) #false)
(define (missile-gone? y)
  (cond
    [(<= y 0) #true]
    [else #false]))


; SIGS Number -> SIGS
; moves the space-invader objects predictably by delta
(check-expect
 (si-move-proper
  (make-sigs (make-posn 12 34) (make-tank 45 3) (make-posn 45 BACKGROUND_HEIGHT))
  9)
 (make-sigs
  (make-posn (new-x-position 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)
  (make-posn 45 (- BACKGROUND_HEIGHT MISSILE_SPEED))))
(check-expect
 (si-move-proper
  (make-sigs (make-posn 12 34) (make-tank 45 3) (make-posn 45 56))
  9)
 (make-sigs
  (make-posn (new-x-position 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)
  (make-posn 45 (- 56 MISSILE_SPEED))))
(check-expect
 (si-move-proper
  (make-sigs (make-posn 12 34) (make-tank 45 3) #false)
  9)
 (make-sigs
  (make-posn (+ 12 9) (+ 34 UFO_LANDING_SPEED))
  (make-tank (new-x-position 45 3) 3)
  #false))
(define (si-move-proper w u-x)
  (cond
    [(boolean? (sigs-missile w)) (make-sigs
                 (make-posn
                  (new-x-position (posn-x (sigs-ufo w)) u-x)
                  (+ (posn-y (sigs-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (sigs-tank w)) (tank-vel (sigs-tank w)))
                  (tank-vel (sigs-tank w)))
                 #false)]
    [(posn? (sigs-missile w))
      (cond
        [(false? (missile-gone? (posn-y (sigs-missile w))))
              (make-sigs
                 (make-posn
                  (new-x-position (posn-x (sigs-ufo w)) u-x)
                  (+ (posn-y (sigs-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (sigs-tank w)) (tank-vel (sigs-tank w)))
                  (tank-vel (sigs-tank w)))
                 (make-posn
                  (posn-x (sigs-missile w))
                  (- (posn-y (sigs-missile w)) MISSILE_SPEED)))]
        [else
         (make-sigs
                 (make-posn
                  (new-x-position (posn-x (sigs-ufo w)) u-x)
                  (+ (posn-y (sigs-ufo w)) UFO_LANDING_SPEED))
                 (make-tank
                  (new-x-position (tank-loc (sigs-tank w)) (tank-vel (sigs-tank w)))
                  (tank-vel (sigs-tank w)))
                 #false)]
        )]
    ))

; SIGS -> SIGS
; move handler for the objecs in the game
(define (si-move w)
  (si-move-proper w (si-ufo-delta UFO_MOVE_RANGE)))

; SIGS, KeyEvent -> SIGS
; key press handling for objects in game.  Move tank left or right and fire a missile
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 -10) #false) "left")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-negative -10)) #false))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) #false) "left")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-negative -10)) #false))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 -10) #false) "right")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-positive -10)) #false))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) #false) "right")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-positive 10)) #false))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) #false) " ")
              (make-sigs (make-posn 34 43) (make-tank 54 10) (make-posn 54 (- BACKGROUND_HEIGHT TANK_HEIGHT))))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 -10) (make-posn 100 50)) "left")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-negative -10)) (make-posn 100 50)))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) (make-posn 100 50)) "left")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-negative -10)) (make-posn 100 50)))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 -10) (make-posn 100 50)) "right")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-positive -10)) (make-posn 100 50)))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) (make-posn 100 50)) "right")
              (make-sigs (make-posn 34 43) (make-tank 54 (make-positive 10)) (make-posn 100 50)))
(check-expect (si-control (make-sigs (make-posn 34 43) (make-tank 54 10) (make-posn 100 50)) " ")
              (make-sigs (make-posn 34 43) (make-tank 54 10) (make-posn 100 50)))
(define (si-control s ke)
  (cond
    [(boolean? (sigs-missile s))
     (cond
       [(key=? ke " ") (make-sigs
                               (sigs-ufo s)
                               (sigs-tank s)
                               (make-posn
                                (tank-loc (sigs-tank s))
                                (- BACKGROUND_HEIGHT TANK_HEIGHT))
                               )]
       [else (make-sigs
              (sigs-ufo s)
              (make-tank (tank-loc (sigs-tank s))
               (cond
                [(key=? ke "left") (make-negative (tank-vel (sigs-tank s)))]
                [(key=? ke "right") (make-positive (tank-vel (sigs-tank s)))]
                [else (tank-vel (sigs-tank s))]))
               #false)])]
    [(posn? (sigs-missile s))
      (make-sigs
        (sigs-ufo s)
        (make-tank (tank-loc (sigs-tank s))
                      (cond
                        [(key=? ke "left") (make-negative (tank-vel (sigs-tank s)))]
                        [(key=? ke "right") (make-positive (tank-vel (sigs-tank s)))]
                        [else (tank-vel (sigs-tank s))]))
        (sigs-missile s))]
    ))

; SIGS -> SIGS
; launches the progream from some initial state
(define (si-main u-x t-x)
  (big-bang (make-sigs (make-posn u-x 0) (make-tank t-x TANK_SPEED) #false)
    [on-tick si-move]
    [to-draw si-render]
    [on-key si-control]
    [stop-when si-game-over? si-render-final]))