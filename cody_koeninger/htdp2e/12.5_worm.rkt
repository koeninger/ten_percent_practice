;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5_worm) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; diameter of a segment of the worm, same size as a cell in the rendering grid
(define DIAMETER 7)
; horizontal and vertical size of the grid
(define X-CELLS 100)
(define Y-CELLS 100)
(define BACKGROUND (empty-scene (* DIAMETER X-CELLS) (* DIAMETER Y-CELLS)))

; x and y position in terms of cells, x and y velocity in terms of cells
(define-struct world-state [x y v])

(define-struct velocity [x y])
; shorter accessors
(define (ws-x ws)
  (world-state-x ws))
(define (ws-y ws)
  (world-state-y ws))
(define (v-x ws)
  (velocity-x (world-state-v ws)))
(define (v-y ws)
  (velocity-y (world-state-v ws)))
; shorter creators
(define (mk-ws x y xv yv)
  (make-world-state x y (make-velocity xv yv)))

; cells moved per clock tick
(define SPEED 1)
(define INITIAL-STATE (mk-ws (/ X-CELLS 2) (/ Y-CELLS 2) SPEED 0))

; world-state -> world-state
; update x and y based on velocity
(check-expect (tick (mk-ws 0 0 1 1))
              (mk-ws 1 1 1 1))
(check-expect (tick (mk-ws 50 50 -1 1))
              (mk-ws 49 51 -1 1))
(define (tick ws)
  (mk-ws
   (+ (ws-x ws) (v-x ws))
   (+ (ws-y ws) (v-y ws))
   (v-x ws)
   (v-y ws)))

;; world-state KeyEvent -> world-state
;; update velocity based on arrow key, constrained to 90 degree movement
(check-expect (key (mk-ws 10 10 SPEED 0) "up")
              (mk-ws 10 10 0 (* -1 SPEED)))
(check-expect (key (mk-ws 10 10 0 SPEED) "left")
              (mk-ws 10 10 (* -1 SPEED) 0))
(check-expect (key (mk-ws 10 10 SPEED 0) "a")
              (mk-ws 10 10 SPEED 0))
(define (key ws k)
  (make-world-state
   (ws-x ws)
   (ws-y ws)
   (cond
     [(key=? k "left")
      (make-velocity (* -1 SPEED) 0)]
     [(key=? k "right")
      (make-velocity SPEED 0)]
     [(key=? k "up")
      (make-velocity 0 (* -1 SPEED))]
     [(key=? k "down")
      (make-velocity 0 SPEED)]
     [else (world-state-v ws)])))

; world-state -> image
; draw world
(check-expect (draw (mk-ws 10 20 0 0))
              (draw-segment 10 20 BACKGROUND))
(define (draw ws)
  (draw-segment (world-state-x ws) (world-state-y ws) BACKGROUND))

; x-cell y-cell image -> image
; draw one worm segment
(check-expect (draw-segment 10 20 BACKGROUND)
              (place-image/align
               (circle DIAMETER "solid" "red")
               (* 10 DIAMETER)
               (* 20 DIAMETER)
               "left"
               "top"
               BACKGROUND))
(define (draw-segment x y img)
   (place-image/align
    (circle DIAMETER "solid" "red")
    (* x DIAMETER)
    (* y DIAMETER)
    "left"
    "top"
    img))

; 216

;world-state -> boolean
; stop when worm hits wall
(check-expect (stop? (mk-ws 0 0 0 0)) #t)
(check-expect (stop? (mk-ws 0 Y-CELLS 0 0)) #t)
(define (stop? ws)
  (or (>= (ws-x ws) X-CELLS)
      (>= (ws-y ws) Y-CELLS)
      (<= (ws-x ws) 0)
      (<= (ws-y ws) 0)))

(define (draw-stop ws)
  (place-image/align
   (text "YOU DIED" 48 "black")
   (* .5 X-CELLS DIAMETER)
   (* .5 Y-CELLS DIAMETER)
   "center"
   "center"
   (draw ws)))

; clock ticks every rate seconds
(define (worm-main rate)
  (big-bang INITIAL-STATE
    [on-tick tick rate]
    [on-key key]
    [to-draw draw]
    [stop-when stop? draw-stop]))