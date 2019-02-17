#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require test-engine/racket-tests)

(define-struct vel [dx dy])

(define-struct ufo [posn vel])
(define-struct tank [posn vel])
(define-struct missile [posn vel])

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
                         
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

(define TANK-DX 3)
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
(define UFO-Y-MIN (- (/ UFO-HEIGHT 2)))
(define UFO-Y-MAX (- BACKGROUND-HEIGHT (/ UFO-HEIGHT 2)))

(define UFO-DX 3)
(define UFO-DY 3)
(define UFO-VEL (make-vel UFO-DX UFO-DY))

(define MISSILE-IMAGE (scale 1 (above X
                                      X
                                      X)))

(define MISSILE-WIDTH (image-width MISSILE-IMAGE))
(define MISSILE-HEIGHT (image-height MISSILE-IMAGE))

(define MISSILE-X-MIN (/ MISSILE-WIDTH 2))
(define MISSILE-X-MAX (- BACKGROUND-WIDTH (/ MISSILE-WIDTH 2)))
(define MISSILE-Y-MIN (- (/ MISSILE-HEIGHT 2)))
(define MISSILE-Y-MAX (- BACKGROUND-HEIGHT (/ MISSILE-HEIGHT 2)))

(define MISSILE-DX 0)
(define MISSILE-DY -20)
(define MISSILE-VEL (make-vel MISSILE-DX MISSILE-DY))

(define (random-between min max)
  (+ min (random (- max min))))

(define (x-min img)
  (/ (image-width img) 2))

(define (x-max img)
  (- SPACE-WIDTH (/ (image-width img) 2)))

(define (y-min img)
  (/ (image-height img) 2))

(define (y-max img)
  (- SPACE-HEIGHT (/ (image-height img) 2)))

(define (move-position img p v)
  (make-posn (min (max (+ (posn-x p) (vel-dx v)) (x-min img)) (x-max img))
             (min (max (+ (posn-y p) (vel-dy v)) (y-min img)) (y-max img))))

(define (ufo-move u)
  (make-ufo (ufo-img u)
            (move-position (ufo-img u) (ufo-posn u) (ufo-vel u))
            (ufo-vel u)))

(define (tank-move t)
  (make-tank (tank-img t)
             (move-position (tank-img t) (tank-posn t) (tank-vel t))
             (tank-vel t)))

(define (missile-move m)
  (cond
    [(boolean? m) m]
    [else (make-missile (missile-img m)
                        (move-position (missile-img m) (missile-posn m) (missile-vel m))
                        (missile-vel m))]))

(define (move-aim a)
  (make-aim (move-tank (aim-tank a))
            (move-ufo (aim-ufo a))))

(define (move-fired f)
  (make-fired (move-tank (fired-tank f))
              (move-ufo (fired-ufo f))
              (move-missile (fired-missile f))))

(define (missile-hit? m u)
  (and (<= (- (posn-x (ufo-posn u)) (/ UFO-WIDTH 2))
           (posn-x (missile-posn m))
           (+ (posn-x (ufo-posn u)) (/ UFO-WIDTH 2)))
       (<= (- (posn-y (ufo-posn u)) (/ UFO-HEIGHT 2))
           (- (posn-y (missile-posn m)) (/ MISSILE-HEIGHT 2))
           (+ (posn-y (ufo-posn u)) (/ UFO-HEIGHT 2)))))

(define (collision? i1 p1 i2 p2)
  (< (sqrt (+ (sqr (- (posn-x p1)
                      (posn-x p2)))
              (sqr (- (posn-y p1)
                      (posn-y p2)))))
     (+ (min (image-width i1) (image-height i1))
        (min (image-width i2) (image-height i2)))))

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene

(define (si-move s)
  (cond
    [(tank? s) (make-aim (move-tank s)
                         (make-ufo (make-posn (random-between UFO-X-MIN UFO-X-MAX)
                                              UFO-Y-MIN)
                                   UFO-VEL))]
    [(aim? s) (move-aim s)]
    [(fired? s) (cond
                  [(missile-hit? (fired-missile s) (fired-ufo s)) (move-tank (fired-tank s))]
                  [(<= (posn-y (missile-posn (fired-missile s))) MISSILE-Y-MIN) (move-aim (make-aim (fired-tank s)
                                                                                                    (fired-ufo s)))]
                  [else (move-fired s)])]
    [else s]))

(define (si-render s)
  (cond
    [(tank? s) (place-images (list TANK-IMAGE)
                             (list (tank-posn s))
                             BACKGROUND)]
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
    [else BACKGROUND]))

(define (tank-change-directions t key)
  (make-tank (tank-posn t)
             (make-vel (cond
                         [(key=? key "left") (- (abs (vel-dx (tank-vel t))))]
                         [(key=? key "right") (abs (vel-dx (tank-vel t)))]
                         [else (vel-dx (tank-vel t))])
                       (vel-dy (tank-vel t)))))

(define (si-control s key)
  (cond
    [(aim? s) (cond
                [(key=? key " ") (make-fired (aim-tank s)
                                             (aim-ufo s)
                                             (make-missile (tank-posn (aim-tank s)) MISSILE-VEL))]
                [(or (key=? key "left")
                     (key=? key "right")) (make-aim (tank-change-directions (aim-tank s) key)
                                                    (aim-ufo s))]
                [else s])]
    [(fired? s) (cond
                  [(or (key=? key "left")
                       (key=? key "right")) (make-fired (tank-change-directions (fired-tank s) key)
                                                        (fired-ufo s)
                                                        (fired-missile s))]
                  [else s])]
    [else s]))

(define (ufo-has-landed? u)
  (>= (posn-y (ufo-posn u)) UFO-Y-MAX))

(define (si-game-over? s)
  (cond
    [(tank? s) #false]
    [(aim? s) (ufo-has-landed? (aim-ufo s))]
    [(fired? s) (ufo-has-landed? (fired-ufo s))]
    [else #false]))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]
     [stop-when si-game-over? si-render]))

(si (make-tank (make-posn (/ (+ TANK-X-MIN TANK-X-MAX) 2) TANK-Y-MAX) TANK-VEL))