;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |80|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title director year])
; movie -> Number
; how-old-is-this-movie returns the number of years old the movie
(check-expect (how-old-is-this-movie (make-movie "Bob" "Bill" "2018") 0)
(check-expect (how-old-is-this-movie (make-movie "Bob" "Bill" "2010") 8)
(define (how-old-is-this-movie film)
  (....(movie-year film) ... ))

(define-struct pet [name number])
; pet, pet -> pet
; graft-pet merges two pets into one
(check-expect (graft-pet (make-pet "Bob" 1) (make-pet "Bill" 2)) (make-pet "BobBill" 3))
(define (graft-pet pet1 pet2)
  (... (pet-name pet1) ... (pet-name pet2) ... (pet-number pet1) ... (pet-number pet2)))

(define-struct CD [artist title price])
; CD, CD -> CD
; cheapo-cd finds the cheapest CD
(check-expect (cheapo-cd (make-CD "Bob" "Songs" 10) (make-CD "Bill" "Words" 5))
              (make-CD "Bill" "Words" 5))
(check-expect (cheapo-cd (make-CD "Bob" "Songs" 5) (make-CD "Bill" "Words" 5))
              (make-CD "Bob" "Songs" 5))
(define (cheapo-cd cd1 cd2)
  (... (cd-price cd1) ... (cd-price cd2)))

(define-struct sweater [material size color])
; sweater -> boolean
; can-mike-fit-into-this-sweater will tell you if mike can wear the sweater
(check-expect (can-mike-fit-into-this-sweater (make-sweater "cotton" "XL" "red")) #false)
(check-expect (can-mike-fit-into-this-sweater (make-sweater "wool" "XXXL" "black")) #true)
(define (can-mike-fit-into-this-sweater article)
  (... (sweater-size article)...))