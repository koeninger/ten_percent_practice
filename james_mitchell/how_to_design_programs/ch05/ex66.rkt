;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex66) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
(define m (make-movie "Pants!" "Some dude" 1986))
(movie-title m)
(movie-producer m)
(movie-year m)
(movie? m)

(define-struct person [name hair eyes phone])
(define p (make-person "James" "Blonde" "Blue" "867-5309"))
(person-name p)
(person-hair p)
(person-eyes p)
(person-phone p)
(person? p)

(define-struct pet [name number])
(define pe (make-pet "Hans" 4))
(pet-name pe)
(pet-number pe)
(pet? pe)

(define-struct CD [artist title price])
(define cd (make-CD "Prince" "Purple Rain" 19.99))
(CD-artist cd)
(CD-title cd)
(CD-price cd)
(CD? cd)

(define-struct sweater [material size producer])
(define s (make-sweater "Wool" "XL" "Target"))
(sweater-material s)
(sweater-size s)
(sweater-producer s)
(sweater? s)

