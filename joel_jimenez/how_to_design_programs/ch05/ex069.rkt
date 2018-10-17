;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex069) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])
(make-movie "The Revenant" "Alejandro G. Iñárritu" 2015)
; +-------------------------------------------------+
; |                                           movie |
; +-------------------------------------------------+
; | title          | producer                | year |
; +----------------+-------------------------+------+
; | "The Revenant" | "Alejandro G. Iñárritu" | 2015 |
; +----------------+-------------------------+------+

(define-struct person [name hair eyes phone])
(make-person "Joel" "black" "brown" "555-666-7771")
; +---------------------------------------------+
; |                                      person |
; +---------------------------------------------+
; | name   | hair    | eyes    | phone          |
; +--------+---------+---------+----------------+
; | "Joel" | "black" | "brown" | "555-666-7771" |
; +--------+---------+---------+----------------+

(define-struct pet [name number]])
(make-pet "Snoopy" 1950)
; +-------------------+
; |               pet |
; +-------------------+
; | name     | number |
; +----------+--------+
; | "Snoopy" | 1950   |
; +----------+--------+

(define-struct CD [artist title price])
(make-pet "Nirvana" "Nevermind" 19.91)
; +---------------------------------+
; |                              CD |
; +---------------------------------+
; | artist    | title       | price |
; +-----------+-------------+-------+
; | "Nirvana" | "Nevermind" | 19.91 |
; +-----------+-------------+-------+

(define-struct sweater [material size producer])
(make-sweater "cotton" "large" "American")
; +---------------------------------+
; |                         sweater |
; +---------------------------------+
; | material | size    | producer   |
; +----------+---------+------------+
; | "cotton" | "large" | "American" |
; +----------+---------+------------+
