;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))



; String -> Image
; draws image of traffic light with solid color when s matches
(define (render s) 
  (place-images/align
   (list (circle 7 (if (string=? s "green") "solid" "outline") "green")
         (circle 7 (if (string=? s "yellow") "solid" "outline") "yellow")
         (circle 7 (if (string=? s "red") "solid" "outline") "red"))
   (list (make-posn 8 8)
         (make-posn 8 24)
         (make-posn 8 40)
         )
   "center" "center"
   (rectangle 18 50 "outline" "black")))


; String -> WS
;starts the program
(define (main color)
   (big-bang color
     [on-tick traffic-light-next 3]
     [to-draw render]))


(main "red")