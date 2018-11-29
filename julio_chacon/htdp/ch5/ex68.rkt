;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex68) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define SPEED 3)

;places ball in y position and sets directions
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 20 "up")
(make-balld 5 "down")
(make-balld 1 "down")


(define-struct vel [deltax deltay])
(define ball1
  (make-balld (make-posn 30 40) (make-vel -10 5)))


(define-struct ballf [x y deltax deltay])



(define newball
 (make-ballf 30 40 -10 5))