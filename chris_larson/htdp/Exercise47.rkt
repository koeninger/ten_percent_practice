;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise47) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 200)
(define GAUGE-HEIGHT 150)
(define GAUGE-WIDTH 20)
(define GAUGE-FRAME
  (rectangle GAUGE-WIDTH GAUGE-HEIGHT "outline" "black"))

(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

(define (GAUGE-FILL level)
  (overlay/align "left" "bottom"
   GAUGE-FRAME
  (rectangle GAUGE-WIDTH (%toHeight level GAUGE-HEIGHT) "solid" "red")))

(define (%toHeight p h)
  (cond
    [(and (positive? p) (<= p 100)) (/ (* h p) 100)]
    [(<= p 0) 0]
    [(>= p 100) h]))
(check-expect (%toHeight 50 200) 100)
(check-expect (%toHeight 50 50) 25)
(check-expect (%toHeight 120 200) 200)
(check-expect (%toHeight -120 200) 0)

; AnimationState -> Image
; when needed, big-bang obtains the image of the current
; state of the world by evaluating (render as)
(define (render as)
  (place-image (GAUGE-FILL as) 100 100 BACKGROUND))

; AnimationState-> AnimationState
; for each tick of the clock, big-bang obtains the next
; state of the world from (clock-tick-handler cw)
; given: 20, expect 23
; given: 78, expect 81
(define (tock as)
  (cond
    [(<= as 0) 0]
    [(> as 100) 100]
    [else (- as 0.1)]))
(check-expect (tock 20) 19.9)
(check-expect (tock 78) 77.9)

; AnimationState String -> AnimationState
; for each keystroke, big-bang obtains the next state
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler as ke)
  (cond
    [(key=? ke "up") (+ as (* as 1/3))]
    [(key=? ke "down") (+ as (* as 1/5))]
    [else as]))

; AnimationState -> AnimationState
; launches the program form some initial state
(define (main as)
  (big-bang as
    [on-tick tock]
    [on-key keystroke-handler]
    [to-draw render]
    ))

(main 100)