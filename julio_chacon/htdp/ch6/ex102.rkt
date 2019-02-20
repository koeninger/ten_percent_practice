;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex102) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct ufo [x y])
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define-struct missile [x y])
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


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


;(define-struct aim [ufo tank])
;     (make-aim (make-posn 20 10) (make-tank 28 -3))

;(define-struct fired [ufo tank missile])
;(make-fired (make-posn 20 10)
 ;(make-tank 28 -3)
  ;(make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT)))



(define CANVAS-WIDTH 400)
(define CANVAS-HEIGHT 400)
(define BACKGROUND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT))


(define TANK-HEIGHT 20)
(define TANK (rectangle 40 TANK-HEIGHT "solid" "green"))
(define TANK-SPEED 2)

(define MISSILE (triangle (* TANK-HEIGHT .5) "solid" "black"))
(define MISSILE-SPEED 5)

(define UFO-WIDTH 40)
(define UFO-HEIGHT 20)
(define UFO-IMPACT 15)
(define UFO (ellipse UFO-WIDTH UFO-HEIGHT "solid" "red"))
(define UFO-SPEED .5)

(define START-GAME (make-sigs
  (make-posn 200 100)
  (make-tank 200 TANK-SPEED)
  #false
  ))



; SIGS.v2 -> Image 
; renders the given game state on top of BACKGROUND 
(define (si-render.v2 s)
  (place-images
   (list-items s)
   (list-pos s)
   BACKGROUND)
  )



(define (list-items s)
  (cond
    [(boolean? (sigs-missile s)) (list TANK UFO)]
    [else (list TANK UFO MISSILE)])
  )

(define (list-pos s)
  (cond
    [(boolean? (sigs-missile s)) (list (make-posn  (tank-loc (sigs-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5))) (sigs-ufo s))]
    [else (list (make-posn  (tank-loc (sigs-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5))) (sigs-ufo s) (sigs-missile s) ) ]
    )
  )


;(define (si-render-missile s)
 ; (place-images
  ; (list
     ; TANK
     ; UFO
     ; MISSILE)
  ; (list
   ; (make-posn  (tank-loc (sigs-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
    ;(sigs-ufo s)
     ;(sigs-missile s))
  ; BACKGROUND)
  ;)

;(define (si-render-aim s)
 ; (place-images
  ; (list
   ;   TANK
    ;  UFO 
     ; )
  ; (list (make-posn (tank-loc (sigs-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
   ;      (sigs-ufo s))
  ; BACKGROUND)
  ;)



;(define (si-render s)
  ;(cond
    ;[(aim? s)
    ; (si-render-aim s)]
    ;[(fired? s)
      ;(si-render-missile s)]))


(define (missil-impact m u)
  (cond
    [ (>= UFO-IMPACT ( sqrt ( + (sqr(-(posn-x m) (posn-x u)) )
                                (sqr(- (posn-y m) (posn-y u)) )))
          ) #true]
    [else #false]
  ))

(define (ufo-landed u)
  (cond
    [ (<= (posn-y u) (- CANVAS-HEIGHT (* UFO-HEIGHT .5)) ) #false ]
    [else #true])
  )

(define (si-game-over? s)
  (cond
    [(boolean? (sigs-missile s)) (ufo-landed (sigs-ufo s))]
    [else (missil-impact (sigs-ufo s) (sigs-missile s) )]
    ))



(define (move-ufo pos delta)
  (cond
    [ delta
      (make-posn (+ (posn-x pos) 5) (+ (posn-y pos) UFO-SPEED))]
    [else
      (make-posn (- (posn-x pos) 5) (+ (posn-y pos) UFO-SPEED))]
  ))


(define (move-tank t)
  (cond
    [(< (tank-loc t) 0) (make-tank 0 0)]
    [(> (tank-loc t) CANVAS-WIDTH) (make-tank CANVAS-WIDTH 0)]
    [else (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t))]))


(define (random-move n)
  (cond
    [(even? (random n)) #true ]
    [else #false])
  )

(define (si-move s)
  (cond
    [(boolean? (sigs-missile s))
     (make-sigs
      (move-ufo (sigs-ufo s) (random-move 6))
      (move-tank (sigs-tank s))
      #false)]
    [else (make-sigs
      (move-ufo (sigs-ufo s) (random-move 6))
      (move-tank (sigs-tank s))
      (si-move-missile s))]
 ))

(define (si-move-missile s)
 (make-posn (posn-x (sigs-missile s)) (- (posn-y (sigs-missile s)) MISSILE-SPEED ) )
  )


(define (si-control s key)
     (cond
       [(key=? key "left") (make-sigs
                            (sigs-ufo s)
                            (make-tank (+ (tank-loc (sigs-tank s)) -2) -2)
                            (sigs-missile s))]
       [(key=? key "right") (make-sigs
                            (sigs-ufo s)
                            (make-tank (+ (tank-loc (sigs-tank s)) 2) 2)
                            (sigs-missile s))]
       [(key=? key " ") (make-sigs
                         (sigs-ufo s)
                         (sigs-tank s)
                         (make-posn (tank-loc (sigs-tank s)) (- CANVAS-HEIGHT TANK-HEIGHT) )) ]
       [else s]) 
  )


 
(define (si-main s)
  (big-bang s
    [on-tick si-move]
    [on-key si-control]
    [to-draw si-render.v2]
    [stop-when si-game-over?]))

(si-main START-GAME)


