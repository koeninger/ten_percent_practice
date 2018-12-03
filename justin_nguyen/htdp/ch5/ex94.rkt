;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SCENE-WIDTH 400)
(define SCENE-HEIGHT 200)
(define BUILD-WIDTH 20)
(define BUILD-COLOR "dimgray")
(define BUILD-WINDOW-COLOR "gray")
(define WINDOW (rectangle 15 15 "solid" BUILD-WINDOW-COLOR))
(define BUILDING-UNIT-WINDOW (overlay/offset WINDOW
                                             0 0
                                             (rectangle BUILD-WIDTH BUILD-WIDTH "solid" BUILD-COLOR)))
(define BUILDING-UNIT (rectangle BUILD-WIDTH BUILD-WIDTH "solid" BUILD-COLOR))

(define TANK (rectangle 70 20 "solid" "green"))
(define UFO (overlay
             (beside (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white")
                     (circle 4 "solid" "white"))
             (ellipse 80 20 "solid" "gray")))

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




