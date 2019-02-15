;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |115|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]
  )
)

(define MESSAGE "traffic light expected, given: some other value")

(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error MESSAGE)
   )
)
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)


(define MSG1 "traffic light expected for parameter 1")
(define MSG2 "traffic light expected for parameter 2")

; Any Any -> Boolean
(define (light=?-2 a-value another-value)
  (if (light? a-value)
      (if (light? another-value)
          (string=? a-value another-value)
          (error MSG2))
      (error MSG1)
  )
)
(check-expect (light=?-2 "red" "red") #true)
(check-expect (light=?-2 "red" "green") #false)
(check-expect (light=?-2 "green" "green") #true)
(check-expect (light=?-2 "yellow" "yellow") #true)