;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.2_itunes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/itunes)

(define example-date (create-date 2018 12 1 11 23 45))

(define example-track
  (create-track
   "inside the termite mound"
   "killing joke"
   "extremeties dirt and various repressed emotions"
   666
   22
   example-date
   3
   example-date))

(define example-Ltrack (list example-track))