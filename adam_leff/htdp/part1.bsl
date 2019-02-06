//Exercise 1
(sqrt (+ (* x x) (* y y)))

//Exercise 2
(string-append prefix "_" suffix)

//Exercise 3
(string-append (substring str 0 i) "_" (substring str i (string-length str)))

//Exercise 4
(string-append (substring str 0 (- i 1)) (substring str i (string-length str)))

//Exercise 5
(overlay/offset
   (triangle 20 "solid" "green")
   0 18
   (rectangle 10 20 "solid" "brown"))
   
 //Exercise 6
 (* (image-width cat) (image-height cat))
 
 //Exercise 7
 (or (not sunny) friday)
 
 //Exercise 8
 (if (> (image-height cat) (image-width cat)) "tall"
      (if (> (image-width cat) (image-height cat)) "wide"
      "square"))
      
//Exercise 9
(if (string? in) (string-length in)
      (if (image? in) (* (image-height in) (image-width in))
          (if (number? in) (if (> 0 in) (- in 1) in)
              (if (boolean? in) (if in 10 20) false))))
              
//Exercise 11
(define (distance-to-origin x y)
  (sqrt (+ (* x x) (* y y))))

//Exercise 12
(define (cvolume l)
  (* l l l))
  
 (define (csurface l)
  (* 6 (* l l)))
  
 //Exercise 13
 (define (string-first s)
  (if (and (string? s) (> (string-length s) 0))
      (substring s 0 1)
      ""))

//Exercise 14
(define (string-last s)
  (if (and (string? s) (> (string-length s) 0))
      (substring s (- (string-length s) 1) (string-length s))
      ""))

//Exercise 15
(define (==> sunny friday)
  (or (not sunny) friday))
  
//Exercise 16
(define (image-area img)
  (* (image-width img) (image-height img)))

//Exercise 17
(define (image-classify img)
   (if (> (image-height img) (image-width img)) "tall"
      (if (> (image-width img) (image-height img)) "wide"
      "square")))
      
//Exercise 18
(define (string-join prefix suffix)
  (string-append prefix "_" suffix))
  
//Exercise 19
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i (string-length str))))
  
//Exercise 20
(define (string-delete str i)
  (string-append (substring str 0 (- i 1)) (substring str i (string-length str))))

//Exercise 21
No, it recalculates each time


//Exercise 22
Yes, it goes from the inside to the outside

//Exercise 23
By evaluating the string, then finding the 0th and 1st position

//Exercise 24
#false

//Exercise 25
tall and wide shouldn't be equal, it won't fall to the correct places that way

//Exercise 26
"hellow_orld"


//Exercise 27
(define FIXED-COST 180)
(define ORIGINAL-PRICE 5.0)
(define VARIABLE-COST 0.04)
(define ORIGINAL-ATTENDENCE 120)
(define DIFFERENCE-IN-ATTENDENCE 15)
(define CHANGE-IN-PRICE 0.10)

(define (attendees ticket-price)
  (- ORIGINAL-ATTENDENCE (* (- ticket-price ORIGINAL-PRICE) (/ DIFFERENCE-IN-ATTENDENCE CHANGE-IN-PRICE))))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
     
//Exercise 28
> (profit 1)
511.2
> (profit 2)
937.2
> (profit 3)
1063.2
> (profit 4)
889.2
> (profit 5)
415.2

> (profit 2.9)
1064.1
> (profit 2.8)
1062

//Exercise 29
(define PER-PERSON-COST 1.5)
(define ORIGINAL-PRICE 5.0)
(define VARIABLE-COST 0.04)
(define ORIGINAL-ATTENDENCE 120)
(define DIFFERENCE-IN-ATTENDENCE 15)
(define CHANGE-IN-PRICE 0.10)

(define (fixed-cost attendees)
  (* PER-PERSON-COST attendees))
