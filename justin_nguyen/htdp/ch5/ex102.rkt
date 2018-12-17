;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex102) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 200)
(define BUILD-WIDTH 10)
(define BUILD-COLOR "dimgray")
(define BUILD-WINDOW-COLOR "gray")
(define WINDOW (rectangle 6 6 "solid" BUILD-WINDOW-COLOR))
(define BUILDING-UNIT-WINDOW (overlay/offset WINDOW
                                             0 0
                                             (rectangle BUILD-WIDTH BUILD-WIDTH "solid" BUILD-COLOR)))
(define BUILDING-UNIT (rectangle BUILD-WIDTH BUILD-WIDTH "solid" BUILD-COLOR))

(define TANK (above
              (rectangle 6 8 "solid" "green")
              (rectangle 30 8 "solid" "green")))
(define UFO (overlay
             (beside (circle 3 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 3 "solid" "white"))
             (ellipse 25 22 "solid" "gray")))

(define MISSILE (rectangle 4 12 "solid" "yellow"))

(define UFO-Y-RANGE 2)
(define MISSILE-SPEED 10)
(define TANK-SPEED 3)
(define HITRANGE 14)

(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT "blue"))

; a UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using top-down, left-right convention)

(define-struct tank [loc vel])
; a Tank is a structure:
;  (make-tank Number Number)
; interpretation (make-tank x dx) specifies the pos:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location


; SIGS -> Image
; render tank, ufo, and missile if it exists
(define (si-render s)
  (tank-render (sigs-tank s)
               (ufo-render (sigs-ufo s)
                           (missile-render (sigs-missile s) BACKGROUND))))

; SIGS Image -> Image
; add image of ufo u onto scene i
(check-expect (ufo-render (make-posn 100 0) BACKGROUND)
              (place-image UFO 100 0 BACKGROUND))
(check-expect (ufo-render (make-posn 100 50) BACKGROUND)
              (place-image UFO 100 50 BACKGROUND))
(check-expect (ufo-render (make-posn 10 90) BACKGROUND)
              (place-image UFO 10 90 BACKGROUND))
(define (ufo-render u i)
  (place-image UFO (posn-x u) (posn-y u) i))

