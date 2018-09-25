;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 100)
(define BAR-HEIGHT 20)
(define DELTA-INCREASE (/ WIDTH-OF-WORLD 5))
(define DELTA-DECREASE (/ WIDTH-OF-WORLD 3))
(define BACKGROUND (rectangle WIDTH-OF-WORLD BAR-HEIGHT "solid" "gray"))

; Number Color -> Image
; Draws happiness gauge
(define (gauge-prog width color)
  (overlay/xy
   (rectangle width BAR-HEIGHT "solid" color)
   0 0
   BACKGROUND
   )
)

; AnimationState -> Image
; places the image of the cat x pixels from 
; the left margin of the BACKGROUND image 
(define (render as)
  (gauge-prog as "red")
)

; Number -> Number
; Adds 3 to the x position
(define (tock x)
  (cond
    [(< x 0) 0]
    [(> x WIDTH-OF-WORLD) WIDTH-OF-WORLD]
    [else (- x 0.1)]
  )
)

; AnimationState Key -> AnimationState
; Adds or substracts 
(define (change w a-key)
  (cond
    [(key=? a-key "up")    (- w DELTA-DECREASE)]
    [(key=? a-key "down")  (+ w DELTA-INCREASE)]
  )
)

(define (main as)
   (big-bang as
     [on-tick tock]
     [on-key change]
     [to-draw render]
  )
)

(main 100)






