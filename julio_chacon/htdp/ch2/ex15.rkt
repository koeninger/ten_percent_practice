;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (==> sunny friday)
  (and  (not sunny) friday)
)


(==> #true #false)
;#false
(==> #false #false)
;#false
(==> #true #true)
;#false
(==> #false #true)
;#true