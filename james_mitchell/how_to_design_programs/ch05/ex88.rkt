;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex88) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct VCat [x-pos happy])
; cat is a (make-VCat Number Number)
; (make-VCat x h)
; x position, h happiness

(define cat1 (make-VCat 0 77))  
(define cat2 (make-VCat 12 6))

(VCat-x-pos cat1)
(VCat-happy cat1)
(VCat-x-pos cat2)
(VCat-happy cat2)