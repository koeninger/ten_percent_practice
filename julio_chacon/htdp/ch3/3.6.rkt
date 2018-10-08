;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |3.6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (empty-scene 100 100))
(define WIDTH-OF-WORLD 200)
 
(define WHEEL-RADIUS 5)


(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))


(define SPACE
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR-BODY
  (overlay/offset (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 2) "solid" "red")
                  0 (* WHEEL-RADIUS 1.5)
                  (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red"))
)

(define CAR
 (overlay/xy
      BOTH-WHEELS
       (- (* .5 (image-width BOTH-WHEELS) ) (* .5 (image-width  CAR-BODY)) ) (- (* .5 (image-height BOTH-WHEELS)) (image-height CAR-BODY) )
       CAR-BODY)
  )

CAR