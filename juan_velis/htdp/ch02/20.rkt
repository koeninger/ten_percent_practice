;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |20|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define str "helloworld")
(define i 9)

(define (string-delete string x)
  (string-append
   (substring string 0 x)
   (substring string (+ x 1) (string-length string))
  )
 )

(string-delete str i)
