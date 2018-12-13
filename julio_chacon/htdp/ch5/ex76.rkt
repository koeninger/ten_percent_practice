;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A BS is one of: 
; — "hello",
; — "world", or
; — pi.


(make-posn "hello" 0)
(make-posn (make-posn 0 1) 2)

(define-struct ball [location velocity])

(make-ball 3 3)

(define-struct movie [title producer year])
(make-movie "title" "producer" 2018)

(define-struct person [name hair eyes phone])
(make-person "name" "red" "blue" "555-432-1234")

(define-struct pet [name number])
(make-pet "fido" 12345)

(define-struct CD [artist title price])
(make-CD "artist" "title" 34.23)

(define-struct sweater [material size producer])
(make-sweater "nylon" "L" "producer")