;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |02|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
"hello world"
(string-append "hello" "world")
(string-append "hello " "world")
(string-append "hello" " " "world")
(+ (string-length "hello world") 20)
"-------"
(number->string 42)
(string->number "42")
(string->number "hellow world")
"-------"
(and #true #true)
(and #true #false)
(or #true #false)
(or #false #false)
(not #false)
"-------"
(> 10 9)
(< -1 0)
(= 42 9)
"-------"
(>= 10 10)
(<= -1 0)
(string=? "design" "tinker")
"-------"
(and (or (= (string-length "hello world")
            (string->number "11"))
         (string=? "hello world" "good morning"))
     (>= (+ (string-length "hello world") 60) 80))
"-------"