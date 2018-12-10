;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex99) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
                     (circle 3 "solid" "white")
                     (circle 3 "solid" "white")
                     (circle 3 "solid" "white")
                     (circle 3 "solid" "white"))
             (ellipse 40 15 "solid" "gray")))

(define MISSLE (rectangle 4 12 "solid" "yellow"))

(define BUILDING1
  (beside/align "bottom"
                (above BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT
                       BUILDING-UNIT-WINDOW)
                (above BUILDING-UNIT
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT)))

(define BUILDING2
  (beside/align "bottom"
                (above BUILDING-UNIT
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW)
                (above BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT)
                (above BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT)))

(define BUILDING3
  (beside/align "bottom"
                (above BUILDING-UNIT
                       BUILDING-UNIT-WINDOW)
                (above BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW)))
(define BUILDING4
  (beside/align "bottom"
                (above BUILDING-UNIT
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT
                       BUILDING-UNIT)
                (above BUILDING-UNIT-WINDOW
                       BUILDING-UNIT
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT
                       BUILDING-UNIT-WINDOW
                       BUILDING-UNIT)))

(define BACKGROUND
  (underlay/align/offset "left" "bottom" (empty-scene SCENE-WIDTH SCENE-HEIGHT "blue")
                         0 0
                         (beside/align "bottom"
                                       BUILDING1
                                       BUILDING2
                                       BUILDING3
                                       BUILDING1
                                       BUILDING3
                                       BUILDING2
                                       BUILDING1
                                       BUILDING4
                                       BUILDING3)))

; a UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using top-down, left-right convention)

(define-struct tank [loc vel])
; a Tank is a structure:
;  (make-tank Number Number)
; interpretation (make-tank x dx) specifies the pos:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; a Missle is a Posn
; interpretation (make-posn x y) is the missle's location


; a SIGS is one of:
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missle)
; interpretation represents complete state of a space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missle])

