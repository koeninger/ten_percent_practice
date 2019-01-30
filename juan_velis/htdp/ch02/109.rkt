;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |109|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 200)
(define HEIGHT 200)

(define COLOR1 "white")
(define COLOR2 "yellow")
(define COLOR3 "green")
(define COLORX "red")

(define SCENE (empty-scene WIDTH HEIGHT "white"))

; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 

(define AA "start, expect to see an 'a' next")
(define BC "expect to see: 'b', 'c' or 'd'")
(define DD "encountered a 'd', finished")
(define ER "error, user pressed illegal key")

(define (render e) (place-image/align
                (text e 16 "black")
                100 100 "center" "center"
                (overlay
                 (rectangle 200 200 "solid" (wcolor e)) SCENE)
               )
)
(check-expect (render AA) (place-image/align
                (text AA 16 "black")
                100 100 "center" "center"
                (overlay
                 (rectangle 200 200 "solid" (wcolor AA)) SCENE)
                ))

; ExpectToSee -> String
; return the color to use
(define (wcolor e)
  (cond [(string=? AA e) COLOR1]
        [(string=? BC e) COLOR2]
        [(string=? DD e) COLOR3]
        [(string=? ER e) COLORX]
   )
)

; ExpectsToSee 1String -> ExpectsToSee
; FSM
(define (fsm e l)
  (cond [(string=? AA e)
         (cond [(string=? l "a") BC]
               [else ER])]
        [(string=? BC e)
         (cond [(or (string=? l "b")
                    (string=? l "c")) BC]
               [(string=? l "d") DD]
               [else ER])]
        [else e])
)
(check-expect (fsm AA "a") BC) 
(check-expect (fsm BC "b") BC)
(check-expect (fsm AA "r") ER)
(check-expect (fsm BC "d") DD)


; ExpectToSee, KeyEvent -> ExpectToSee
(define (checkkey e k)
  (cond
    [(= (string-length k) 1) (fsm e k)] ; 1 keystroke
    [else e]
  )
)

(define (main e)
  (big-bang e
    [to-draw render]
    [on-key  checkkey]
  )
)

(main AA)