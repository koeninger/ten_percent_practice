;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex57) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)


(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))
(define (render y)
  (place-image ROCKET 10 (- HEIGHT y) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket 
(define (show x)
  (cond
    [(string? x)
     (render CENTER)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (render CENTER))]
    [(>= x 0)
     (render (+ x CENTER))]))

; LCRD -> LCRD
; check for launch conditions ("space bar" input) and count down if launching
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already(define (fly x)
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) CENTER (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

(define (end x)
  (cond
    [(string? x) #false]
    [(= x HEIGHT) #true]
    [else #false]))


(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
 
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))
 
(check-expect
 (show 53)
 (place-image ROCKET 10 (- HEIGHT (+ 53 CENTER)) BACKG))

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)


(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) CENTER)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))

(check-expect (end "resting") #false)
(check-expect (end -3) #false)
(check-expect (end -2) #false)
(check-expect (end 300) #true)
(check-expect (end 1) #false)
(check-expect (end 10) #false)
(check-expect (end 200) #false)


; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [on-tick fly]
    [to-draw show]
    [on-key launch]
    [stop-when end]))

                     