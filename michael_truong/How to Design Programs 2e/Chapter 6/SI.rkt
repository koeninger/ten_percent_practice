#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define-struct vel [dx dy])

(define-struct ufo [p v])
(define-struct tank [p v])
(define-struct missile [p v])

(define-struct aim [tank ufo])
(define-struct fired [tank missile ufo])

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

(define (si-render s)
  (cond
    [(aim? s) (place-images (list IMAGE-TANK)
                            (list (tank-p (aim-tank s)))
                            BACKGROUND)]
    [else 0]))

(define (move-position p v)
  (make-posn (+ (posn-x p) (vel-dx v))
             (+ (posn-y p) (vel-dy v))))

(define (move-tank t key)
  (make-tank (move-position (tank-p t)
                            (make-vel (* (vel-dx (tank-v t)) (cond
                                                               [(key=? key "left") -1]
                                                               [(key=? key "right") 1]
                                                               [else 0]))
                                      (* (vel-dy (tank-v t)) (cond
                                                               [(key=? key "up") -1]
                                                               [(key=? key "down") 1]
                                                               [else 0]))))
             (tank-v t)))

(define (move-missile m)
  (make-missile (move-position (missile-p m)
                               (missile-v m))
                (missile-v m)))

(define (move-ufo u)
  (make-ufo (move-position (ufo-p u)
                           (ufo-v u))
            (ufo-v u)))

(define (si-control s key)
  (cond
    [(aim? s) (make-aim (move-tank (aim-tank s) key) (aim-ufo s))]
    [(fired? s) s]
    [else s]))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]))

(si (make-aim (make-tank (make-posn 0 0) (make-vel 3 3)) (make-ufo (make-posn 0 0) (make-vel 0 0))))

;OOB