(define (attendees ticket-price)
  (- ORIGINAL-ATTENDENCE (* (- ticket-price ORIGINAL-PRICE) (/ DIFFERENCE-IN-ATTENDENCE CHANGE-IN-PRICE))))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ (fixed-cost (attendees ticket-price)) (* VARIABLE-COST (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

> (profit 3)
613.2
> (profit 4)
664.2
> (profit 5)
415.2
> 

//Exercise 30
(define FIXED-COST 180)
(define ORIGINAL-PRICE 5.0)
(define VARIABLE-COST 0.04)
(define ORIGINAL-ATTENDENCE 120)
(define DIFFERENCE-IN-ATTENDENCE 15)
(define CHANGE-IN-PRICE 0.10)
(define CHANGE-PER-PERSON (/ DIFFERENCE-IN-ATTENDENCE CHANGE-IN-PRICE))

(define (attendees ticket-price)
  (- ORIGINAL-ATTENDENCE (* (- ticket-price ORIGINAL-PRICE) CHANGE-PER-PERSON)))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
     
//Exercise 34
1) We use string1 to represent characters
2) Consume a string and produce a string1
3) given: hello, expect h; given h, expect h; (define (string-first s) 'h')
4) (define (string-first s) ... s ...)
5) (define (string-first s) (substring s 0 1))
6) (string-first 'hello')

//Exercise 35
1) We use string1 to represent characters
2) Consume a string and produce a string1
3) given: hello, expect o; given h, expect h; (define (string-first s) 'o')
4) (define (string-last s) ... s ...)
5) (define (string-last s) (substring s (- (string-length s) 1)))
6) (string-first 'hello')

//Exercise 36
1) We use ints for length and width of the image
2) Consume an image and return an int
3) given: (image 10 10) return 100
4) (define (image-area img) ... img ...)
5) (define (image-area) (* (height img) (width img)))

//Exercise 37
1) We use strings here
2) Consume and return a string
3) given "hello" return "ello", given "hello world" return "ello world"
4) (define (string-rest s) ... s ...)
5) (define (string-rest s) (substring s 1))

//Exercise 38
1) Strings are represented by strings
2) Consume and return a string
3) given "hello" return "hell", given "hello world" return "hello worl"
4) (define (string-remove-last s) ... s ...)
5) (define (string-remove-last s) (substring s 0 (- (string-length s) 1)))

//Exercise 39
(require 2htdp/image)
(define WHEEL-RADIUS 10)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS 0 "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-BOTTOM (rectangle (* 6 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-TOP (rectangle (* 3 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-BODY (above CAR-TOP CAR-BOTTOM))
(define CAR (overlay/xy BOTH-WHEELS 0 (* -3 WHEEL-RADIUS) CAR-BODY))

//Exercise 40
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

//Exercise 41
(require 2htdp/image)
(require 2htdp/universe)
(define WHEEL-RADIUS 5)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS 0 "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-BOTTOM (rectangle (* 6 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-TOP (rectangle (* 3 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-BODY (above CAR-TOP CAR-BOTTOM))
(define CAR (overlay/xy BOTH-WHEELS 0 (* -3 WHEEL-RADIUS) CAR-BODY))
(define WIDTH-OF-WORLD 200)
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image TREE 50 30 (empty-scene WIDTH-OF-WORLD 50)))
(define Y-CAR (- 50 (* 2 WHEEL-RADIUS)))
 (define (render ws)
   (place-image CAR ws Y-CAR BACKGROUND))
 (define (tock ws)
  (+ ws 3))
 (define (end? ws)
   (> ws 200))
 (define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))
     
//Exercise 42
(define (render ws)
  (place-image CAR (+ ws (/ (image-width CAR) 2)) Y-CAR BACKGROUND))
  
 //Exercise 43
; AnimationState -> Image
; renders the x-th frame of animation
; on top of the BACKGROUND image 

; AnimationState -> AnimationState
; add 1 to x to get the next frame

(define (tock as)
    (+ as 1))

