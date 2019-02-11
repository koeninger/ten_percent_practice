;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |113|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define UFO (make-posn 50 100))
(define-struct tank [loc vel])
(define-struct aim [ufo tank ])
(define-struct fired [ufo tank missle])

; SIGS
; Any -> Boolean
(define (SIGS? v)
  (or (aim? v) (fired? v)))

(check-expect (SIGS? #true) #false)
(check-expect (SIGS? 1) #false)
(check-expect (SIGS? (make-aim (make-posn 1 1)
                               (make-tank 1 1))) #true)

; Any -> Boolean
(define (coordinate? v)
  (or (posn? v) (number? v)))

(check-expect (coordinate? 1) #true)
(check-expect (coordinate? "string") #false)
(check-expect (coordinate? #false) #false)

;VAnimal
(define-struct vcat [x-pos happy])
(define-struct vcham [x-pos happy clr])

;Any -> Boolean
(define (vanimal? v)
(or (vcat? v) (vcham? v)))

(check-expect (vanimal? (make-vcat 1 1)) #true)
(check-expect (vanimal? (make-vcham 1 1 "red")) #true)
(check-expect (vanimal? 1) #false)
(check-expect (vanimal? "string") #false)
