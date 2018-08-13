;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1_arithmetic) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define x 12)
(define y 5)

(define distance-to-origin (sqrt (+ (expt x 2) (expt y 2))))

(define prefix "hello")
(define suffix "world")
(define prefix_suffix (string-append prefix "_" suffix))

(define str "helloworld")
(define i 5)
(define _-at-i (string-append (substring str 0 i) "_" (substring str i)))

(define delete-at-i (string-append (substring str 0 (- i 1)) (substring str i)))

(define boat-scale 100)

(define boat (polygon (list (make-posn (* 2/5 boat-scale) (* 1/5 boat-scale))
                            (make-posn (* 3/5 boat-scale) (* 1/5 boat-scale))
                            (make-posn (* 3/5 boat-scale) (* 2/5 boat-scale))
                            (make-posn (* 4/5 boat-scale) (* 2/5 boat-scale))
                            (make-posn (* 3/5 boat-scale) (* 3/5 boat-scale))
                            (make-posn (* 2/5 boat-scale) (* 3/5 boat-scale))
                            (make-posn (* 1/5 boat-scale) (* 2/5 boat-scale))
                            (make-posn (* 2/5 boat-scale) (* 2/5 boat-scale)))
                      "solid"
                      "brown"))