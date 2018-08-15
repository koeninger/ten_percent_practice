;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01_09) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define in ...)

;Then create an expression that converts the value of in to a positive number.
;For a String, it determines how long the String is; for an Image, it uses the area;
;for a Number, it decrements the number by 1, unless it is already 0 or negative;
;for #true it uses 10 and for #false 20.

(if (string? in)
    (string-length in) ;return length
    (if (image? in)
        (* (image-width in) (image-height in)) ;return area
        (if (number? in)
            (if (> in 0)
                (- in 1) ;retun 1 - in 
                in ;return in for zero or negative
            )
            (if (boolean? in)
                (if in
                    10 ;return 10 for true
                    20 ; return 20 for false
                    )
                "WHAT THE FUCK" ;fallback
             )
         )
      )
    )