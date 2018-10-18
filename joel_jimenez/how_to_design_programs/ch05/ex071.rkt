;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex071) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))

(define-struct game [left-player right-player ball])

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(game-ball game0)
; == (game-ball (make-game (quotient HEIGHT 2) (quotient HEIGHT 2) (make-posn (quotient WIDTH 2) (quotient WIDTH 2))))
; == (game-ball (make-game (quotient 200 2) (quotient 200 2) (make-posn (quotient 400 2) (quotient 400 2))))
; == (game-ball (make-game 100 100 (make-posn 200 200)))
; == (make-posn 200 200)

(posn? (game-ball game0))
; == (posn? (game-ball (make-game (quotient HEIGHT 2) (quotient HEIGHT 2) (make-posn (quotient WIDTH 2) (quotient WIDTH 2)))))
; == (posn? (game-ball (make-game (quotient 200 2) (quotient 200 2) (make-posn (quotient 400 2) (quotient 400 2)))))
; == (posn? (game-ball (make-game 100 100 (make-posn 200 200))))
; == (posn? (make-posn 200 200))
; == #true

(game-left-player game0)
; == (game-left-player (make-game (quotient HEIGHT 2) (quotient HEIGHT 2) (make-posn (quotient WIDTH 2) (quotient WIDTH 2))))
; == (game-left-player (make-game (quotient 200 2) (quotient 200 2) (make-posn (quotient 400 2) (quotient 400 2))))
; == (game-left-player (make-game 100 100 (make-posn 200 200)))
; == 100