(define (render as)
  (place-image CAR (+ (* 3 as) (/ (image-width CAR) 2)) Y-CAR BACKGROUND))
  
  (require 2htdp/image)
(require 2htdp/universe)
(define WHEEL-RADIUS 5)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS 0 "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-BOTTOM (rectangle (* 6 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-TOP (rectangle (* 3 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-BODY (above CAR-TOP CAR-BOTTOM))
(define CAR (overlay/xy BOTH-WHEELS 0 (* -3 WHEEL-RADIUS) CAR-BODY))
(define WIDTH-OF-WORLD 200)
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image TREE 50 30 (empty-scene WIDTH-OF-WORLD 50)))
(define Y-CAR (- 50 (* 2 WHEEL-RADIUS)))
(define SINE-MULTIPLIER (/ (image-height CAR) 2))
 (define (render as)
   (place-image CAR (+ (* as 3) (/ (image-width CAR) 2)) (+ (* (sin as) SINE-MULTIPLIER) 15) BACKGROUND))
 (define (tock as)
  (+ as 1))
 (define (end? as)
   (> as 66))
 (define (main as)
   (big-bang as
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))
     
//Exercise 44
> (check-expect (hyper 21 10 20 "enter") 20)
> (check-expect (hyper 21 10 20 "enter") 21)
> (check-expect (hyper 42 10 20 "button-down") 10)
> (check-expect (hyper 42 10 20 "move") 42)
> 

//Exercise 45
(require 2htdp/image)
(require 2htdp/universe)
(define cat1 .)
(define BACKGROUND (empty-scene 400 (image-height cat1)))
(define (render ws)
  (place-image cat1 ws (/ (image-height cat1) 2) BACKGROUND))
(define (tock ws) (modulo (+ ws 3) 400))
(define (cat-prog ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

//Exercise 46
(require 2htdp/image)
(require 2htdp/universe)
(define cat1 .)
(define cat2 .)
(define BACKGROUND (empty-scene 400 (image-height cat1)))
(define (pick-cat ws)
  (if (odd? ws) cat1 cat2))
(define (render ws)
  (place-image (pick-cat ws) ws (/ (image-height cat1) 2) BACKGROUND))
(define (tock ws) (modulo (+ ws 3) 400))
(define (cat-prog ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

//Exercise 47
(require 2htdp/image)
(require 2htdp/universe)
(define BACKGROUND (empty-scene 50 20))
(define (render happiness)
  (place-image (rectangle (if (< happiness 100) happiness 100) 20 "solid" "red") 0 10 BACKGROUND))
(define (keypress happiness ke)
  (cond
    [(key=? ke "up") (+ happiness 33)]
    [(key=? ke "down") (+ happiness 20)]
    [else happiness]))
(define (tock happiness) (modulo (- happiness 1) 100))
(define (gague-prog happiness)
  (big-bang happiness
    [on-tick tock]
    [to-draw render]
    [on-key keypress]))

//Exercise 48
(cond
 ((<= 0 18 10) "bronze")
 ((and (< 10 18) (<= 18 20))
  "silver")
 (else "gold"))
 
 (cond
 (#false "bronze")
 ((and (< 10 18) (<= 18 20))
  "silver")
 (else "gold"))
 
 (cond
 ((and (< 10 18) (<= 18 20))
  "silver")
 (else "gold"))
 
 (cond
 ((and #true (<= 18 20)) "silver")
 (else "gold"))
 
 (cond
 ((and #true #true) "silver")
 (else "gold"))
 
 (cond (#true "silver") (else "gold"))
 
 "silver"
 
 //Exercise 49
 (define (create-rocket-scene.v5 h)
  (place-image ROCKET 50 (cond [(<= h ROCKET-CENTER-TO-TOP) h] [else ROCKET-CENTER-TO-TOP]) MTSCN))
  
//Exercise 50
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
    
//Exercise 51
(require 2htdp/image)
(require 2htdp/universe)
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
(define (render s)
  (place-image (circle 5 "solid" s) 10 10 (empty-scene 20 20)))
(define (tl s)
  (big-bang s
    [on-tick traffic-light-next]
    [to-draw render]))
    
//Exercise 52
3,4,5
4,5
3,4
4

/Exercise 53
(require 2htdp/image)
(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YD 3)
 
(define BACKGROUND  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))

(define (LR height)
  (place-image ROCKET (/ WIDTH 2) (- HEIGHT height 5) BACKGROUND))
  
//Exercise 54
(and (string? x) (string=? "resting" x))

//Exercise 55
(define (place x)
    (place-image ROCKET 10 (- x CENTER) BACKG))
    
    (define (show x)
      (cond
        [(string? x)
         (place HEIGHT]
        [(<= -3 x -1)
         (place-image (text (number->string x) 20 "red")
                      10 (* 3/4 WIDTH)
                      (place HEIGHT)]
        [(>= x 0)
         (place x)]))
         
//Exercise 56
(require 2htdp/image)
(require 2htdp/universe)
; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 

(define HEIGHT 100) ; distances in pixels 
(define WIDTH  100)
(define YD 3)
 
(define BACKGROUND  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))

(define CENTER (/ (image-height ROCKET) 2))

(define (LR height)
  (place-image ROCKET (/ WIDTH 2) (- HEIGHT height 5) BACKGROUND))

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YD))
(check-expect (fly 22) (- 22 YD))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YD)]))

(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- HEIGHT CENTER) BACKGROUND)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKGROUND))]
    [(>= x 0)
     (place-image ROCKET 10 (- x CENTER) BACKGROUND)]))

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(define (end? x)
  (and (not (string? x)) (= x 1)))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly 1]
    [stop-when end?]))

