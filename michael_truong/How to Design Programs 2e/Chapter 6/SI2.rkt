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

(define (si-control s key)
  (make-sigs (sigs-ufo)
             (cond
               [(boolean? (sigs-tank s)) (sigs-tank s)]
               [else (make-tank
                      (tank-posn (sigs-tank s))
                      (make-vel (cond
                                  [(key=? key "left") (- (abs (vel-dx (tank-vel (sigs-tank s)))))]
                                  [(key=? key "right") (abs (vel-dx (tank-vel (sigs-tank s))))]
                                  [else (vel-dx (tank-vel (sigs-tank s)))])
                                (vel-dy (tank-vel (sigs-tank s)))))])
             (sigs-missile)))

(define (si s)
   (big-bang s
     [on-tick si-move]
     [to-draw si-render]
     [on-key si-control]
     [stop-when si-game-over? si-render]))