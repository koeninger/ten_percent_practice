#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define SQUARE-LENGTH 4)
(define X (square SQUARE-LENGTH "solid" "black"))
(define O (square SQUARE-LENGTH "solid" (make-color 255 255 255 0)))

(define IMAGE-UFO (above (beside O O X O O O O O X O O)
                         (beside O O O X O O O X O O O)
                         (beside O O X X X X X X X O O)
                         (beside O X X O X X X O X X O)
                         (beside X X X X X X X X X X X)
                         (beside X O X X X X X X X O X)
                         (beside X O X O O O O O X O X)
                         (beside O O O X X O X X O O O)))

(define IMAGE-TANK (above (beside O O O O O O O X O O O O O O O)
                          (beside O O O O O O O X O O O O O O O)
                          (beside O O O O O O O X O O O O O O O)
                          (beside O O O O O O X X X O O O O O O)
                          (beside O O O O O O X X X O O O O O O)
                          (beside O O O O O O X X X O O O O O O)
                          (beside O O O X O O X X X O O X O O O)
                          (beside O O O X O X X X X X O X O O O)
                          (beside X O O X X X X X X X X X O O X)
                          (beside X O O X X X X X X X X X O O X)
                          (beside X O O X X X X X X X X X O O X)
                          (beside X O X X X X X X X X X X X O X)
                          (beside X X X X X X X X X X X X X X X)
                          (beside X X X O X X X X X X X O X X X)
                          (beside X X O O X X O X O X X O O X X)
                          (beside X O O O O O O X O O O O O O X)))
                         

(define BACKGROUND-WIDTH (* SQUARE-LENGTH 50))
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT "white"))

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene
(define (si-render s) (overlay IMAGE-TANK BACKGROUND))

(define (si vc)
   (big-bang vc
     [to-draw si-render]))

(si 0)