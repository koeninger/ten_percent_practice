;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex56) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight

;(define (LR rh)
 ; (cond
  ;  [(string?  rh) 0]
   ; [ (> rh 0) (+ rh 3)]) 
  ;)


;(check-expect (LR "resting") 0)
;(check-expect (LR HEIGHT) 303)

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)


; LRCD -> Image
; renders the state as a resting or flying rocket

;because x could be an integer or even other string that is not "resting"

(define (renderImage x)
  (place-image ROCKET 10 (- x CENTER) BACKG)
  )


(define (show x)
  (cond
    [(string? x)
     (renderImage HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                   (renderImage HEIGHT))]
    [(>= x 0)
     (renderImage x)]
)
)
;(show "resting")
;(show -3)
;(show 10)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

;(check-expect (launch "resting" " ") -3)
;(check-expect (launch "resting" "a") "resting")
;(check-expect (launch -3 " ") -3)
;(check-expect (launch -1 " ") -1)
;(check-expect (launch 33 " ") 33)
;(check-expect (launch 33 "a") 33)

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

(define (stop-animtaion x)
  
  (if (= x 0) #true #false))

(define (main2 s)
  (big-bang s
    [on-tick fly .2]
    [to-draw show]
    [on-key launch]
    [stop-when stop-animtaion]))


(main2 -3)

; after animation rocket passes HEIGHT it loops back

