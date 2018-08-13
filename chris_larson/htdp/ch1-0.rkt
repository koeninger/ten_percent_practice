;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch1-0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define x 12)
(define y 5)
(define prefix "hello")
(define suffix "world")
(define str "hello world")
(define i 5)

;functions
(define (distance-to-origin x y)
  (sqrt (+ (* x x) (* y y))))

; scratch
(+ 1 2)
(+ 1 (+ 1 (+ 1 1) 2) 3 4 5)
(+ 3 4)
(sin 0)
(+ x 10)
(* x y)
(string-append "what a " "lovely " "day" " 4 BSL")
(distance-to-origin x y)
(string-append prefix "_" suffix)
(string-length "hello world")
(+ (string-length "hello world") 20)
(string-append (substring str 0 i) "_" (substring str (+ i 1) (string-length str)))