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
Why is this not right?