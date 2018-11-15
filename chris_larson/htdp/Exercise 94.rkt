;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 94|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 400)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 5)
(define UFO-SPEED 2)

(define UFO (rectangle UFO-WIDTH UFO-HEIGHT "solid" "blue"))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 10)
(define TANK-SPEED 2)

(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "green"))

(define MISSILE-WIDTH 10)
(define MISSILE-SPEED 5)

(define MISSILE (triangle MISSILE-WIDTH "solid" "red"))