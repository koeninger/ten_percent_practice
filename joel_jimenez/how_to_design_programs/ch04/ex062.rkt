;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex062) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; DoorState -> DoorState
; closes an open door over the period of one tick
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))

; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "") OPEN)
(define (door-action state-of-door key-event)
  (cond
    [(and (string=? LOCKED state-of-door) (string=? "u" key-event))
     CLOSED]
    [(and (string=? CLOSED state-of-door) (string=? "l" key-event))
     LOCKED]
    [(and (string=? CLOSED state-of-door) (string=? " " key-event))
     OPEN]
    [else state-of-door]))

; DoorState -> Image
; translates the state s into a large text image
(check-expect (door-render CLOSED)
  (text CLOSED 40 "red"))
(define (door-render state-of-door)
  (text state-of-door 40 "red"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))

(door-simulation CLOSED)
