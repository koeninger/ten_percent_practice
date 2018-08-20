;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define canvas (empty-scene 16 30))
(define trunk (add-line canvas 8 10 8 30 "brown"))
(define leaves (ellipse 16 20 "solid" "green"))
(define tree (overlay leaves trunk))
tree