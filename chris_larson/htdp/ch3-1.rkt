;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch3-1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define WIDTH-OF-WORLD 300)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define BUMPER-DISTANCE (* WHEEL-RADIUS 8))
(define TRUNK-HEIGHT (* WHEEL-RADIUS 2))
(define ROOF-HEIGHT WHEEL-RADIUS)
(define ROOF-WIDTH (* WHEEL-RADIUS 4))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD 50))
(define Y-CAR 15)

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle WHEEL-DISTANCE 1 "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define BASE
  (rectangle BUMPER-DISTANCE TRUNK-HEIGHT "solid" "red"))
(define TOP
  (rectangle ROOF-WIDTH ROOF-HEIGHT "solid" "red"))
(define BODY
  (above TOP BASE))
(define CAR
  (underlay/offset
   BODY
   0 (* WHEEL-RADIUS 3/2)
   BOTH-WHEELS))
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

; WorldState: data that represents the state of the world (cw)
; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

; WorldState -> Image
; when needed, big-bang obtains the image of the current
; state of the world by evaluating (render cw)
(define (render ws)
  (place-image CAR (- ws (/ BUMPER-DISTANCE 2)) Y-CAR (overlay/align "left" "center" TREE BACKGROUND)))

; World State -> WorldState
; for each tick of the clock, big-bang obtains the next
; state of the world from (clock-tick-handler cw)
; given: 20, expect 23
; given: 78, expect 81
(define (tock ws)
  (+ ws 3))
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; WorldState String -> WorldState
; for each keystroke, big-bang obtains the next state
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke) ...)

; WorldState Number Number String -> WorldState
; for each mouse gesture, big-bang obtains the next state
; from (mouse-event-handler cw x y me) where x and y are
; the coordinates of the event and me is its description
(define (mouse-event-handler cw x y me) ...)

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
(define (end? cw) (> cw (+ WIDTH-OF-WORLD BUMPER-DISTANCE)))
(check-expect (end? 1) #false)
(check-expect (end? (+ WIDTH-OF-WORLD BUMPER-DISTANCE 1)) #true)

; WorldState -> WorldState
; launches the program form some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))

; scratch
(main 50)