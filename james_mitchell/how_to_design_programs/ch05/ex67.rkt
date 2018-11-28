;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex67) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SPEED 3)
(define-struct balld [location direction])
(define ball1 (make-balld 10 "up"))

(define ball2 (make-balld (+ 10 SPEED) "up"))
(define ball3 (make-balld 100 "down"))
(define ball4 (make-balld 0 "up"))
(define ball5 (make-balld 0 "down"))
