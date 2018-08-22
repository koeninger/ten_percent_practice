;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (cvolume len) (expt len 3))
(define (csurface len) (* (expt len 2) 6))


(cvolume 1)
(cvolume 2)
(cvolume 3)

(csurface 1)
(csurface 2)
(csurface 3)