;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |94|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 300)

(define WHEEL-RADIUS 3)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define Y-TANK (- HEIGHT-OF-WORLD (* 0 WHEEL-RADIUS)))

(define SPACE
  (rectangle WHEEL-RADIUS (* 2 WHEEL-RADIUS) "solid" "transparent"))

(define SPACE2
  (rectangle (* WHEEL-RADIUS 10) (* 2 WHEEL-RADIUS) "solid" "transparent"))

(define ALLWHEELS
  (beside WHEEL SPACE WHEEL SPACE WHEEL SPACE WHEEL))

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
  (beside TREE SPACE2 TREE SPACE2 TREE SPACE2 TREE))

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

(place-image
 TANK 100 Y-TANK
 (place-image 
  UFO 100 Y-UFO
  BACKGROUND)
)
