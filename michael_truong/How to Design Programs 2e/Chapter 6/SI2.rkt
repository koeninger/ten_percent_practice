#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require test-engine/racket-tests)

(define-struct vel [dx dy])
(define-struct ufo [posn vel])
(define-struct tank [posn vel])
(define-struct missile [posn vel])
(define-struct sigs [ufo tank missile])
                         
(define SPACE-WIDTH 300)
(define SPACE-HEIGHT SPACE-WIDTH)
(define SPACE (empty-scene SPACE-WIDTH SPACE-HEIGHT "white"))

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

(define UFO-WIDTH (image-width UFO-IMAGE))
(define UFO-HEIGHT (image-height UFO-IMAGE))

(define UFO-X-MIN (/ UFO-WIDTH 2))
(define UFO-X-MAX (- SPACE-WIDTH (/ UFO-WIDTH 2)))
(define UFO-Y-MIN (- (/ UFO-HEIGHT 2)))
(define UFO-Y-MAX (- SPACE-HEIGHT (/ UFO-HEIGHT 2)))

(define UFO-DX 3)
(define UFO-DY 3)

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
(define TANK-X-MAX (- SPACE-WIDTH (/ TANK-WIDTH 2)))
(define TANK-Y-MIN (/ TANK-HEIGHT 2))
(define TANK-Y-MAX (- SPACE-HEIGHT (/ TANK-HEIGHT 2)))

(define TANK-DX 3)
(define TANK-DY 0)

(define MISSILE-IMAGE (scale 1 (above X
                                      X
                                      X)))

(define MISSILE-WIDTH (image-width MISSILE-IMAGE))
(define MISSILE-HEIGHT (image-height MISSILE-IMAGE))

(define MISSILE-X-MIN (/ MISSILE-WIDTH 2))
(define MISSILE-X-MAX (- SPACE-WIDTH (/ MISSILE-WIDTH 2)))
(define MISSILE-Y-MIN (- (/ MISSILE-HEIGHT 2)))
(define MISSILE-Y-MAX (- SPACE-HEIGHT (/ MISSILE-HEIGHT 2)))

(define MISSILE-DX 0)
(define MISSILE-DY -20)
(define MISSILE-VEL (make-vel MISSILE-DX MISSILE-DY))

(define (si-render s)
  (cond
    [(boolean? (sigs-missile s)) (place-images (list UFO-IMAGE
                                                     TANK-IMAGE)
                                               (list (ufo-posn (sigs-ufo s))
                                                     (tank-posn (sigs-tank s)))
                                               SPACE)]
    [else (place-images (list UFO-IMAGE
                              TANK-IMAGE
                              MISSILE-IMAGE)
                        (list (ufo-posn (sigs-ufo s))
                              (tank-posn (sigs-tank s))
                              (missile-posn (sigs-missile s))))]))

(define (neg n)
  (- (abs n)))

(define (pos n)
  (abs n))

(define (tank-change-directions t key)
  (make-tank (tank-posn t)
             (make-vel (cond
                         [(key=? key "left") (neg (vel-dx (tank-vel t)))]
                         [(key=? key "right") (pos (vel-dx (tank-vel t)))]
                         [else (vel-dx (tank-vel t))])
                       (vel-dy (tank-vel t)))))

(define (missile-launch t)
  (make-missile (tank-posn t)
                (make-vel MISSILE-DX MISSILE-DY)))

(define (si-control s key)
  (make-sigs (sigs-ufo)
             (tank-change-directions (sigs-tank s) key)
             (cond
               [(boolean? (sigs-missile s)) (sigs-missile s)]
               [else (missile-launch (sigs-tank s))])))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]
     [stop-when si-game-over? si-render]))

;function headers, tests