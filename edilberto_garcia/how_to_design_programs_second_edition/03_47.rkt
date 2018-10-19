;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 47. Design a world program that maintains and displays a
;    “happiness gauge.” Let’s call it gauge-prog, and let’s agree that the
;    program consumes the maximum level of happiness. The gauge display
;    starts with the maximum score, and with each clock tick, happiness
;    decreases by -0.1; it never falls below 0,
;    the minimum happiness score.
;   Every time the down arrow key is pressed, happiness increases by 1/5;
;     every time the up arrow is pressed, happiness jumps by 1/3.

; To show the level of happiness, we use a scene with a solid,
;    red rectangle with a black frame. For a happiness level of 0,
;    the red bar should be gone; for the maximum happiness level of 100,
;   the bar should go all the way across the scene.

; Note When you know enough, we will explain how to combine the gauge
;    program with the solution of exercise 45. Then we will be able to
;    help the cat because as long as you ignore it, it becomes less happy.
;    If you pet the cat, it becomes happier. If you feed the cat, it becomes much,
;    much happier. So you can see why you want to know a lot more about designing
;    world programs than these first three chapters can tell you.


; --------------------------------------

; We use numbers to represent cat happiness
; 

;tock 
;render

(require 2htdp/image)
(require 2htdp/universe)

(define border (rectangle 100 60 "outline" "black"))
;(define meter (rectangle 490 56  "solid" "red"))



(define (get-meter x)(rectangle x 56 "solid" "red"))
(define (tick x)
  (cond [(= x 0) 0] [else (- x .1 )])
)

(define (adjust-happines x a-key)

  (cond
      [(key=? a-key "up")  (+ x (* x 1/3))]
      [(key=? a-key "down") (+ x (* x 1/5))]
      [else x]
  )
)
(define (render x) (overlay/align "left" "center" (get-meter x) border))

  (define (main ws)
   (big-bang ws
     [on-tick tick]
     [to-draw render]
     [on-key adjust-happines]))