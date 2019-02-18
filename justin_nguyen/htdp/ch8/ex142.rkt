;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; ImageOrFalse is one of:
; – Image
; – #false


; List-of-images Number -> ImageOrFalse
; given a list of images loi and a positive number n
; produces first image on loi that is not n x n square
; if no such image exist, return false
(check-expect (ill-sized? (cons (rectangle 100 100 "solid" "red") '()) 100) #true)
(check-expect (ill-sized? (cons (rectangle 90 100 "solid" "red") (cons (rectangle 100 100 "solid" "red") '())) 100) #true)
(check-expect (ill-sized? (cons (rectangle 90 100 "solid" "red") '()) 100) #false)
(check-expect (ill-sized? '() 100) #false)

(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(and (equal? (image-width (first loi)) n)
          (equal? (image-height (first loi)) n)) #true]
    [else (ill-sized? (rest loi) n)]))
