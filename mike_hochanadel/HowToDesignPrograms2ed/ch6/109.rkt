;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |109|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; sequence pattern of keyevents
; 100 x 100 white rectangle
; first desired letter -> yellow rectangle 100 x 100
; final desired letter -> green rectangle 100 x 100
; any undesired letter -> red rectangle 100 x 100

; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 

(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define START_IMAGE (rectangle 100 100 "solid" "white"))
(define WORKING_IMAGE (rectangle 100 100 "solid" "yellow"))
(define ERROR_IMAGE (rectangle 100 100 "solid" "red"))
(define GOOD_IMAGE (rectangle 100 100 "solid" "green"))

; ExpectsToSee.v2 -> Image
; render the current state of the world program
(check-expect (render AA) START_IMAGE)
(check-expect (render BB) WORKING_IMAGE)
(check-expect (render DD) GOOD_IMAGE)
(check-expect (render ER) ERROR_IMAGE)
(check-expect (render "DSFDFS") ERROR_IMAGE)
(define (render e)
  (cond
    [(string=? e AA) START_IMAGE]
    [(string=? e BB) WORKING_IMAGE]
    [(string=? e DD) GOOD_IMAGE]
    [(string=? e ER) ERROR_IMAGE]
    [else ERROR_IMAGE]))

; ExpectsToSee.v2, KeyEvent -> ExpectsToSee.v2
; handler determines the next state based on a key event coming in.
; 'a' starts the sequence.  'b' or 'c' continues it.  'd' ends it.
; if there are any KeyEvents outside of that sequence, we get an error.
(check-expect (handler AA "a") BB)
(check-expect (handler AA "b") AA)
(check-expect (handler BB "b") BB)
(check-expect (handler BB "c") BB)
(check-expect (handler BB "d") DD)
(check-expect (handler BB "a") ER)
(check-expect (handler ER "a") ER)
(check-expect (handler DD "a") DD)
(define (handler e k)
  (cond
    [(string=? e AA)
     (cond
       [(string=? k "a") BB]
       [else AA])]
    [(string=? e BB)
     (cond
       [(or (string=? k "b") (string=? k "c")) BB]
       [(string=? k "d") DD]
       [else ER])]
    [else e]))

; ExpectsToSee.v2 -> ExpectsToSee.v2
; abcd looks for a sequence of characters specified by the world state.
;   It will exit on the end states
(define (abcd e)
  (big-bang e
    [on-key handler]
    [to-draw render]))