;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |104|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; passengers, plate, mpg
(define-struct vehicle [passengers plate mpg])

(define automobile (make-vehicle 4 "abc" 14))
(define van (make-vehicle 10 "def" 10))
(define bus (make-vehicle 20 "ghi" 3))
(define suv (make-vehicle 6 "jkl" 11))

; Find the mpg of a vehicle based on the passenger number
; int -> vehicle
(define (vmpg n) 
  (cond
    [(< n 5) (vehicle-mpg automobile)]
    [(= n 6) (vehicle-mpg suv)]
    [(= n 10) (vehicle-mpg van)]
    [(>= n 20) (vehicle-mpg bus)]
    [else #false]
  )                         
)

(check-expect (vmpg 10) 10)
(check-expect (vmpg 6) 11)
(check-expect (vmpg 30) 3)
