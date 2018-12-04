;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex95) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; definitions:
; (define-struct aim [ufo tank])
; (define-struct fired [ufo tank missile])

; 1. (make-aim (make-posn 20 10) (make-tank 28 -3))

; 2. (make-fired (make-posn 20 10)
;                (make-tank 28 -3)
;                (make-posn 28 (- HEIGHT TANK-HEIGHT)))

; 3. (make-fired (make-posn 20 100)
;                (make-tank 100 3)
;                (make-posn 22 103))


; 1 follows the first definition because it does not need to track the missle
;  because it has not been fired yet.

; 2 and 3 follow the second and third definition because the missle has been fired
;  and its state needs to be tracked in the game world.