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

(define example-track2
  (create-track
   "money is not our god"
   "killing joke"
   "extremeties dirt and various repressed emotions"
   666
   22
   example-date
   3
   example-date))


(define example-track3
  (create-track
   "eighties"
   "killing joke"
   "laugh? I nearly bought one"
   666
   22
   example-date
   3
   example-date))

(define example-Ltrack (list example-track))

; ex 200

; LTracks -> Number
; total play time
(check-expect (total-time (list example-track example-track)) (* 2 666))
(define (total-time ts)
  (cond
    [(empty? ts) 0]
    [(cons? ts) (+ (track-time (first ts)) (total-time (rest ts)))]))

; ex 201

; LTracks -> list of strings
; list of album titles
(check-expect (select-all-album-titles (list example-track example-track))
              (list "extremeties dirt and various repressed emotions" "extremeties dirt and various repressed emotions"))
(define (select-all-album-titles ts)
  (cond
    [(empty? ts) '()]
    [(cons? ts) (cons (track-album (first ts)) (select-all-album-titles (rest ts)))]))

; list of strings -> list of strings
; every string from input list, exactly once
(check-expect (create-set (list "a" "b" "c" "a")) (list "b" "c" "a"))
(define (create-set xs)
  (cond
    [(empty? xs) '()]
    [(cons? xs) (if (member? (first xs) (rest xs))
                    (create-set (rest xs))
                    (cons (first xs) (create-set (rest xs))))]))

; LTracks -> list of strings
; list of unique album titles
(check-expect (select-album-titles/unique (list example-track example-track))
              (list "extremeties dirt and various repressed emotions"))
(define (select-album-titles/unique xs)
  (create-set (select-all-album-titles xs)))

; ex 202
; string LTracks -> LTracks
; given album, return tracks belonging to that album
(check-expect (select-album "extremeties dirt and various repressed emotions" (list example-track example-track2 example-track3))
              (list example-track example-track2))
(define (select-album a ts)
  (cond
    [(empty? ts) '()]
    [(cons? ts)
     (if (string=? a (track-album (first ts)))
         (cons (first ts) (select-album a (rest ts)))
         (select-album a (rest ts)))]))