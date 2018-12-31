;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |100|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 200)

(define WHEEL-RADIUS 3)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define Y-TANK (- HEIGHT-OF-WORLD (* 0 WHEEL-RADIUS)))

(define SPACER
  (rectangle WHEEL-RADIUS (* 2 WHEEL-RADIUS) "solid" "transparent"))

(define SPACER2
  (rectangle (* WHEEL-RADIUS 10) (* 2 WHEEL-RADIUS) "solid" "transparent"))

(define ALLWHEELS
  (beside WHEEL SPACER WHEEL SPACER WHEEL SPACER WHEEL))

(define TANK
  (overlay/xy
     ALLWHEELS
     (* WHEEL-RADIUS 0) (* WHEEL-RADIUS -5)
     (above
      (rectangle 5 (* WHEEL-RADIUS 2) "solid" "Dark Olive Green")
      (rectangle 33 (* WHEEL-RADIUS 4) "solid" "Dark Olive Green"))
  )
)
(define TANK-HEIGHT (image-height TANK))

(define UFO (overlay (circle 10 "solid" "SteelBlue") (ellipse 40 8 "solid" "SteelBlue")))
(define Y-UFO 50)

(define MISSILE (circle 3 "solid" "Black"))

(define SPEED 2)
(define UFO-DELTA 7)

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 22 "solid" "brown")))
(define TREES
  (beside TREE SPACER2 TREE SPACER2 TREE SPACER2 TREE))

(define BACKGROUND
  (overlay/xy
   TREES
   -10 (* (- HEIGHT-OF-WORLD (* 12 WHEEL-RADIUS)) -1)
   (above
    (rectangle WIDTH-OF-WORLD HEIGHT-OF-WORLD "solid" "Azure")
    (rectangle WIDTH-OF-WORLD (* WHEEL-RADIUS 6) "solid" "gray")
    )
  )
)

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
;
; (make-aim (make-posn 20 10) (make-tank 28 -3))
;     (make-fired (make-posn 20 10)
;                (make-tank 28 -3)
;                (make-posn 28 (- HEIGHT TANK-HEIGHT)))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define-struct ufo [x y])
(define-struct missile [x y])

(define A1 (make-aim (make-ufo 20 10) (make-tank 28 -3)))
(define A2
  (make-fired (make-ufo 20 10)
              (make-tank 28 -3)
              (make-missile 28 (- HEIGHT-OF-WORLD TANK-HEIGHT))))
(define A3
(make-fired (make-ufo 20 100)
            (make-tank 100 3)
            (make-missile 22 103)))


; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene
(define (si-render s)
  (cond
    [(aim? s) (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND) )]
    [(fired? s) (tank-render (fired-tank s)
                   (ufo-render (fired-ufo s)
                               (missile-render (fired-missile s) BACKGROUND))
       )])
)

; Tank Img -> Image
; renders tank
(define (tank-render s back)
  (place-image TANK (tank-loc s) Y-TANK back))

; UFO Img -> Image
; renders ufo
(define (ufo-render s back)
  (place-image UFO (ufo-x s) (ufo-y s) back))

; Missile Img -> Image
; render missile
(define (missile-render s back)
  (place-image MISSILE (missile-x s) (missile-y s) back))


; UFO -> Bool
(define (ufo-landed? u)
  (>= (ufo-y u) (- HEIGHT-OF-WORLD (image-height UFO)))
)
(check-expect (ufo-landed? (make-ufo 50 200)) #true)

; UFO MISSILE -> Bool
(define (ufo-hit? u m)
  (and (<= (abs (- (ufo-x u) (missile-x m)))
           (+ (image-width UFO) (image-width MISSILE)))
       (<= (abs (- (ufo-y u) (missile-y m)))
           (+ (image-height UFO) (image-height MISSILE)))
  )
)
(check-expect (ufo-hit? (make-ufo 50 100) (make-missile 50 100)) #true)

; SIGS -> bool
; Returns true if the UFO lands or Missile hits it
(define (si-game-over? s)
  (cond [(aim? s) (ufo-landed? (aim-ufo s))]
        [(fired? s)
         (or
          (ufo-landed? (fired-ufo s))
          (ufo-hit? (fired-ufo s)
                    (fired-missile s)
          )
         )
        ]
  )
)

; SIGS -> SIGS
; Move
(define (si-move w)
  (si-move-proper w (random 3)))


; SIGS Number -> SIGS
; moves the space-invader objects predictably by delta
; 0=SPEED-1, 1=x-1, 2=x+1
(define (si-move-proper s delta)
  (cond [(aim? s)
         (make-aim (update-ufo (aim-ufo s) delta)
                   (update-tank (aim-tank s)))
        ]
        [(fired? s)
         (make-fired (update-ufo (fired-ufo s) delta)
                     (update-tank (fired-tank s))
                     (update-missile (fired-missile s)))
        ]
  )
)
(check-expect (si-move-proper (make-aim (make-ufo 10 20) (make-tank 50 0)) 0)
              (make-aim (make-ufo 10 (+ 20 (- SPEED UFO-DELTA)))
                        (make-tank 50 0)))

; ufo randomnum[0,1,2] -> ufo
; update a UFO
; 0 SPEED - UFO-DELTA, 1) x - UFO-DELTA, 2) x + UFO-DELTA
(define (update-ufo u r)
  (cond [(= r 0) (make-ufo (ufo-x u) (+ (ufo-y u) (- SPEED UFO-DELTA)))]
        [(= r 1) (make-ufo (- (ufo-x u) UFO-DELTA) (+ (ufo-y u) SPEED))]
        [(= r 2) (make-ufo (+ (ufo-x u) UFO-DELTA) (+ (ufo-y u) SPEED))]))
(check-expect (update-ufo (make-ufo 30 30) 0)
              (make-ufo 30 (+ 30 (- SPEED UFO-DELTA))))

; Tank -> Tank
; update tank
(define (update-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t)))

(check-expect (update-tank (make-tank 20 5)) (make-tank 25 5))


; Missile -> Missile
; update missile
(define (update-missile m)
  (make-missile (missile-x m) (- (missile-y m) SPEED)))

(check-expect (update-missile (make-missile 1 50)) (make-missile 1 (- 50 SPEED)))

; SIGS KeyEvent -> SIG
; Keyboard control the tank
(define (si-control s key)
  (cond [(key=? key "left") (tank-left s)]
        [(key=? key "right") (tank-right s)]
        ;[(key=? key " ") (fire-missile s)]
[else s]))


; SIGS -> SIGS
; Turn tank to the left
(define (tank-left s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (tank-turn-left (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (tank-turn-left (fired-tank s))
                     (fired-missile s))]
  )
)

; tank -> tank
(define (tank-turn-left t)
  (cond [(<= 0 (tank-vel t))
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]
  )
)

; SIGS -> SIGS
; Turn tank to the right
(define (tank-right s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (tank-turn-right (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (tank-turn-right (fired-tank s))
                     (fired-missile s))]
  )
)

; tank -> tank
(define (tank-turn-right t)
  (cond [(< (tank-vel t) 0)
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]
  )
)



; main
(define (main g)
  (big-bang g 
    [on-tick si-move 0.1]
    (to-draw si-render) 
    ;(on-key)
    (stop-when si-game-over?)
))

(main A2)
