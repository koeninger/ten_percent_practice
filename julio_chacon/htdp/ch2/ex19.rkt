;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (string-insert s n) (
   if
   (< (string-length s) n )
      "string not long enought"
      (string-append (substring s 0 n) "_" (substring s n))

      )
)

(string-insert "" 3)
(string-insert "one" 2)