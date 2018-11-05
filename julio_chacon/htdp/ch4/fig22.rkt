;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fig22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (rectangle 40 4 "solid" "green")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt .5 ]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))

(define (msg h)
  (cond
    [(>= (- HEIGHT CLOSE) h) (string-append "descending " (number->string h))  ]
    [(and (> h (- HEIGHT CLOSE)) (<= h HEIGHT))  (string-append "closing in "(number->string h))]
    [else "landed"]
    )
  )

 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-images
   (list UFO (text (msg 11) 12 "black"))
   (list (make-posn  (/ WIDTH 2) 11) (make-posn  50 10)) MTSCN))

(define (render y)
  (place-images
   (list UFO
          (text (msg y) 12 "olive"))
   (list (make-posn  (/ WIDTH 2) y)
         (make-posn  50 10))
   MTSCN)
  )



(main 0)

