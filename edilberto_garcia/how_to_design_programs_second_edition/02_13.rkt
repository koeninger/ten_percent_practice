;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 13. Define the function string-first,
;which extracts the first 1String from a non-empty string.


(define (string-first sequence)
  (if
      (> (string-length sequence) 0)
      (string-ith sequence 0)
      ""
  )
)