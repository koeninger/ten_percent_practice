;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |70|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct entry [name phone email])
(define pl (make-entry "Al Abe" "666-7771" "lee@x.me"))
(entry-name pl)

; (entry-name (make-posn 42 5)) ; X

(define-struct ball [location velocity])
(define ball1 (make-ball -10 5))
(ball-velocity ball1)

(define-struct vel [deltax deltay])

;(vel-deltax (ball-velocity ball1))