; Tank Image -> Image
; adds t to the given image im
(check-expect (tank-render (make-tank 100 0) BACKGROUND)
              (place-image TANK 100 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(check-expect (tank-render (make-tank 20 -1) BACKGROUND)
              (place-image TANK 20 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(check-expect (tank-render (make-tank 150 5) BACKGROUND)
              (place-image TANK 150 (- SCENE-HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(define (tank-render t im)
  (place-image TANK (tank-loc t) (- SCENE-HEIGHT (/ (image-height TANK) 2)) im))

; UFO Image -> Image
; adds u to the given image im
(check-expect (ufo-render (make-posn 100 10) BACKGROUND)
              (place-image UFO 100 10 BACKGROUND))
(check-expect (ufo-render (make-posn 50 30) BACKGROUND)
              (place-image UFO 50 30 BACKGROUND))
(check-expect (ufo-render (make-posn 22 0) BACKGROUND)
              (place-image UFO 22 0 BACKGROUND))
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; Missle Image -> Image
; adds m to the given image im
(check-expect (missle-render (make-posn 50 50) BACKGROUND)
              (place-image MISSLE 50 50 BACKGROUND))
(check-expect (missle-render (make-posn 70 10) BACKGROUND)
              (place-image MISSLE 70 10 BACKGROUND))
(check-expect (missle-render (make-posn 160 180) BACKGROUND)
              (place-image MISSLE 160 180 BACKGROUND))
(define (missle-render m im)
  (place-image MISSLE (posn-x m) (posn-y m) im))

; SIGS -> Image
; renders given game state on top of BACKGROUND
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missle-render (fired-missle s) BACKGROUND)))]))

; SIGS -> SIGS
(check-random (si-move (make-aim (make-posn 100 100) (make-tank 100 0)))
              (make-aim (make-posn (+ 100 (* (random 3) (if (= (random 1) 0) -1 1))) 99)
                        (make-tank 100 0)))
(check-random (si-move (make-aim (make-posn 50 88) (make-tank 90 5)))
              (make-aim (make-posn (+ 50 (* (random 3) (if (= (random 1) 0) -1 1))) 87)
                        (make-tank 90 5)))
(check-random (si-move (make-aim (make-posn 89 5) (make-tank 33 10)))
              (make-aim (make-posn (+ 89 (* (random 3) (if (= (random 1) 0) -1 1))) 4)
                        (make-tank 33 10)))
(define (si-move s)
  (si-move-proper s (random 3) (random 1)))

; SIGS Number Number -> SIGS
(check-expect (si-move-proper (make-aim (make-posn 100 100) (make-tank 100 0)) 0 1)
              (make-aim (make-posn 100 99) (make-tank 100 0)))
(check-expect (si-move-proper (make-aim (make-posn 100 100) (make-tank 100 0)) 4 1)
              (make-aim (make-posn 104 99) (make-tank 100 0)))
(check-expect (si-move-proper (make-aim (make-posn 100 100) (make-tank 55 0)) 4 0)
              (make-aim (make-posn 96 99) (make-tank 55 0)))
(check-expect (si-move-proper (make-aim (make-posn 50 49) (make-tank 3 0)) 1 0)
              (make-aim (make-posn 49 48) (make-tank 3 0)))
(check-expect (si-move-proper (make-fired (make-posn 100 100) (make-tank 100 0) (make-posn 100 10)) 4 1)
              (make-fired (make-posn 104 99) (make-tank 100 0) (make-posn 100 10)))
(check-expect (si-move-proper (make-fired (make-posn 100 90) (make-tank 50 1) (make-posn 50 20)) 3 0)
              (make-fired (make-posn 97 89) (make-tank 50 1) (make-posn 50 20)))
(define (si-move-proper s delta dir)
  (cond
    [(aim? s)
     (make-aim (si-move-ufo (aim-ufo s) delta dir)
               (aim-tank s))]
    [(fired? s)
     (make-fired (si-move-ufo (fired-ufo s) delta dir)
                 (fired-tank s)
                 (fired-missle s))]))

; UFO Number Number -> UFO
(define (si-move-ufo u delta dir)
  (make-posn (+ (posn-x u) (* delta (if (= dir 0) -1 1)))
             (- (posn-y u) 1)))


; SIGS -> Bool
; returns true if game is over (UFO lands or missle hits UFO)
; returns false otherwise
(check-expect (si-game-over? (make-aim (make-posn 100 0) (make-tank 100 0))) #true)
(check-expect (si-game-over? (make-aim (make-posn 100 50) (make-tank 100 5))) #false)
(check-expect (si-game-over? (make-fired (make-posn 100 0) (make-tank 100 0) (make-posn 50 50))) #true)
(check-expect (si-game-over? (make-fired (make-posn 80 50) (make-tank 50 3) (make-posn 79 50))) #true)
(check-expect (si-game-over? (make-fired (make-posn 60 60) (make-tank 60 2) (make-posn 57 57))) #true)
(define (si-game-over? s)
  (cond
    [(aim? s)
     (<= (posn-y (aim-ufo s)) (/ (image-height UFO) 2))]
    [(fired? s)
     (if (>= 5
             (sqrt (+ (expt (- (posn-x (fired-ufo s)) (posn-x (fired-missle s))) 2)
                      (expt (- (posn-y (fired-ufo s)) (posn-y (fired-missle s))) 2))))
         #true
         (<= (posn-y (fired-ufo s)) (/ (image-height UFO) 2)))]))


; SIGS Key -> SIGS
; returns a new SIGS based on key input:
;   "left" sets tank vel to -3
;   "right sets tank vel to 3
;   " " fires rocket (changes SIGS aim to SIGS fired)
(check-expect (si-control (make-aim (make-posn 100 50) (make-tank 100 0)) "left")
              (make-aim (make-posn 100 50) (make-tank 100 -3)))
(check-expect (si-control (make-aim (make-posn 100 30) (make-tank 100 3)) "left")
              (make-aim (make-posn 100 30) (make-tank 100 -3)))
(check-expect (si-control (make-aim (make-posn 100 80) (make-tank 100 -3)) "right")
              (make-aim (make-posn 100 80) (make-tank 100 3)))
(check-expect (si-control (make-fired (make-posn 100 60) (make-tank 100 -3) (make-posn 100 20)) "left")
              (make-fired (make-posn 100 60) (make-tank 100 -3) (make-posn 100 20)))
(check-expect (si-control (make-fired (make-posn 100 60) (make-tank 100 3) (make-posn 100 20)) "right")
              (make-fired (make-posn 100 60) (make-tank 100 3) (make-posn 100 20)))
(check-expect (si-control (make-fired (make-posn 100 60) (make-tank 100 0) (make-posn 100 20)) "right")
              (make-fired (make-posn 100 60) (make-tank 100 3) (make-posn 100 20)))
(check-expect (si-control (make-fired (make-posn 100 60) (make-tank 100 -3) (make-posn 100 20)) " ")
              (make-fired (make-posn 100 60) (make-tank 100 -3) (make-posn 100 20)))
(check-expect (si-control (make-aim (make-posn 100 60) (make-tank 100 -3)) " ")
              (make-fired (make-posn 100 60) (make-tank 100 -3) (make-posn 100 (/ (image-height TANK) 2))))
(define (si-control s key)
  (cond
    [(string=? "left" key) (set-tank-vel s -3)]
    [(string=? "right" key) (set-tank-vel s 3)]
    [(and (string=? " " key) (aim? s)) (make-fired (aim-ufo s)
                                (make-tank (tank-loc (aim-tank s)) (tank-vel (aim-tank s)))
                                (make-posn (tank-loc (aim-tank s)) (/ (image-height TANK) 2)))]
    [else s]))

(define (set-tank-vel s v)
  (cond
    [(aim? s) (make-aim (aim-ufo s) (make-tank (tank-loc (aim-tank s)) v))]
    [(fired? s) (make-fired (fired-ufo s)
                            (make-tank (tank-loc (fired-tank s)) v)
                            (fired-missle s))]))
     
(define (main state)
  (big-bang state
    [on-tick si-move]
    [to-draw si-render]
    [on-key si-control]
    [stop-when si-game-over?]))