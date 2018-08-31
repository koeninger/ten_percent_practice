#! /usr/local/bin/racket
#lang racket

(require 2htdp/batch-io)

(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(write-file
   'stdout
   (letter "Matthew" "Fisler" "Felleisen"))


 (define (main in-fst in-lst in-signature out)
   (write-file out
    (letter (read-file in-fst)
      (read-file in-lst)
      (read-file in-signature))))

(define relative-path (path-only (find-system-path 'run-file)))
(define (getFilePath filename)
  (path->string (build-path relative-path filename)))

(main
  (getFilePath "first-name.dat")
  (getFilePath "last-name.dat")
  (getFilePath "signature-name.dat")
  (getFilePath "letter.dat"))
