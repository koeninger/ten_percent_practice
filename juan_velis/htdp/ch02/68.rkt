;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |68|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct ballf [x y deltax deltay])

;(define ball1
;  (make-balld (make-posn 30 40) (make-vel -10 5)))

(define ball (make-ballf 30 40 -10 5))


;(define-struct centry [name home office cell])
 
;(define-struct phone [area number])
 
;(make-centry "Shriram Fisler"
;             (make-phone 207 "363-2421")
;             (make-phone 101 "776-1099")
;             (make-phone 208 "112-9981"))
