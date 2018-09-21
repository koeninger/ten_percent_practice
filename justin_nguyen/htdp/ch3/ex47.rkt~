;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Happiness is a Number that represents happiness

; Happiness -> Image
; creates an Image representing happiness level
(define (render happy)
  (place-image (gauge happy)(x-pos happy) y-pos BACKGROUND))

; Happiness -> Happiness
; create next Happiness level for given Happiness level
; given: 0, expect: 3
; given: 6, expect: 9
(define (tock happy)
  (cond
    [(> happy 0) (- happy 0.1)]
    [(<= happy 0) 0]))

; Happiness -> Number
; get x-position for bar for a given Happiness
(define (x-pos happy)
  (+ (/ happy 2) 1))

; String -> Happiness
(define (key-handler happy key)
  (cond
    [(key=? key "up") (+ happy 1/3)]
    [(key=? key "down") (+ happy 1/5)]
    [else happy]))

(define (gauge happy) (rectangle happy (- SCENE-HEIGHT 2) "solid" "red"))
(define SCENE-WIDTH 102)
(define SCENE-HEIGHT 30)
(define y-pos (+ (/ (- SCENE-HEIGHT 2) 2) 1))
(define BACKGROUND
  (empty-scene SCENE-WIDTH SCENE-HEIGHT))
 

(define (main happy)
  (big-bang happy
    [on-tick tock]
    [on-key key-handler]
    [to-draw render]))