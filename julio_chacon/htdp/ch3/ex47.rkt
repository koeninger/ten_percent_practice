;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define BG-HEIGHT 10)
(define BG-WIDTH 100)

(define BACKGROUND
  (empty-scene BG-WIDTH BG-HEIGHT))

(define (render wd)
  (place-image/align
   (rectangle wd BG-HEIGHT "solid" "red")
      0 0  "left" "top"
   BACKGROUND))


(define (tock wd) 
   (cond
    [(> wd BG-WIDTH) BG-WIDTH]
    [(<= wd 0) 0.1]
    [else (- wd 0.1)]
  )
)

(define (alter wd k)
  (cond
    [(key=? k "up")   (+ wd (*  BG-WIDTH .34))]
    [(key=? k "down")  (+ wd (* BG-WIDTH .2))]
  )
)

(define main 
  (big-bang BG-WIDTH
    [on-tick tock]
    [on-key alter]
    [to-draw render]))

