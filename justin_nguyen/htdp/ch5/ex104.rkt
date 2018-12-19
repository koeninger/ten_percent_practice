;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex104) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



; structure Vehicle
;  passengers: max number of passengers
;  license: license number
;  mpg: miles per gallon
(define struct vehicle [passengers license mpg])

(define struct car [vehicle])
(define struct van [vehicle])
(define struct bus [vehicle])
(define struct suv [vehicle])

(define (vtemp v)
  (cond
    [(car? v) ...]
    [(van? v) ...]
    [(bus? v) ...]
    [(suv? v) ...]))