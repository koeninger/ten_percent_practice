;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 67|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))


(define-struct ball [location velocity])
; (make-ball 10 -3)

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 4 "down")

(define-struct vel [deltax deltay])
(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define-struct ballf [x y deltax deltay])
(make-ballf 30 40 -10 5)

(define-struct centry [name home office cell])
(define-struct phone [area number])
(define this (make-centry "Shriram Fisler"
             (make-phone 207 "363-2421")
             (make-phone 101 "766-1099")
             (make-phone 208 "112-9981")))
(define-struct entry [name phone email])
(define pl (make-entry "Al Abe" "666-7771" "lee@x.me"))
(entry-name pl)
(vel-deltax (ball-velocity ball1))

(phone-area (centry-home this))
(phone-area (centry-office this))
(phone-area (centry-cell this))
(phone-number (centry-home this))
(phone-number (centry-office this))
(phone-number (centry-cell this))
(centry-name this)

; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

; (game-ball game0)
;   (make-posn CENTER CENTER)
;      (quotient WIDTH 2)
;      (quotient 400 2)
;                200
; (posn? (game-ball game0))
; is (make-posn CENTER CENTER) a position?
; (game-left-player game0)
;  (quotient 200 2) = 100
