;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 157|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (- (/ WIDTH 2) 40))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT "green"))
(define SHOT (rectangle 3 8 "solid" "red"))

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired 

; A Shot is a Number.
; interpretation represents the shot's y-coordinate 

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y} to the background image 
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))


; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel 
(define (tock w)
  (cond
    [(empty? w) '()]
    [(< (first w) 0) (tock (rest w))]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
(check-expect (tock (cons 9 '())) (cons 8 '()))

               
; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))
(check-expect (keyh (cons 9 '()) " ") (cons HEIGHT (cons 9 '())))

; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

(main '())