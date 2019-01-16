#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define-struct vel [dx dy])

(define-struct ufo [posn vel])
(define-struct tank [posn vel])
(define-struct missile [posn vel])

(define-struct aim [tank ufo])
(define-struct fired [tank ufo missile])
                         
(define BACKGROUND-WIDTH 300)
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT "white"))

(define SQUARE-LENGTH 4)
(define X (square SQUARE-LENGTH "solid" "black"))
(define O (square SQUARE-LENGTH "solid" (make-color 255 255 255 0)))

(define TANK-IMAGE (scale 1/2 (above (beside O O O O O O O X O O O O O O O)
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
                                     (beside X O O O O O O X O O O O O O X))))

(define TANK-WIDTH (image-width TANK-IMAGE))
(define TANK-HEIGHT (image-height TANK-IMAGE))

(define TANK-X-MIN (/ TANK-WIDTH 2))
(define TANK-X-MAX (- BACKGROUND-WIDTH (/ TANK-WIDTH 2)))
(define TANK-Y-MIN (/ TANK-HEIGHT 2))
(define TANK-Y-MAX (- BACKGROUND-HEIGHT (/ TANK-HEIGHT 2)))

(define TANK-DX 1)
(define TANK-DY 0)
(define TANK-VEL (make-vel TANK-DX TANK-DY))

(define UFO-IMAGE (scale 1 (above (beside O O X O O O O O X O O)
                                  (beside O O O X O O O X O O O)
                                  (beside O O X X X X X X X O O)
                                  (beside O X X O X X X O X X O)
                                  (beside X X X X X X X X X X X)
                                  (beside X O X X X X X X X O X)
                                  (beside X O X O O O O O X O X)
                                  (beside O O O X X O X X O O O))))

(define UFO-WIDTH (image-width UFO-IMAGE))
(define UFO-HEIGHT (image-height UFO-IMAGE))

(define UFO-X-MIN (/ UFO-WIDTH 2))
(define UFO-X-MAX (- BACKGROUND-WIDTH (/ UFO-WIDTH 2)))
(define UFO-Y-MIN (/ UFO-HEIGHT 2))
(define UFO-Y-MAX (- BACKGROUND-HEIGHT (/ UFO-HEIGHT 2)))

(define UFO-DX 0)
(define UFO-DY 0)
(define UFO-VEL (make-vel UFO-DX UFO-DY))

(define MISSILE-IMAGE (scale 1 (above X
                                      X
                                      X
                                      X)))

(define MISSILE-WIDTH (image-width MISSILE-IMAGE))
(define MISSILE-HEIGHT (image-height MISSILE-IMAGE))

(define MISSILE-X-MIN (/ MISSILE-HEIGHT 2))
(define MISSILE-X-MAX (- BACKGROUND-WIDTH (/ MISSILE-WIDTH 2)))
(define MISSILE-Y-MIN (/ MISSILE-HEIGHT 2))
(define MISSILE-Y-MAX (- BACKGROUND-HEIGHT (/ MISSILE-HEIGHT 2)))

(define MISSILE-DX -10)
(define MISSILE-DY -10)
(define MISSILE-VEL (make-vel MISSILE-DX MISSILE-DY))

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene

(define (si-move s)
  (cond
    [(aim? s) (make-aim (move-tank (aim-tank s))
                        (move-ufo (aim-ufo s)))]
    [(fired? s) (make-fired (move-tank (fired-tank s))
                            (move-ufo (fired-ufo s))
                            (move-missile (fired-missile s)))]
    [else s]))

(define (si-render s)
  (cond
    [(aim? s) (place-images (list TANK-IMAGE
                                  UFO-IMAGE)
                            (list (tank-posn (aim-tank s))
                                  (ufo-posn (aim-ufo s)))
                            BACKGROUND)]
    [(fired? s) (place-images (list TANK-IMAGE
                                    UFO-IMAGE
                                    MISSILE-IMAGE)
                              (list (tank-posn (fired-tank s))
                                    (ufo-posn (fired-ufo s))
                                    (missile-posn (fired-missile s)))
                              BACKGROUND)]
    [else 0]))

(define (limit-position p x-min x-max y-min y-max)
  (make-posn (min (max (posn-x p) x-min) x-max)
             (min (max (posn-y p) y-min) y-max)))

(define (move-position p v)
  (make-posn (+ (posn-x p) (vel-dx v))
             (+ (posn-y p) (vel-dy v))))

(define (move-tank t)
  (make-tank (limit-position (move-position (tank-posn t)
                                            (tank-vel t))
                             TANK-X-MIN TANK-X-MAX TANK-Y-MIN TANK-Y-MAX)
             (tank-vel t)))

(define (move-missile m)
  (make-missile (limit-position (move-position (missile-posn m)
                                               (missile-vel m))
                                MISSILE-X-MIN MISSILE-X-MAX MISSILE-Y-MIN MISSILE-Y-MAX)
                (missile-vel m)))

(define (move-ufo u)
  (make-ufo (limit-position (move-position (ufo-posn u)
                                           (ufo-vel u))
                             UFO-X-MIN UFO-X-MAX UFO-Y-MIN UFO-Y-MAX)
            (ufo-vel u)))

(define (tank-change-directions t key)
  (make-tank (tank-posn t) (cond
                             [(key=? key "left") (make-vel (* TANK-DX -1) TANK-DY)]
                             [(key=? key "right") (make-vel TANK-DX TANK-DY)]
                             [else (tank-vel t)])))

(define (si-control s key)
  (cond
    [(aim? s) (cond
                [(key=? key " ") (make-fired (aim-tank s)
                                             (aim-ufo s)
                                             (make-missile (tank-posn (aim-tank s)) MISSILE-VEL))]
                [else (make-aim (tank-change-directions (aim-tank s) key)
                                (aim-ufo s))])]
    [(fired? s) (make-fired (tank-change-directions (fired-tank s) key)
                            (fired-ufo s)
                            (fired-missile s))]
    [else s]))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]))

(si (make-aim (make-tank (make-posn TANK-X-MIN TANK-Y-MAX) TANK-VEL)
              (make-ufo (make-posn UFO-X-MIN UFO-Y-MIN) UFO-VEL)))