;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Cat) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;physical constants
(define MAXIMUM-SCORE 100)
(define MINIMUM-SCORE 0)
(define TOCK-DECREASE -0.1)
(define DOWN-CHANGE 1/5)
(define UP-CHANGE 1/3)
(define SCENE-WIDTH 100)
(define SCENE-HEIGHT 25)

;graphical constants
(define BACKGROUND
  (overlay/xy
   (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" "black")
   0 0
   (empty-scene SCENE-WIDTH SCENE-HEIGHT)))

; WorldState -> WorldState
; decreasing happiness gauge with each clock tick
(check-expect (tock 3) (+ 3 TOCK-DECREASE))
(check-expect (tock 5) (+ 5 TOCK-DECREASE))
(check-expect (tock 0) (+ 0 TOCK-DECREASE))

(define (tock ws)
  (+ ws TOCK-DECREASE))  

; WorldState -> Image
; draw happiness gague depending on time
(check-expect (render 50) (overlay/xy (rectangle 50 SCENE-HEIGHT "solid" "red") 0 0 BACKGROUND))
(check-expect (render 100) (overlay/xy (rectangle 100 SCENE-HEIGHT "solid" "red") 0 0 BACKGROUND))
(check-expect (render 0) (overlay/xy (rectangle 0 SCENE-HEIGHT "solid" "red") 0 0 BACKGROUND))

(define (render ws)
  (overlay/xy
   (rectangle ws SCENE-HEIGHT "solid" "red")
              0 0
              BACKGROUND))

; WorldState -> WorldState
; respond to 'up' and 'down' keys
(check-expect (change 3 "up") (+ 3 (* 3 UP-CHANGE)))
(check-expect (change 3 "down") (+ 3 (* 3 DOWN-CHANGE)))

(define (change ws ke)
  (cond
    [(key=? ke "up") (+ ws (* ws UP-CHANGE))]
    [(key=? ke "down") (+ ws (* ws DOWN-CHANGE))]
    [else ws]))

;WorldState -> Boolean
; stop the program when happiness is at minimum level
(check-expect (end? 0) #true)
(check-expect (end? 3) #false)

(define (end? ws)
  (<= ws 0))

; WorldState -> WorldState
; launch the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [on-key change]
    [stop-when end?]))

; start the program with maximum score
(main SCENE-WIDTH)