//Exercise 57 - Not done yet
(require 2htdp/image)
(require 2htdp/universe)
; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 

(define HEIGHT 100) ; distances in pixels 
(define WIDTH  100)
(define YD 3)
 
(define BACKGROUND  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))

(define CENTER (/ (image-height ROCKET) 2))

(define (LR height)
  (place-image ROCKET (/ WIDTH 2) (- HEIGHT height 5) BACKGROUND))

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (- 10 YD))
(check-expect (fly 22) (- 22 YD))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x HEIGHT) 0 (+ x 1))]
    [(>= x 0) (- x YD)]))

(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- 0 CENTER) BACKGROUND)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 0
                               BACKGROUND))]
    [(>= x 0)
     (place-image ROCKET 10 x BACKGROUND)]))

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(define (end? x)
  (and (not (string? x)) (= x HEIGHT)))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly 1]
    [stop-when end?]))
    
//Exercise 58
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))
(check-expect (sales-tax 10000) (* 0.08 10000))

(define MIDDLE 1000)
(define HIGH 10000)

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p MIDDLE)) 0]
    [(and (<= MIDDLE p) (< p HIGH)) (* 0.05 p)]
    [(>= p HIGH) (* 0.08 p)]))

//Exercise 59
(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (empty-scene 90 30))

; Color, mode, background -> Image
(define (place-light color mode background)
  (cond
    [(string=? color "red") (place-image (circle 10 mode color) 15 15 background)]
    [(string=? color "yellow") (place-image (circle 10 mode color) 45 15 background)]
    [(string=? color "green") (place-image (circle 10 mode color) 75 15 background)]))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (modulo (+ cs 1) 3))
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (cond
    [(= current-state 0) (place-light "red" "solid" (place-light "yellow" "outline" (place-light "green" "outline" BACKGROUND)))]
    [(= current-state 1) (place-light "red" "outline" (place-light "yellow" "solid" (place-light "green" "outline" BACKGROUND)))]
    [(= current-state 2) (place-light "red" "outline" (place-light "yellow" "outline" (place-light "green" "solid" BACKGROUND)))]))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))
    
    
//Exercise 61
The second is correct because it works no matter how the constants are defined

