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

; (vel-deltax (ball-velocity ball1))


; Structure laws
(define-struct centry [name home office cell])
(define-struct phone [area number])

; (phone-area (centry-home
;             (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) ==  a1

; (phone-number (centry-home
;               (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) == n1


; (phone-area (centry-office
;             (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) ==  a2

; (phone-number (centry-office
;               (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) == n2

; (phone-area (centry-cell
;             (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) ==  a3

; (phone-number (centry-cell
;               (make-centry "name" (make-phone a1 n1) (make-phone a2 n2) (make-phone a3 n3) ))) == n3


; Result is 101 - because the area number of Shriram Fisler's office is 101
(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981")))) ""
