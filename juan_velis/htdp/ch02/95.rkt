;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |95|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 300)

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
      (rectangle 15 (* WHEEL-RADIUS 2) "solid" "Dark Olive Green")
      (rectangle 33 (* WHEEL-RADIUS 4) "solid" "Dark Olive Green"))
  )
)

(define UFO (overlay (circle 10 "solid" "SteelBlue") (ellipse 40 8 "solid" "SteelBlue")))
(define Y-UFO 50)

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

; Ex. 95. The three previous instances are generated according
; to the first or second clause of the data definition because
; they depend on the tank and UFO structures.

(place-image
 TANK 100 Y-TANK
 (place-image 
  UFO 100 Y-UFO
  BACKGROUND)
)
