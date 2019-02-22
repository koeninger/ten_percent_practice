#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require test-engine/racket-tests)

(define-struct vel [dx dy])
(define-struct ufo [img posn vel])
(define-struct tank [img posn vel])
(define-struct missile [img posn vel])
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

(define TANK-DX 3)
(define TANK-DY 0)

(define MISSILE-IMAGE (scale 1 (above X
                                      X
                                      X)))

(define MISSILE-DX 0)
(define MISSILE-DY -20)
(define MISSILE-VEL (make-vel MISSILE-DX MISSILE-DY))

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
            (move-position (ufo-img u) (ufo-posn u) (make-vel (random (neg (vel-dx (ufo-vel u)))
                                                                      (vel-dx (ufo-vel u)))
                                                              (vel-dy (ufo-vel u))))
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

(define (si-move s)
  (make-sigs (cond
               [(boolean? (sigs-ufo s)) (make-ufo UFO-IMAGE
                                                  (make-posn (/ SPACE-WIDTH 2) (x-min (UFO-IMAGE)))
                                                  (make-vel UFO-DX UFO-DY))]
               [else (ufo-move (sigs-ufo s))])
             (tank-move (sigs-tank s))
             (missile-move (sigs-missile s))))

(define (si-render s)
  (cond
    [(boolean? (sigs-missile s)) (place-images (list (ufo-img (sigs-ufo s))
                                                     (tank-img (sigs-tank s)))
                                               (list (ufo-posn (sigs-ufo s))
                                                     (tank-posn (sigs-tank s)))
                                               SPACE)]
    [else (place-images (list (ufo-img (sigs-ufo s))
                              (tank-img (sigs-tank s))
                              (missile-img (sigs-missile s)))
                        (list (ufo-posn (sigs-ufo s))
                              (tank-posn (sigs-tank s))
                              (missile-posn (sigs-missile s)))
                        SPACE)]))

(define (neg n)
  (- (abs n)))

(define (pos n)
  (abs n))

(define (tank-change-directions t key)
  (make-tank TANK-IMAGE
             (tank-posn t)
             (make-vel (cond
                         [(key=? key "left") (neg (vel-dx (tank-vel t)))]
                         [(key=? key "right") (pos (vel-dx (tank-vel t)))]
                         [else (vel-dx (tank-vel t))])
                       (vel-dy (tank-vel t)))))

(define (missile-launch t m key)
  (cond
    [(boolean? m) (cond
                    [(key=? key " ") (make-missile MISSILE-IMAGE
                                                   (tank-posn t)
                                                   (make-vel MISSILE-DX MISSILE-DY))]
                    [else m])]
    [else m]))
                  

(define (si-control s key)
  (make-sigs (sigs-ufo s)
             (tank-change-directions (sigs-tank s) key)
             (missile-launch (sigs-tank s) (sigs-missile s) key)))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]))

(si (make-sigs #false
               (make-tank TANK-IMAGE
                          (make-posn (/ SPACE-WIDTH 2)
                                     (y-max TANK-IMAGE))
                          (make-vel TANK-DX TANK-DY))
               #false))

;function headers, tests
;redo cat, cham, si1
;check chapters 2-present