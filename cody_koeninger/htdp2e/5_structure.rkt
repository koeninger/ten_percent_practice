;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5_structure) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; posn -> Number
; distance when following rectangular grid
(check-expect (manhattan-distance (make-posn 3 4)) 7)
(check-expect (manhattan-distance (make-posn 0 4)) 4)
(define (manhattan-distance p)
  (+ (posn-x p) (posn-y p)))

(define-struct movie [title producer year])
(define some-movie (make-movie "t" "p" 1977))
(check-expect (movie? some-movie) #true)
(check-expect (movie-title some-movie) "t")
(check-expect (movie-producer some-movie) "p")
(check-expect (movie-year some-movie) 1977)


(define-struct person [name hair eyes phone])
(define some-person (make-person "n" "h" "e" "5125551212"))
(check-expect (person? some-person) #true)
(check-expect (person-name some-person) "n")
(check-expect (person-hair some-person) "h")
(check-expect (person-eyes some-person) "e")
(check-expect (person-phone some-person) "5125551212")

(define-struct pet [name number])
(define some-pet (make-pet "gruff" 23))
; make-pet, pet?, pet-name, pet-number

(define-struct CD [artist title price])
(define some-cd (make-CD "bob seger" "blah" 23.99))
; make-CD, CD? CD-artist, CD-title, CD-price

(define-struct sweater [material size producer])
(define some-sweater (make-sweater "wool" "M" "gap"))
; make-sweater, sweater?, sweater-material, sweater-size, sweater-producer

(define-struct ball [location velocity])
(define SPEED 4)
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 20 "down")

(define-struct vel [deltax deltay])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define-struct ballf [x y deltax deltay])
(define ball1f
  (make-ballf 30 40 -10 5))

(define-struct centry [name home office cell])
(check-expect (centry-name (make-centry "n" "h" "o" "c")) "n")
(check-expect (centry-home (make-centry "n" "h" "o" "c")) "h")
(check-expect (centry-office (make-centry "n" "h" "o" "c")) "o")
(check-expect (centry-cell (make-centry "n" "h" "o" "c")) "c")


(define-struct phone [area number])
; (make-phone String String)
; interpretation area area code, number 7 digit phone number with or without -
(check-expect (phone-area (make-phone "a" "n")) "a")
(check-expect (phone-number (make-phone "a" "n")) "n")


(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(define-struct phone# [area switch num])
; (make-phone# Number Number Number)
; interpretation area 3 digit area code, switch 3 digit neighborhood switch, num remaining 4 digits
; e.g. (512) 555-1212 : area 512 switch 555 num 1212

; Posn Number -> Posn
; updates the x coordinate of Posn p, replacing it with n
(check-expect (posn-up-x (make-posn 10 20) 13) (make-posn 13 20))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
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


(define-struct ufo [loc vel])
; A UFO is a structure: 
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v

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

; Posn Vel -> Posn 
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))


; string person number -> movie
(define-struct movie2 [title producer year])

; string string string phone# -> person2
(define-struct person2 [name hair eyes phone])

; string number -> pet2
(define-struct pet2 [name number])

; person string number -> CD2
(define-struct CD2 [artist title price])

; string string person -> sweater2
(define-struct sweater2 [material size producer])

; number number number -> time
; time since midnight
(define-struct time [hours minutes seconds])

; 1string 1string 1string -> 3-letter-word
; restricted to a-z and #false (ugh)
(define-struct 3-letter-word [first second third])


; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black" 
(define a-color "blue")

; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define an-H 99)

