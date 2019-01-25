;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex130) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

(cons "a" (cons "b" (cons "c" (cons "d" (cons "e" '())))))



(cons "1" (cons "2" '()))
; this is a List-of-names because "1" is a string, "2" is a string, and '() is a List-of-names
; grammar looks like this:
; (cons String (cons String List-of-names))


(cons 2 '())
; not a list of names because 2 is not a string