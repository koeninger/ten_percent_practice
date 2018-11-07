;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex80) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title director year])
(define (movie-details m)
  (string-append (movie-title m) " (" (number->string (movie-year m)) ") directed by " (movie-director m)))


(define-struct pet [name number])
(define (pet-details p)
  (string-append (pet-name p) " #" (number->string (pet-number p))))


(define-struct CD [artist title price])
(define (CD-details c)
  (string-append (CD-title c) " by " (CD-artist c) " cost: $" (number->string(CD-price c))))


(define-struct sweater [material size color])
(define (sweater-details s)
  (string-append "A " (sweater-size s) " " (sweater-color s) " sweater made of " (sweater-material s)))


(movie-details (make-movie "DrRacket" "Matthias Felleisen" 2018))
(pet-details (make-pet "ab" 2))
(CD-details (make-CD "Bob" "HelloThere" 10.00))
(sweater-details (make-sweater "wool" "medium" "red"))