; SIGS Image -> Image
; add image of tank t onto scene i
(check-expect (tank-render (make-tank 100 0) BACKGROUND)
              (place-image TANK 100 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(check-expect (tank-render (make-tank 100 3) BACKGROUND)
              (place-image TANK 100 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(check-expect (tank-render (make-tank 50 -3) BACKGROUND)
              (place-image TANK 50 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(define (tank-render t i)
  (place-image TANK (tank-loc t) (- SCENE-HEIGHT (/ (image-height TANK) 2)) i))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene i
(check-expect (missile-render #false BACKGROUND)
              BACKGROUND)
(check-expect (missile-render (make-posn 32 (- SCENE-HEIGHT (image-height TANK) 10)) BACKGROUND)
              (place-image MISSILE 32 (- SCENE-HEIGHT (image-height TANK) 10) BACKGROUND))
(define (missile-render m i)
  (cond
    [(boolean? m) i]
    [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) i)]))

; SIGS Key -> SIGS
; returns a new SIGS based on key input:
;   "left" sets tank vel to -3
;   "right sets tank vel to 3
;   " " fires rocket (changes SIGS aim to SIGS fired)
(check-expect (si-control (make-sigs (make-posn 100 0) (make-tank 100 0) #false) "")
              (make-sigs (make-posn 100 0) (make-tank 100 0) #false))
(check-expect (si-control (make-sigs (make-posn 100 0) (make-tank 100 0) #false) "left")
              (make-sigs (make-posn 100 0) (make-tank 100 (- TANK-SPEED)) #false))
(check-expect (si-control (make-sigs (make-posn 100 0) (make-tank 100 0) #false) "right")
              (make-sigs (make-posn 100 0) (make-tank 100 TANK-SPEED) #false))
(check-expect (si-control (make-sigs (make-posn 100 0) (make-tank 100 0) #false) " ")
              (make-sigs (make-posn 100 0) (make-tank 100 0) (make-posn 100 (- SCENE-HEIGHT (/ (image-height TANK) 2)))))
(define (si-control s key)
  (cond
    [(string=? "left" key) (make-sigs (sigs-ufo s)
                                      (make-tank (tank-loc (sigs-tank s)) (- TANK-SPEED))
                                      (sigs-missile s))]
    [(string=? "right" key) (make-sigs (sigs-ufo s)
                                       (make-tank (tank-loc (sigs-tank s)) TANK-SPEED)
                                       (sigs-missile s))]
    [(and (string=? " " key) (boolean? (sigs-missile s))) (make-sigs (sigs-ufo s)
                                                                     (sigs-tank s)
                                                                     (make-posn (tank-loc (sigs-tank s))
                                                                                (- SCENE-HEIGHT (/ (image-height TANK) 2))))]
    [else s]))

; SIGS -> SIGS
; moves all entities accordingly
(define (si-move s)
  (make-sigs (si-move-ufo (sigs-ufo s) (random UFO-Y-RANGE) (random 2))
             (si-move-tank (sigs-tank s))
             (si-move-missile (sigs-missile s))))

; UFO Number Number -> UFO
(check-expect (si-move-ufo (make-posn 100 100) 5 1)
              (make-posn 105 101))
(check-expect (si-move-ufo (make-posn 100 105) 5 0)
              (make-posn 95 106))
(check-expect (si-move-ufo (make-posn 100 100) 0 1)
              (make-posn 100 101))
(check-expect (si-move-ufo (make-posn 200 100) 9 1)
              (make-posn 200 101))
(check-expect (si-move-ufo (make-posn 200 100) 9 0)
              (make-posn 191 101))
(check-expect (si-move-ufo (make-posn 0 100) 9 0)
              (make-posn 0 101))
(check-expect (si-move-ufo (make-posn 0 100) 9 1)
              (make-posn 9 101))
(define (si-move-ufo u delta dir)
  (make-posn (if (and (>= (+ (posn-x u) (* delta (if (= dir 0) -1 1))) 0)
                      (<= (+ (posn-x u) (* delta (if (= dir 0) -1 1))) SCENE-WIDTH))
                 (+ (posn-x u) (* delta (if (= dir 0) -1 1)))
                 (posn-x u))
             (+ (posn-y u) 1)))

; Tank -> Tank
; moves tank based on its velcocity
(check-expect (si-move-tank (make-tank 100 0))
              (make-tank 100 0))
(check-expect (si-move-tank (make-tank 0 -3))
              (make-tank 0 -3))
(check-expect (si-move-tank (make-tank 0 3))
              (make-tank 3 3))
(check-expect (si-move-tank (make-tank 200 3))
              (make-tank 200 3))
(check-expect (si-move-tank (make-tank 200 3))
              (make-tank 200 3))
(define (si-move-tank t)
  (make-tank (if (and (>= (+ (tank-loc t) (tank-vel t)) 0)
                      (<= (+ (tank-loc t) (tank-vel t)) SCENE-WIDTH))
                 (+ (tank-loc t) (tank-vel t))
                 (tank-loc t))
             (tank-vel t)))

; MissileOrNot -> MissileOrNot
; move missile upwards based on speed
(check-expect (si-move-missile (make-posn 100 15))
              (make-posn 100 (- 15 MISSILE-SPEED)))
(check-expect (si-move-missile (make-posn 150 90))
              (make-posn 150 (- 90 MISSILE-SPEED)))
(check-expect (si-move-missile (make-posn 6 167))
              (make-posn 6 (- 167 MISSILE-SPEED)))
(check-expect (si-move-missile #false)
              #false)
(check-expect (si-move-missile (make-posn 100 0))
              #false)
(define (si-move-missile m)
  (cond
    [(boolean? m) m]
    [(posn? m) (if (> (posn-y m) 0)
                   (make-posn (posn-x m) (- (posn-y m) MISSILE-SPEED))
                   #false)]))


; SIGS -> Bool
; returns true if UFO lands OR missile hits UFO
; else return false
(check-expect (si-game-over? (make-sigs (make-posn 100 0) (make-tank 100 0) #false))
              #false)
(check-expect (si-game-over? (make-sigs (make-posn 100 50) (make-tank 100 3) #false))
              #false)
(check-expect (si-game-over? (make-sigs (make-posn 100 200) (make-tank 100 3) #false))
              #true)
(check-expect (si-game-over? (make-sigs (make-posn 100 0) (make-tank 100 0) (make-posn 100 100)))
              #false)
(check-expect (si-game-over? (make-sigs (make-posn 100 100) (make-tank 100 0) (make-posn 100 100)))
              #true)
(define (si-game-over? s)
  (cond
    [(>= (posn-y (sigs-ufo s))
         (- SCENE-HEIGHT (/ (image-height UFO) 2))) #true]
    [(posn? (sigs-missile s)) (>= HITRANGE
         (sqrt (+ (expt (- (posn-x (sigs-ufo s)) (posn-x (sigs-missile s))) 2)
                  (expt (- (posn-y (sigs-ufo s)) (posn-y (sigs-missile s))) 2))))]
    [else #false]))

(define (main state)
  (big-bang state
    [on-tick si-move]
    [to-draw si-render]
    [on-key si-control]
    [stop-when si-game-over?]))