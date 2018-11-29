;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex67) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define SPEED 3)

;places ball in y position and sets directions
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 20 "up")
(make-balld 5 "down")
(make-balld 1 "down")