;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; a Space is a structure:
;   (make-space Number Number Number)
;   iterpretation: space defines the dimensions of a volume that an animal fills
(define-struct space [width length height])

; a Spider is a structure:
;  (make-spider Number Space)
;  iterpretation: (make-spider legs s) specifies a spider with legs number of legs
;  and takes up a volume s
(define-struct spider [legs space])

; an Elephant is a structure:
;  (make-elephant Space)
;  iterpretation: defines an elephant that takes up volume Space
(define-struct elephant [space])

; a Boa
;  (make-boa Number Number)
;  interpretation: defines length and girth of boa
(define-struct boa [length girth])

; an Armadillo
;  (make-armadillo Space)
;  interpretation: defines volume that armadillo takes up
(define-struct armadillo [space])


; an Animal is one of: spider, boa, elephant, or armadillo
(define (fits? a v)
  (cond
    [(spider? a) (<=(space-volume (spider-space a)) v)]
    [(elephant? a) (<= (space-volume (elephant-space a)) v)]
    [(boa? a) (<= (* (boa-length a) (boa-girth a) (expt pi 2)) v)]
    [(armadillo? a) (<=(space-volume (armadillo-space a)) v)]))


(define (space-volume s)
  (* (space-width s) (space-length s) (space-height s)))