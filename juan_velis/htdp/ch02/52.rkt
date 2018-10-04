;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |52|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 300)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (ellipse 40 8 "solid" "green")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (cond
    [(> y (- HEIGHT 30)) y]
    [else (+ y 3)]
  )
)

; Number -> String
(define (message y)
  (cond
    [(<= 0 y CLOSE) (text "descending" 13 "orange")]
    [(and (< CLOSE y) (<= y (- HEIGHT 40))) (text "closing" 13 "yellow")]
    [(> y (- HEIGHT 40)) (text "landed" 13 "green")]
   )
)

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO ... 11 MTSCN))
(define (render y)
  (place-image
   UFO
   (/ WIDTH 2) y
   (place-image 
    (overlay/align "center" "center"
                   (message y); (text (message y) 13 "orange")
                   (rectangle WIDTH 20 "solid" "black"))
    (/ WIDTH 2)
    (- HEIGHT 10)
   MTSCN
   )))
(main 0)
