;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define (image-classify img) (if (> (image-height img) (image-width img)) "tall"
                                 (if (= (image-height img) (image-width img)) "square" "wide")))

(define rect-sq (rectangle 10 10 "solid" "green"))
(define rect-tall (rectangle 10 20 "solid" "red"))
(define rect-wide (rectangle 20 10 "solid" "blue"))

rect-sq
(image-classify rect-sq)

rect-tall
(image-classify rect-tall)

rect-wide
(image-classify rect-wide)