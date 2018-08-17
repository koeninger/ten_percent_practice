;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch2-0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; definitions

; functions
(define (distance x y)
  (sqrt (+ (* x x) (* y y))))
(define (cvolume x)
  (* x x x))
(define (csurface x)
  (* x x 6))
(define (string-first s)
  (substring s 0 1))
(define (string-last s)
  (substring s (- (string-length s) 1)))

; scratch
(define (f x) 1)
(define (g x y) (+ 1 1))
(define (h x y z) (+ (* 2 2) 3))
(define x 3)
(define (ff a)
  (* 10 a))
(f 1)
(f "hello world")
(f #true)
(f (circle 3 "solid" "red"))
(+ (ff 3) 2)
(* (ff 4) (+ (ff 3) 2))
(ff (ff 1))
(distance 1 1)
(cvolume 4)
(csurface 4)
(string-first "abcdefghijklmno")
(string-last "abcdefghijklmno")