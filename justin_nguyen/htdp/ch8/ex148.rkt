;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex148) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; it's easier / cleaner to write code that deals with non-empty lists.
; if empty lists need to be handled, we can write a function that checks the list
; first before calling the actual function we want to call;
; for example, checked-all-true will call all-true when we need to check for empty lists