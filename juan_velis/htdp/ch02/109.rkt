;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |109|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 200)
(define HEIGHT 200)

(define COLOR1 "white")
(define COLOR2 "yellow")
(define COLOR3 "green")
(define COLORX "red")

(define SCENE (empty-scene WIDTH HEIGHT "white"))

; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 

(define AA "start, expect to see an 'a' next")
(define BC "expect to see: 'b', 'c' or 'd'")
(define DD "encountered a 'd', finished")
(define ER "error, user pressed illegal key")

(define (expect x)
  (cond [(string=? AA x) (... x)]
        [(string=? BC x) (... x)]
        [(string=? DD x) (... x)]
        [(string=? ER x) (... x)]
  )
)

(define (render e col) (place-image/align
                (text e 16 "black")
                100 100 "center" "center"
                (overlay
                 (rectangle 200 200 "solid" col) SCENE)
               )
)

(check-expect (render AA COLOR1) (place-image/align
                (text AA 16 "black")
                100 100 "center" "center"
                (overlay
                 (rectangle 200 200 "solid" COLOR1) SCENE)
                ))

(render AA COLOR2)