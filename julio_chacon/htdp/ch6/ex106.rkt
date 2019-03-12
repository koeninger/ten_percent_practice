;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex106) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)



; A VAnimal is either
; – a VCat
; – a VCham
(define-struct VAnimal [anim])


(define-struct VCat [x h])
; A VCat is a structure
; (make-VCat Number Number)
; posX is the x coordinate and h is the hapines

(define-struct VCham [x h])
; A VCat is a structure
; (make-VCat Number Number)
; posX is the x coordinate and h is the hapines