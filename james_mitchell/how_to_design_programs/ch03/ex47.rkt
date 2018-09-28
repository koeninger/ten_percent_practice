;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH-OF-WORLD 110)
(define HEIGHT-OF-WORLD 50)

(define decrease 0.1)
(define down-increase 1.2)
(define up-increase 1.33)

(define BACKGROUND (rectangle WIDTH-OF-WORLD HEIGHT-OF-WORLD "solid" "gray"))

; Number Color -> Image
; Draws happiness gauge
(define (gauge-prog width color)
  (overlay/xy
   (rectangle width HEIGHT-OF-WORLD "solid" color)
   0 0
   BACKGROUND
   )
)

; Number -> Number
; Adds 3 to the x position
(define (tock x)
  (cond
    [(<= x 0) 0]
    [(> x 100) 100]
    [else (- x decrease)]
  )
)
(check-expect (tock 0) 0)
(check-expect (tock 110) 100)
(check-expect (tock 99) 98.9)


; AnimationState -> Image
; places the image of the cat x pixels from 
; the left margin of the BACKGROUND image 
(define (render as)
  (gauge-prog as "red")
)

; AnimationState Key -> AnimationState
; Adds or substracts 
(define (change ws a-key)
  (cond
    [(key=? a-key "up")    (* ws up-increase)]
    [(key=? a-key "down")  (* ws down-increase)]
  )
)


(check-expect (change 50 "up") (* 50 up-increase))
(check-expect (change 50 "down") (* 50 down-increase))


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [on-key change]
     [to-draw render]
))



