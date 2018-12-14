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

(define MISSLE (rectangle 4 12 "solid" "yellow"))

(define UFO-Y-RANGE 8)
(define MISSLE-SPEED 10)
(define TANK-SPEED 3)
(define HITRANGE 12)

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
(define (ufo-render u i)
  (place-image UFO (posn-x u) (posn-y u) i))

; SIGS Image -> Image
; add image of tank t onto scene i
(define (tank-render t i)
  (place-image TANK (tank-loc t) (- SCENE-HEIGHT (/ (image-height TANK) 2)) i))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene i
(check-expect (missile-render #false BACKGROUND)
              BACKGROUND)
(check-expect (missile-render (make-posn 32 (- SCENE-HEIGHT (image-height TANK) 10)) BACKGROUND)
              (place-image MISSLE 32 (- SCENE-HEIGHT (image-height TANK) 10) BACKGROUND))
(define (missile-render m i)
  (cond
    [(boolean? m) i]
    [(posn? m) (place-image MISSLE (posn-x m) (posn-y m) i)]))

; SIGS Key -> SIGS
; returns a new SIGS based on key input:
;   "left" sets tank vel to -3
;   "right sets tank vel to 3
;   " " fires rocket (changes SIGS aim to SIGS fired)
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



; SIGS -> Bool
; returns true if UFO lands OR missile hits UFO
; else return false
(define (si-game-over? s)
  (cond
    [(>= (posn-y (sigs-ufo s))
         (- SCENE-HEIGHT (/ (image-height UFO) 2))) #true]
    [(>= HITRANGE
         (sqrt (+ (expt (- (posn-x (sigs-ufo s)) (posn-x (sigs-missile s))) 2)
                  (expt (- (posn-y (sigs-ufo s)) (posn-y (sigs-missle s))) 2)))) #true]
    [else #false]))

(define (main state)
  (big-bang state
    [on-tick si-move]
    [to-draw si-render]
    [on-key si-control]
    [stop-when si-game-over?]))