//Exercise 62
; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))
    
//Exercise 63
(distance-to-0 (make-posn 3 4))
(sqrt (+ (* 3 3) (* 4 4)))
(sqrt (+ 9 16))
(sqrt 25)
5

(distance-to-0 (make-posn 6 (* 2 4)))
(distance-to-0 (make-posn 6 8))
(sqrt (+ (* 6 6) (* 8 8)))
(sqrt (+ 36 64))
(sqrt 100)
10

(+ (distance-to-0 (make-posn 12 5)) 10)
(+ (sqrt (+ (* 12 12) (* 5 5))) 10)
(+ (sqrt (+ 144 25)) 10)
(+ (sqrt 169) 10)
(+ 13 10)
23

//Exercise 64
It doesn't matter which direction you go because you end up going the same number of steps horizontally and vertically no matter the path

(define (manhattan-distance p)
 (+ (abs (posn-x p)) (abs (posn-y p))))
 
//Exercise 65
(define-struct movie [title producer year])
make-movie
movie?
movie-title
movie-producer
movie-year

(define-struct person [name hair eyes phone])
make-person
person?
person-name
person-hair
person-eyes
person-phone

(define-struct pet [name number])
make-pet
pet?
pet-name
pet-number

(define-struct CD [artist title price])
make-CD
CD?
CD-artist
CD-title
CD-price

(define-struct sweater [material size producer])
make-sweater
sweater?
sweater-material
sweater-size
sweater-producer

//Exercise 66
(define-struct movie [title (string) producer (string) year (integer)])
(make-movie "Jurassic Park" "Steven Speilberg" 1991)

(define-struct person [name (string) hair (string) eyes (string) phone (string)])
(make-person "Cody" "Shaved" "Brown" "5555555")

(define-struct pet [name (string) number (integer)])
(make-pet "Mittens" 123)

(define-struct CD [artist (string) title (string) price (number)])
(make-CD "band" "album" 19.99)

(define-struct sweater [material (string) size (number) producer (string)])
(make-sweater "wool" 15 "name")

//Exercise 67
(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

(make-balld 5 "down")
this is a ball falling down at 3 pixels per tick at position 5

//Exercise 68
(make-ballf 30 40 -10 5)

//Exercise 70
(define-struct centry [name home office cell])
(centry-name (make-centry [name home office cell])) == name
(centry-home (make-centry [name home office cell])) == home
(centry-office (make-centry [name home office cell])) == office
(centry-cell (make-centry [name home office cell])) == cell


(define-struct phone [area number])
(phone-area (make-phone [area number])) == area
(phone-number (make-phone [area number])) == number

//Exercise 71
(game-ball game0)
(game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
(make-posn CENTER CENTER)
(make-posn 200 200)

(posn? (game-ball game0))
(posn? (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER))))
(posn? (make-posn CENTER CENTER))
(posn? (make-posn 200 200))
true

(game-left-player game0)
(game-left-player (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
MIDDLE
(quotient HEIGHT 2)
(quotient 200 2)
100

//Exercise 72
(define-struct phone [area number])
; A Phone is a structure:
;   (make-phone Number Number)
; interpretation (make-phone a n) means
; a phone number with an area code a
; and a local number n

(define-struct phone# [area switch num])
; A Phone# is a structure:
;   (make-phone# Number Number Number)
; interpretation (make-phone a s n) means
; a phone number with an area code a
; an exchange s
; and a local number n

//Exercise 73
; Posn Number -> Posn
; change x coordrinate of p to n
(define (posn-up-x p n)
    (make-posn n (posn-y p)))
    
//Exercise 74
(require 2htdp/universe)
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
  (make-posn 10 20))
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))
    
//Exercise 75
(define-struct vel [deltax deltay])

(define-struct ufo [loc vel])
(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))
 
(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))
 
(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determines where u moves in one clock tick; 
; leaves the velocity as is
 
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))
 
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))


(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))


