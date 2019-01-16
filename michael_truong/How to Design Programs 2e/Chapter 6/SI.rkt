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

(define SQUARE-LENGTH 4)
(define X (square SQUARE-LENGTH "solid" "black"))
(define O (square SQUARE-LENGTH "solid" (make-color 255 255 255 0)))

(define UFO-IMAGE (scale 1 (above (beside O O X O O O O O X O O)
                                  (beside O O O X O O O X O O O)
                                  (beside O O X X X X X X X O O)
                                  (beside O X X O X X X O X X O)
                                  (beside X X X X X X X X X X X)
                                  (beside X O X X X X X X X O X)
                                  (beside X O X O O O O O X O X)
                                  (beside O O O X X O X X O O O))))

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
                         

(define BACKGROUND-WIDTH 200)
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT "white"))

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene

(define (si-move s)
  (cond
    [(aim? s) (make-aim (aim-tank s) (move-ufo (aim-ufo s)))]
    [(fired? s) (make-fire (aim-tank s) (move-ufo (aim-ufo s)) (move-missile (aim-missile s)))]
    [else s]))

(define (si-render s)
  (cond
    [(aim? s) (place-images (list TANK-IMAGE
                                  UFO-IMAGE)
                            (list (tank-posn (aim-tank s))
                                  (ufo-posn (aim-ufo s)))
                            BACKGROUND)]
    [else 0]))

(define (move-position p v)
  (make-posn (+ (posn-x p) (vel-dx v))
             (+ (posn-y p) (vel-dy v))))

(define (move-tank t key)
  (make-tank (move-position (tank-posn t)
                            (make-vel (* (vel-dx (tank-vel t)) (cond
                                                                 [(key=? key "left") -1]
                                                                 [(key=? key "right") 1]
                                                                 [else 0]))
                                      (* (vel-dy (tank-vel t)) (cond
                                                                 [(key=? key "up") -1]
                                                                 [(key=? key "down") 1]
                                                                 [else 0]))))
             (tank-vel t)))

(define (move-missile m)
  (make-missile (move-position (missile-posn m)
                               (missile-vel m))
                (missile-vel m)))

(define (move-ufo u)
  (make-ufo (move-position (ufo-posn u)
                           (ufo-vel u))
            (ufo-vel u)))

(define (si-control s key)
  (cond
    [(aim? s) (cond
                [(key=? key " ") s]
                [else (make-aim (move-tank (aim-tank s) key)
                                (aim-ufo s))])]
    [(fired? s) (make-aim (move-tank (fired-tank s) key) (fired-ufo s) (fired-missile s))]
    [else s]))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]))

(define TANK-DX 10)
(define TANK-DY 10)
(define TANK-VEL (make-vel TANK-DX TANK-DY))

(si (make-aim (make-tank (make-posn 0 0) TANK-VEL) (make-ufo (make-posn 0 0) (make-vel 1 1))))

;OOB