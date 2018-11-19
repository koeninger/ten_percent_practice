;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |62|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

; DoorState -> DoorState
; Closes the door if it is open taking one tick to complete
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
(define (door-closer ds)
  (cond
    [(string=? LOCKED ds) LOCKED]
    [(string=? CLOSED ds) CLOSED]
    [(string=? OPEN ds) CLOSED]))

; DoorState, String -> DoorState
; When a key is pressed, perform set action if available
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
(define (door-action ds key)
  (cond
    [(and (string=? LOCKED ds) (string=? "u" key)) CLOSED]
    [(and (string=? CLOSED ds) (string=? "l" key)) LOCKED]
    [(and (string=? CLOSED ds) (string=? " " key)) OPEN]
    [else ds]))

; DoorState -> Image
; Produce an image based on the state of the door
(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))
(define (door-render ds)
  (text ds 40 "red"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))