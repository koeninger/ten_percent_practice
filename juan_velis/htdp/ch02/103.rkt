;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |103|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; space = cubic feet
; width, length, height, girth = feet
(define-struct spider [legs space])
(define-struct elephant [space])
(define-struct boa [length girth])
(define-struct armadillo [width length height])
(define CAGE1 10)
(define CAGE2 20)
(define CAGE3 30)

; Animal -> Int
; Returns the space used by an animal
(define (animalspace a)
  (cond [(spider? a) (spider-space a)]
        [(elephant? a) (elephant-space a)]
        [(boa? a)
         ( * (boa-length a) (boa-girth a))
        ]
        [(armadillo? a)
         (* (armadillo-width a) (armadillo-height a) (armadillo-length a))
        ]
  )
)
(check-expect (animalspace (make-spider 8 5)) 5)
(check-expect (animalspace (make-elephant 30)) 30)
(check-expect (animalspace (make-boa 2 2)) 4)
(check-expect (animalspace (make-armadillo 1 2 3)) 6)


; Animal Cage -> Boolean
; Returns true if the animal fits in the cage
(define (fits a c)
  (cond
    [(<= (animalspace a) c) #true]
    [else #false]
  )
)

(check-expect (fits (make-elephant 20) CAGE1) #false)
(check-expect (fits (make-boa 9 1) CAGE1) #true)
(check-expect (fits (make-spider 8 20) CAGE3) #true)