;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |57|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the distance between the ground
; and the rocket’s point of reference, say, its center (its height)

(define HEIGHT 0) ; distances in pixels
(define BACKG-HEIGHT 300)
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH BACKG-HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; Number -> Image
; Places the rocket on a background at the given height
(check-expect (place-rocket 30) (place-image ROCKET 10 (- 30 CENTER) BACKG))
(define (place-rocket x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect (show "bob") (place-rocket (- BACKG-HEIGHT HEIGHT)))
(check-expect (show -2) (place-image (text (number->string -2) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket (- BACKG-HEIGHT HEIGHT))))
(check-expect (show 30) (place-rocket (- BACKG-HEIGHT 30)))
(define (show x)
  (cond
    [(string? x)
     (place-rocket (- BACKG-HEIGHT HEIGHT))]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket (- BACKG-HEIGHT HEIGHT)))]
    [(>= x 0)
     (place-rocket (- BACKG-HEIGHT x))]))

; Number, String -> Number
; Determines launch position based on keyboard event
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

; LRCD -> Boolean
; Tell whether the rocket has launched off the background
(check-expect (launched "sdfsd") #false)
(check-expect (launched BACKG-HEIGHT) #true)
(check-expect (launched 34) #false)
(define (launched x)
  (cond
    [(string? x) #false]
    [(= x BACKG-HEIGHT) #true]
    [else #false]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [on-tick fly]
    [to-draw show]
    [on-key launch]
    [stop-when launched]))

; Most of the code is the same.  The launch position doesn't change, most of the logic
;  stays the same.  Even the most of the constants do not change.  Big bang is the same
; What's different is how we establish the height state, we use height for the rocket now
;  but need to setup the canvas size for the rocket to work in.  What's nice is we can
;  change the canvas size without really affecting the state of LRCD where before it
;  was related to it.  Also, because of that swap we now add to the height and update
;  code where the next height is calculated and how we stop the program.  That and how
;  we place the rocket