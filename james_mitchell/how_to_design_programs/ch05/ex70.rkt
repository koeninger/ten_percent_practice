;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex70) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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