//Exercise 76
; Movie is (make-movie String String Number)
(define-struct movie [title producer year])

; Person is (make-person String String String Phone)
(define-struct person [name hair eyes phone])

; Pet is (make-pet String Number)
(define-struct pet [name number])

; CD is (make-CD String String Number)
(define-struct CD [artist title price])

; Sweater is (make-sweater String Number String)
(define-struct sweater [material size producer])

// Exercise 77
; Daytime is (make-daytime Number Number Number)
(define-struct daytime [hours minutes seconds])

//Exercise 78
; ThreeLetterWord is (make-threeletterword 1String 1String 1String)
(define-struct threeletterword [first second third])

//Exercise 79
(make-color "white")

(make-h 50)

(make-person "adam" "leff" true)
bad idea because then you cant name the predicate that

(make-dog (make-person "adam" "leff" true) "fido" 5 (make-h 100))
interpretation a dog is owned by a person and is some percentage happy

(make-weapon (make-posn 100 100))

//Exercise 80
(define-struct movie [title director year])
(define (movie-consume m)
    (... (movie-title m) ... (movie-director m) ... (movie-year m) ....))

(define-struct pet [name number])
(define (pet-consume p)
    (... (pet-name p) ... (pet-number p) ...))

(define-struct CD [artist title price])
(define (cd-consume c)
    (... (CD-artist c) ... (CD-title c) ... (CD-price c) ...))

(define-struct sweater [material size color])
(define (sweater-consume s)
    (... (sweater-material s) ... (sweater-size s) ... (sweater-color s) ...))
    
//Exercise 81
; Daytime -> Number
; returns the number of seconds since the day started
(define (time->seconds dt)
    (+
        (daytime-seconds dt)
        (* (daytime-minutes dt) 60)
        (* (daytime-hours dt) (* 60 60))))
        