(define-struct person3 [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean) 
(define a-person3 (make-person3 "bob" "goon" #true))

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H) 
(define a-dog (make-dog a-person3 "ted" 23 an-H))


; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight
(define a-weapon #false)
(define another-weapon (make-posn 23 42))



(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; r3 -> Number
; distance of object in 3d space to the origin
(check-within (distance-to-origin (make-r3 2 3 4)) (sqrt (+ (expt 2 2) (expt 3 2) (expt 4 2))) 0.01)
(define (distance-to-origin r)
  (sqrt (+ (expt (r3-x r) 2) (expt (r3-y r) 2) (expt (r3-z r) 2))))

;(define (eat-movie m)
;  ... (movie-title m) ... (movie-director m) ... (movie-year m) ...)
;
;(define (eat-pet p)
;  ... (pet-name p) ... (pet-number p) ...)
;
;(define (eat-CD c)
;  ... (CD-artist c) ... (CD-title c) ... (CD-price c) ...)
;
;(define (eat-sweater s)
;  ... (sweater-material s) ... (sweater-size s) ... (sweater-color s))

; time -> number
; number of seconds since midnight
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* 60 60 (time-hours t))
     (* 60 (time-minutes t))
     (time-seconds t)))

; 3-letter-word 3-letter-word -> 3-letter-word
; for each letter, #false if they differ, otherwise the letter
(check-expect (compare-word (make-3-letter-word "a" "b" "c") (make-3-letter-word "a" "b" "c")) (make-3-letter-word "a" "b" "c"))
(check-expect (compare-word (make-3-letter-word "a" "b" "c") (make-3-letter-word "a" "e" "c")) (make-3-letter-word "a" #false "c"))
(define (compare-word w x)
  (make-3-letter-word
   (compare-letter (3-letter-word-first w) (3-letter-word-first x))
   (compare-letter (3-letter-word-second w) (3-letter-word-second x))
   (compare-letter (3-letter-word-third w) (3-letter-word-third x))))

; 1string 1string -> 1string
; if letters are different, #false, otherwise the letter
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(define (compare-letter x y)
  (if (string=? x y) x #false))


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define cursor (rectangle 1 20 "solid" "red"))
(define editor-font-size 16)
(define background (empty-scene 200 20))
(define (editor-text s) (text s editor-font-size "black"))

; editor -> image
; render editor
(check-expect (render (make-editor "qui" "ck"))
              (place-image/align (beside (editor-text "qui") cursor (editor-text "ck")) 0 0 "left" "top" background))
(define (render e)
  (place-image/align (beside (editor-text (editor-pre e)) cursor (editor-text (editor-post e))) 0 0 "left" "top" background))

; editor keyevent -> editor
; effect of keyevent on new state of editor
(check-expect (edit (make-editor "" "a") "\t") (make-editor "" "a"))
(check-expect (edit (make-editor "" "a") "\r") (make-editor "" "a"))
(check-expect (edit (make-editor "" "a") "\b") (make-editor "" "a"))
(check-expect (edit (make-editor "ab" "cd") "\b") (make-editor "a" "cd"))
(check-expect (edit (make-editor "" "a") "left") (make-editor "" "a"))
(check-expect (edit (make-editor "a" "") "left") (make-editor "" "a"))
(check-expect (edit (make-editor "" "a") "right") (make-editor "a" ""))
(check-expect (edit (make-editor "a" "") "right") (make-editor "a" ""))
(check-expect (edit (make-editor "" "") "x") (make-editor "x" ""))
(check-expect (edit (make-editor "a" "b") "x") (make-editor "ax" "b"))
(define (edit e k)
  (cond
    [(or (key=? k "\t") (key=? k "\r") (key=? k "\r") (key=? k "shift") (key=? k "rshift"))
     e]
    [(key=? k "\b")
     (make-editor (string-remove-last (editor-pre e)) (editor-post e))]
    [(key=? k "left")
     (make-editor (string-remove-last (editor-pre e)) (string-append (string-last (editor-pre e)) (editor-post e)))]
    [(key=? k "right")
     (make-editor (string-append (editor-pre e) (string-first (editor-post e))) (string-remove-first (editor-post e)))]
    [else
     (if (editor-full? e)
         e
         (make-editor (string-append (editor-pre e) k) (editor-post e)))]))

; editor -> boolean
; whether the amount of text in the editor completely fills background
(check-expect (editor-full? (make-editor "" "")) #false)
(check-expect (editor-full? (make-editor "1234567890" "123456789012")) #true)
(define (editor-full? e)
  (>= (image-width (editor-text (string-append " " (editor-pre e) (editor-post e))))
     (image-width background)))

; string -> string
(check-expect (string-remove-last "") "")
(check-expect (string-remove-last "ab") "a")
(define (string-remove-last s)
  (if (< (string-length s) 1)
      ""
      (substring s 0 (sub1 (string-length s)))))

; string -> string
(check-expect (string-last "") "")
(check-expect (string-last "ab") "b")
(define (string-last s)
  (if (< (string-length s) 1)
      ""
      (string-ith s (sub1 (string-length s)))))

; string -> string
(check-expect (string-remove-first "") "")
(check-expect (string-remove-first "ab") "b")
(define (string-remove-first s)
  (if (< (string-length s) 1)
      ""
      (substring s 1)))

; string -> string
(check-expect (string-first "") "")
(check-expect (string-first "ab") "a")
(define (string-first s)
  (if (< (string-length s) 1)
      ""
      (string-ith s 0)))


; given a starting pre field for editor, runs interactive editor
(define (run pre)
  (big-bang (make-editor pre "")
    [to-draw render]
    [on-key edit]))