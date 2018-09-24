;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex42) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 40)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                         "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BODY-LENGTH (+ WHEEL-DISTANCE (* 4 WHEEL-RADIUS)))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))

(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2)
               "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

;; a car!
(define CAR (overlay/align/offset
             "middle" "bottom"
             BOTH-WHEELS
             0 (- 0 WHEEL-RADIUS)
             BODY))

(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))

(define RIGHTCAR (/ (image-width CAR) 2))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image
                    TREE
                    200 (- HEIGHT-OF-WORLD (/ (image-height TREE) 2))
                    (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

; WorldState -> Image
; places the image of the car x pixels from
; the left margin of the BACKGROUND image
(define (render ws)
  (place-image/align CAR ws Y-CAR "right" "center" BACKGROUND))

(check-expect (render 50) (place-image/align CAR 50 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 200) (place-image/align CAR 200 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 450) (place-image/align CAR 450 Y-CAR "right" "center" BACKGROUND))

; WorldState -> WorldState
; adds 3 to x to move the car right
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)


; WorldState -> Boolean
; Returns true if x is greater than the width of the world+car
(define (limit x)
  (>= x (+ WIDTH-OF-WORLD (image-width CAR)))
)
(check-expect (limit 450) #true)


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when limit]
     ))



              
