;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |71|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(game-ball game0)
; returns (make-posn 200 200) because
; (game-ball (make-game MIDDLE MIDDLE (make-posn 200 200))) ; gets the ball from the game structure

(posn? (game-ball game0))
; returns #true because
; (make-posn 200 200) is a posn structure

(game-left-player game0)
; returns 100 becuase
; (game-left-player (make-game 100 MIDDLE ball)) ; gets the left-player from the game structure
