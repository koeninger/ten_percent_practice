;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SCENE-WIDTH 500)
(define SCENE-HEIGHT 300)

(define BACKGROUND SCENE-WIDTH SCENE-HEIGHT "blue")
  (empty-scene
(define TANK (rectangle 70 20 "solid" "green"))
(define UFO (overlay
             (beside (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white"))
             (ellipse 80 20 "solid" "gray")))
