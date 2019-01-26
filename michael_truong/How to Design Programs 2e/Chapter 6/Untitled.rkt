#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require test-engine/racket-tests)

(define-struct vel [dx dy])

(define-struct ufo [posn vel])
(define-struct tank [posn vel])
(define-struct missile [posn vel])

(define-struct aim [tank ufo])
(define-struct fired [tank ufo missile])
                         
(define BACKGROUND-WIDTH 300)
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT "white"))

(define SQUARE-LENGTH 1)
(define X (square SQUARE-LENGTH "solid" "black"))
(define O (square SQUARE-LENGTH "solid" (make-color 255 255 255 0)))

(define UFO-IMAGE (scale 50 X))

(define UFO-WIDTH (image-width UFO-IMAGE))
(define UFO-HEIGHT (image-height UFO-IMAGE))

(define UFO-X-MIN (/ UFO-WIDTH 2))
(define UFO-X-MAX (- BACKGROUND-WIDTH (/ UFO-WIDTH 2)))
(define UFO-Y-MIN (/ UFO-HEIGHT 2))
(define UFO-Y-MAX (- BACKGROUND-HEIGHT (/ UFO-HEIGHT 2)))

(define UFO-DX 0)
(define UFO-DY 100)
(define UFO-VEL (make-vel UFO-DX UFO-DY))

(define (rand min max)
  (+ min (random (- max min))))

(define (move-position2 p v x-min x-max y-min y-max)
  (make-posn (min (max (+ (posn-x p) (vel-dx v)) x-min) x-max)
             (min (max (+ (posn-y p) (vel-dy v)) y-min) y-max)))

(define (limit y)
  (cond
    [(> y UFO-Y-MAX) UFO-Y-MAX]
    [else y]))

(define (move-position p v x-min x-max y-min y-max)
  (make-posn (+ (posn-x p) (vel-dx v))
             (limit (+ (posn-y p) (vel-dy v)))))

(define (move-ufo2 u)
  (make-ufo (move-position (ufo-posn u)
                           (make-vel (rand (- (vel-dx (ufo-vel u)))
                                           (vel-dx (ufo-vel u)))
                                     (vel-dy (ufo-vel u)))
                           UFO-X-MIN UFO-X-MAX UFO-Y-MIN UFO-Y-MAX)
            (ufo-vel u)))

(define (move-ufo u)
  (make-ufo (move-position (ufo-posn u)
                           (ufo-vel u)
                           UFO-X-MIN UFO-X-MAX UFO-Y-MIN UFO-Y-MAX)
            (ufo-vel u)))

(define (si-move s)
  (move-ufo s))

(define (si-render s)
  (place-images (list UFO-IMAGE)
                             (list (ufo-posn s))
                             BACKGROUND))

(define (si-game-over? s)
  (= (posn-y (ufo-posn s)) UFO-Y-MAX))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [stop-when si-game-over?]))

(posn-y (ufo-posn (si (make-ufo (make-posn UFO-X-MIN 0) UFO-VEL))))
(+ 0 UFO-Y-MAX)