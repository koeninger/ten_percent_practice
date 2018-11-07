;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_55) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 55. Take another look at show. It contains three instances of
;    an expression with the approximate shape:


;    (place-image ROCKET 10 (- ... CENTER) BACKG)






; This expression appears three times in the function: twice to draw a
;    resting rocket and once to draw a flying rocket. Define an auxiliary
;    function that performs this work and thus shorten show. Why is this a
;    good idea? You may wish to reread Prologue: How to Program.


;    Before
;(define (show x)
;  (cond
;    [(string? x)
;     (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
;    [(<= -3 x -1)
;     (place-image (text (number->string x) 20 "red")
;                  10 (* 3/4 WIDTH)
;                  (place-image ROCKET
;                               10 (- HEIGHT CENTER)
;                               BACKG))]
;    [(>= x 0)
;     (place-image ROCKET 10 (- x CENTER) BACKG)]))



(require 2htdp/image)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))



(define (get_rocket_image rocket x center backg)
   (place-image rocket 10 (- x center) backg)
  )

(define (show x)
  (cond
    [(string? x) (get_rocket_image ROCKET HEIGHT CENTER BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (get_rocket_image ROCKET HEIGHT CENTER BACKG))]
    [(>= x 0)(get_rocket_image ROCKET HEIGHT x BACKG)]))
