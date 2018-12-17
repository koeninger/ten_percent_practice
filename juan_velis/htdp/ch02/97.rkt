;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |97|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


(ufo-render
  (fired-ufo s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s)
                               BACKGROUND)))

(define-struct aim [posn tank])
(define-struct fired [posn tank missile])

(define A1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
(define A2
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- HEIGHT-OF-WORLD TANK-HEIGHT))))
(define A3
(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103)))


(place-image
 TANK (tank-loc (aim-tank A1)) Y-TANK
 (place-image 
  UFO (posn-x (aim-posn A1)) (posn-y (aim-posn A1))
  BACKGROUND)
)

(place-image
 TANK (tank-loc (fired-tank A2)) Y-TANK
 (place-image 
  MISSILE (posn-x (fired-missile A2)) (posn-y (fired-missile A2))
  (place-image 
   UFO (posn-x (fired-posn A2)) (posn-y (fired-posn A2))
   BACKGROUND)
  )
)

(place-image
 TANK (tank-loc (fired-tank A3)) Y-TANK
 (place-image 
  MISSILE (posn-x (fired-missile A3)) (posn-y (fired-missile A3))
  (place-image 
   UFO (posn-x (fired-posn A3)) (posn-y (fired-posn A3))
   BACKGROUND)
  )
)