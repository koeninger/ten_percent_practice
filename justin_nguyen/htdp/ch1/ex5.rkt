;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define SCALE 2)
(define HEIGHT 200)
(define WIDTH 200)
(define TRUNK_WIDTH (* 10 SCALE))
(define TRUNK_HEIGHT (* 50 SCALE))
(define TRUNK_POS (make-posn (/ WIDTH 2) (- HEIGHT (/ TRUNK_HEIGHT 2))))

(define LEAF_RADIUS (* 20 SCALE))
(define LEAF_POS (make-posn (/ WIDTH 2) (- HEIGHT TRUNK_HEIGHT)))
(define scene (empty-scene HEIGHT WIDTH))

(define leaf (circle LEAF_RADIUS "solid" "green"))
(define trunk (rectangle TRUNK_WIDTH TRUNK_HEIGHT "solid" "brown"))


(place-images (list
               leaf
               trunk)
              (list
               LEAF_POS
               TRUNK_POS)
              scene)
