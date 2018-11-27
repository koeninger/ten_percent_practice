;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |88|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number)
; (make-vcat x h)
; x position, h happines

(define cat1 (make-vcat 0 50))  
(define cat2 (make-vcat 20 100))

(vcat-x-pos cat1)
(vcat-happy cat1)
(vcat-x-pos cat2)
(vcat-happy cat2)
