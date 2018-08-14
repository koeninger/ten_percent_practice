;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2_functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define (distance-to-origin x y)
  (sqrt (+ (expt x 2) (expt y 2))))

; volume of equilateral cube
(define (cvolume side)
  (expt side 3))

; surface area of equilateral cube
(define (csurface side)
  (* 6 (expt side 2)))

(define (string-first str)
  (substring str 0 1))

(define (string-last str)
  (substring str (- (string-length str) 1)))

; boolean implication
(define (==> sunny friday)
  (or (not sunny) friday))

(define (image-area image)
  (* (image-height image) (image-width image)))

(define (image-classify image)
  (if (= (image-height image) (image-width image))
      "square"
      (if (>= (image-height image) (image-width image))
          "tall"
          "wide")))

(define (string-join prefix suffix)
  (string-append prefix "_" suffix))

(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ i 1))))