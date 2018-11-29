;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex54) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;any string should evaluate to resting, not just the string "resting"
(define (show x)
  (cond
    [(string? x) (place-image rocket (/ WIDTH-OF-WORLD 2) 0 BACKGROUND))]
    [(<= -3 x -1) (place-image rocket (/ WIDTH-OF-WORLD 2) 0 BACKGROUND))]
    [(>= x 0) (place-image rocket (/ WIDTH-OF-WORLD 2) x BACKGROUND))]))
