;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex43) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


; AnimationState is a Number.
; the number of clock ticks since animation started


; AnimationState -> Image
; big-bang creates image of current state by evaluating (render ca)
(define (render as)
  (place-image CAR as (car-y-position as) BACKGROUND))

; AnimationState -> AnimationState
; for each tick, big-bang gets next state of animation (tick ca)
(define (tock as)
  (+ as 3))

; AnimationState String -> AnimationState
; for each keystroke, big-bang gets next animation state from (keystroke-handler ca ke)
; (define (keystroke-handler ca ke) ...)

; AnimationState Number Number String -> AnimationState
; for reach mouse movement, big-bang obtains next animation state from (mouse-event-handler ca x y me)
; wgere x and y are coords of the event and me is the description
; (define (mouse-event handler ca x y me) ...)

; AnimationState Number -> Number
; for a given state, get y position for car
(define (car-y-position as)
  (+ 25 (* 5 (sin (* 0.1 as)))))

; AnimationState -> Boolean
; after each event, big-bang evaluates (end? ca)
(define (end? ca)
  (> ca SCENE-WIDTH))

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define SCENE-WIDTH 200)
(define BACKGROUND
  (place-image tree (/ SCENE-WIDTH 2) 25 (empty-scene SCENE-WIDTH 50)))

(define WIDTH-OF-WORLD 200)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle 10 WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BODY
  (underlay/offset
    (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red")
    0 (- 0 WHEEL-RADIUS)
    (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 4) "solid" "red")))
  
(define RAW-CAR
  (underlay/offset
   CAR-BODY
   0 (* WHEEL-RADIUS 2)
   BOTH-WHEELS))

; contains transparent pixels to center image on car's right edge
(define CAR
  (beside RAW-CAR
          (rectangle (image-width RAW-CAR) 1 "solid" "transparent")))

; testing
(check-expect (render 50)
              (place-image CAR 50 (car-y-position 50) BACKGROUND))
(check-expect (render 100)
              (place-image CAR 100 (car-y-position 100) BACKGROUND))
(check-expect (render 150)
              (place-image CAR 150 (car-y-position 150) BACKGROUND))
(check-expect (render 200)
              (place-image CAR 200 (car-y-position 200) BACKGROUND))




(define (main as)
  (big-bang as
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))
