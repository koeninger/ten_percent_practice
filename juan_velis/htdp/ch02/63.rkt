;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |63|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Number Number -> Posn
(make-posn 3 4)
(define one-posn (make-posn 8 6))

;; Selecting components of a posn
(define p (make-posn 31 26))

;(posn-x p) ; 31
;(posn-y p) ; 26
;; posn identities
; (posn-x (make-posn x0 y0)) == x0
; (posn-y (make-posn x0 y0)) == y0

; computes the distance of ap to the origin

(check-expect (distance-to-0 (make-posn 0 0)) 0)  ; of course
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)

(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

;(define (distance-to-0 ap) ; stub
;  0)

#; ; template
(define (fn-for-posn ap)
  (... (posn-x ap) ...
   ... (posn-y ap) ...))

(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))
