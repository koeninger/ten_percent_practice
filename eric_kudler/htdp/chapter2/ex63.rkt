;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))

#5
#10
#23