;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |04|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define str "helloworld")
(define i 5)

; legitimate values for x are x>1 to x<=(length of string)
(define (delete-char string x)
  (string-append (substring string 0 (- x 1)) (substring string x )))

(delete-char str 5)