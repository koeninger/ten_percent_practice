;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname door) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; closes the door each tick
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
(define (door-closer door-state)
  (cond
    [(string=? LOCKED door-state) LOCKED]
    [(string=? CLOSED door-state) CLOSED]
    [(string=? OPEN door-state) CLOSED]))

; DoorState KeyEvent -> DoorState
; perform action on door, return the new state
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k)) CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k)) LOCKED]
    [(and (string=? CLOSED s) (string=? " " k)) OPEN]
    [else s]))

; DoorState -> Image
; draws door based on DoorState
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(define (door-render s)
  (text s 40 "red"))

; DoorState -> DoorState
; simulate automatic door
(define (door-sim init-state)
  (big-bang init-state
    [on-tick door-closer]
    [on-key door-action]
    [to-draw door-render]))