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
    [(aim? s) (place-images
               (list IMAGE-TANK)
               (list (tank-posn (aim-tank s)))
               BACKGROUND)]
    [else 0]))

;CHECK FUNCTION HEADERS

(define (si-control s key)
  (cond
    [(aim? s) (make-aim (make-tank (make-posn) ()) (aim-ufo s))]
    
    [(fired? s) s]
    [else s]))

(define (si s)
   (big-bang s
     [to-draw si-render]
     [on-key si-control]))

(si (make-aim (make-tank (make-posn 0 0) (make-vel 0 0)) (make-ufo (make-posn 0 0) (make-vel 0 0))))