//Exercise 82
; Threeletterword -> ThreeLetterWord
; creates a Threeletterword where the letters which agree
; are returned, but the letters that don't match are false
(define (compare-word w1 w2)
    (make-threeletterword 
        (if (= (threeletterword-first w1) (threeletterword-first w2)) (threeletterword-first w1) #false)
        (if (= (threeletterword-second w1) (threeletterword-second w2)) (threeletterword-second w1) #false)
        (if (= (threeletterword-third w1) (threeletterword-third w2)) (threeletterword-third w1) #false)
    ))
    
//Exercise 83
(require 2htdp/image)
(define-struct editor [pre post])

; Editor -> image
(define (render e)
  (overlay/align "left" "center"
               (beside
                (text (editor-pre e) 11 "black")
                (rectangle 1 20 "solid" "red")
                (text (editor-post e) 11 "black"))
               (empty-scene 200 20)))

//Exercise 84
(require 2htdp/image)
(define-struct editor [pre post])

; Editor -> image
(define (render e)
  (overlay/align "left" "center"
               (beside
                (text (editor-pre e) 11 "black")
                (rectangle 1 20 "solid" "red")
                (text (editor-post e) 11 "black"))
               (empty-scene 200 20)))

(define (string-first s)
  (substring s 0 1))

(define (string-rest s)
  (substring s 1))

(define (string-last s)
  (substring s (- (string-length s) 1) (string-length s)))

(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1)))

; Editor KeyEvent -> Editor
(define (edit ed ke)
  (cond
    [(string=? ke "left") (make-editor
                           (string-remove-last (editor-pre ed))
                           (string-append (string-last (editor-pre ed)) (editor-post ed))
                           )]
    [(string=? ke "right") (make-editor
                            (string-append (editor-pre ed) (string-first (editor-post ed)))
                            (string-rest (editor-post ed))
                            )]
    [(string=? ke "\b") (make-editor
                         (string-remove-last (editor-pre ed))
                         (editor-post ed)
                         )]
    [(= (string-length ke) 1) (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
  )
)

// Exercise 85
(define (run initial-state)
    (big-bang initial-state
      [on-key edit]
      [to-draw render]))
      
// Exercise 86
(define MAX-LENGTH 50)

(define (edit ed ke)
  (cond
    [(string=? ke "left") (make-editor
                           (string-remove-last (editor-pre ed))
                           (string-append (string-last (editor-pre ed)) (editor-post ed))
                           )]
    [(string=? ke "right") (make-editor
                            (string-append (editor-pre ed) (string-first (editor-post ed)))
                            (string-rest (editor-post ed))
                            )]
    [(string=? ke "\b") (make-editor
                         (string-remove-last (editor-pre ed))
                         (editor-post ed)
                         )]
    [(= (string-length ke) 1) 
        (if (= (+ (string-length (editor-pre ed)) (string-length (editor-post ed))) MAX-LENGTH)
            (ed)
            (make-editor (string-append (editor-pre ed) ke) (editor-post ed)))]
  )
)

//Exercise 87
(define-struct editor [st idx])

(define (render ed)
    (overlay/align "left" "center"
         (beside
          (text (substring (editor-st ed) 0 (editor-idx ed)) 11 "black")
          (rectangle 1 20 "solid" "red")
          (text (substring (editor-st ed) (editor-idx ed)) 11 "black"))
         (empty-scene 200 20)))
         
(define (edit ed ke)
    (cond
     [(string=? ke "left") (make-editor
                            (editor-st ed)
                            (- (editor-idx ed) 1)
                            )]
     [(string=? ke "right") (make-editor
                             (editor-st ed)
                             (+ (editor-idx ed) 1)
                             )]
     [(string=? ke "\b") (make-editor
                            (string-append (substring (editor-st ed) 0 (- (editor-idx ed) 1)) (substring (editor-st ed) (+ (editor-idx ed) 1)))
                            (- (editor-idx ed) 1)
                          )]
     [(= (string-length ke) 1) (make-editor
                                (string-append
                                    (substring (editor-st ed) 0 (editor-idx ed))
                                    ke
                                    (substring (editor-st ed) (editor-idx ed))
                                )
                                (+ (editor-idx ed) 1)
                            )]
    )
)

//Exercise 88
(define-struct vcat [xcoord happy])
; A VCat is a structure:
; (make-vcat Number Number)
; interpretation (make-vcat x h) describes a cat
; at x-coodrinate x with happiness h

//Exercise 89
(define (happy-cat initial-state)
    (big-bang initial-state
        [to-draw render]
        [on-tick move]
        [on-key feed-pet]))
        
(define (move c)
    (make-vcat 
        (+ (vcat-xcoord c) 1)
        (- (vcat-happy c) 0.1)
    ))


(define cat1 .)
(define cat2 .)
(define BACKGROUND2 (empty-scene 400 (image-height cat1)))
(define (pick-cat ws)
  (if (odd? ws) cat1 cat2))

(define BACKGROUND1 (empty-scene 50 20))
(define (render c)
    (beside
      (place-image (rectangle (if (< (vcat-happy c) 100) (vcat-happy c) 100) 20 "solid" "red") 0 10 BACKGROUND1)
      (place-image (pick-cat (vcat-xcoord c)) (vcat-xcoord c) (/ (image-height cat1) 2) BACKGROUND2)))

    
(define (feed-pet c ke)
    (cond
        [(string=? ke "up") (make-vcat (vcat-xcoord c)
            (modulo (* (/ 4 3) (vcat-happy c)) 100))]
        [(string=? ke "up") (make-vcat (vcat-xcoord c)
            (modulo (* (/ 6 5) (vcat-happy c)) 100))]
    )
    )
    
(happy-cat (make-vcat 0 100))

//Exercise 90
(define (happy-cat initial-state)
    (big-bang initial-state
        [to-draw render]
        [on-tick move]
        [on-key feed-pet]
        [stop-when sad?]))
        
(define (sad? c)
    (= (vcat-happy c) 0))
    
//Exercise 91
(define-struct vcat [xcoord happy direction])
; A VCat is a structure:
; (make-vcat Number Number String)
; interpretation (make-vcat x h d) describes a cat
; at x-coodrinate x with happiness h
; direction d is either "l" or "r"

(define (move c)
    (make-vcat 
        (if (= vcat-direction "r") (+ (vcat-xcoord c) 1) (- (vcat-xcoord c) 1))
        (- (vcat-happy c) 0.1)
        (cond
            [(= (vcat-xcoord c) 50) "l"]
            [(= (vcat-xcoord c) 0) "r"]
        )
    ))
    
//Exercise 92
(define-struct vcham [xcoord happy color])

(define (chambg c)
  (rectangle (image-width cham)
             (image-height cham)
             "solid"
             c))
             
(define (cham initial-state)
    (big-bang initial-state
        [to-draw render]
        [on-tick move]
        [on-key feed-pet-color]))
        
(define (move c)
    (make-vcham
        (+ (vcham-xcoord c) 1)
        (- (vcham-happy c) 0.1)
        (vcham-color c)
    ))
    
(define (feed-pet-color c ke)
    (cond
        [(string=? ke "up") (make-vcham (vcham-xcoord c)
            (modulo (* (/ 4 3) (vcham-happy c)) 100)
            (vcham-color c))]
        [(string=? ke "down") (make-vcham (vcham-xcoord c)
            (modulo (* (/ 6 5) (vcham-happy c)) 100)
            (vcham-color c))]
        [(= ke "r") (make-vcham
            (vcham-xcoord c)
            (vcham-happy c)
            "red"
        )]
        [(= ke "g") (make-vcham
            (vcham-xcoord c)
            (vcham-happy c)
            "green"
        )]
        [(= ke "b") (make-vcham
            (vcham-xcoord c)
            (vcham-happy c)
            "blue"
        )]
    )
)


(define (render c)
    (beside
      (place-image (rectangle (if (< (vcham-happy c) 100) (vcham-happy c) 100) 20 "solid" "red") 0 10 BACKGROUND1)
      (place-image (overlay cham (chambg (vcham-color c)) (vcham-xcoord c) (/ (image-height cham) 2) BACKGROUND2))))
      
//Exercise 93
(define BACKGROUND
  (beside (empty-scene WIDTH HEIGHT "green") 
          (empty-scene WIDTH HEIGHT "white")
          (empty-scene WIDTH HEIGHT "red")))

(define (render c)
    (beside
      (place-image (rectangle (if (< (vcham-happy c) 100) (vcham-happy c) 100) 20 "solid" "red") 0 10 BACKGROUND1)
      (place-image cham (vcham-xcoord c) (/ (image-height cham) 2) BACKGROUND))))
      
//Exercise 95
3 instances are created by the second definition

//Exercise 97

(define (tank-render t im)
    (overlay/xy
        TANK
        (tank-x t)
        HEIGHT
        im))

(define (ufo-render u im)
    (overlay/xy
        UFO
        (posn-x u)
        (posn-y u)
        im))

(define (missile-render m im)
    (overlay/xy
        MISSLE
        (posn-x m)
        (posn-y m)
        im))
        
//Exercise 98
(define (si-game-over? s)
    (cond
        [(= (posn-y (sigs-UFO s)) 0) true]
        [(and (= (posn-y (sigs-UFO s)) (posn-y (sigs-Missile s))) (= (posn-x (sigs-UFO s)) (posn-x (sigs-Missile s)))) true]
        [false]))
        
//Exercise 116
1. This is a variable
2. This is a primitive with expressons after it
3. This is a primitive with a nested expression and then a variable

//Exercise 117
1. This is in the wrong order, the + needs to come first
2. This is a function without an argument
3. This is a variable which shouldnt have ()

//Exercise 118
all of these start with define, has a list of variables, and ends with an expression

//Exercise 119
1. Has an expression instead of a variable
2. Has an illegal expression at the end