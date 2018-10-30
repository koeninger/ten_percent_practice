;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex080) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))


; R3 -> Number
; determines the distance of p to the origin

(check-within (r3-distance-to-0 ex1) 13.19090595827292 1e-05)
(check-within (r3-distance-to-0 ex2) 3.162277660168379 1e-05)

(define (r3-distance-to-0 p)
  (sqrt (+
    (sqr (r3-x p))
    (sqr (r3-y p))
    (sqr (r3-z p)))))


(define-struct movie [title director year])
; Movie -> Boolean
; determines if a movie is good
(check-expect (movie-good?
  (make-movie "Citizen Kane" "Orson Welles" 1941)) #true)
(check-expect (movie-good?
  (make-movie "Casablanca" "Hal B. Wallis" 1942)) #false)
(define (movie-good? m)
  (if (and
      (string=? (movie-title m) "Citizen Kane")
      (string=? (movie-director m) "Orson Welles")
      (= (movie-year m) 1941))
    #true #false))


(define-struct pet [name number])
; Pet -> Number
; returns the pets age in dog years
(check-expect (age-dog-years
  (make-pet "Snoopy" 1941)) 539)
(check-expect (age-dog-years
  (make-pet "Scooby-Doo" 1969)) 343)
(define (age-dog-years p) (* (- 2018 (pet-number p)) 7))

(define-struct CD [artist title price])
; CD -> Boolean
; determines if a CD is cool
(check-expect (CD-cool?
  (make-CD "Nickelback" "Silver Side Up" 10)) #false)
(check-expect (CD-cool?
  (make-CD "Nirvana" "Nevermind" 19.91)) #true)
(define (CD-cool? c)
  (if (string=? (CD-artist c) "Nickelback")
    #false #true))

(define-struct sweater [material size color])
; CD -> Boolean
; determines if a sweater is valid size
(check-expect (sweater-valid-size?
  (make-sweater "cotton" "2xl" "red")) #true)
(check-expect (sweater-valid-size?
  (make-sweater "cotton" "xm" "blue")) #false)
(define (sweater-valid-size? s)
  (cond
    [(or (string=? (sweater-size s) "xs")
        (string=? (sweater-size s) "s")
        (string=? (sweater-size s) "m")
        (string=? (sweater-size s) "l")
        (string=? (sweater-size s) "xl")
        (string=? (sweater-size s) "2xl")
        (string=? (sweater-size s) "3xl")
        (string=? (sweater-size s) "4xl")
      ) #true]
    [else #false]))
