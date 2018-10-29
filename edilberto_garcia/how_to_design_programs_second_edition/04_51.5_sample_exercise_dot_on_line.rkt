;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_60.5_sample_exercise_dot_on_line) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem Design a key-event handler that moves a red dot
;    left or right on a horizontal line in response to pressing
;    the left and right arrow keys.

(require 2htdp/image)
(require 2htdp/universe)

(define horizon (rectangle 200 5 "solid" "black") )
(define dot (circle 10 "solid" "red"))


(define (render current_state)
 (overlay/offset dot current_state 0 horizon)
)

(define (key_press state KeyEvent)
    (cond
        [(string=? "left"  KeyEvent) (+ state 5) ]
        [(string=? "right" KeyEvent) (- state 5)]
        [else state]
))



(define (main ws)
   (big-bang ws
     [to-draw render]
     [on-key key_press]
))