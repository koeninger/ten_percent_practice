;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 189|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))
(check-expect (search 1 (list 1 2 3 4 5 6 7 8 9 0)) #true)
(check-expect (search 0 (list 1 2 3 4 5 6 7 8 9 0)) #true)
(check-expect (search 5 (list 1 2 3 4 5 6 7 8 9 0)) #true)
(check-expect (search 11 (list 1 2 3 4 5 6 7 8 9 0)) #false)


; Number List-of-numbers -> Boolean
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
          (if (< n (first alon)) (search-sorted n (rest alon)) #false))]))

(check-expect (search-sorted 1 (list 9 8 7 6 5 4 3 2 1 0)) #true)
(check-expect (search-sorted 0 (list 9 8 7 6 5 4 3 2 1 0)) #true)
(check-expect (search-sorted 5 (list 9 8 7 6 5 4 3 2 1 0)) #true)
(check-expect (search-sorted 11 (list 9 8 7 6 5 4 3 2 1 0)) #false)

; List-of-1String -> List-of-suffixes
; A list s is a suffix of l if p and l are the same from the end, up through all items in s
(define (suffixes los)
  (cond
    [(empty? los) '()]
    [else (cons los (suffixes (rest los)))]))
(check-expect (suffixes (list "a" "b" "c" "d" "e" "f" "g"))
              (list
               (list "a" "b" "c" "d" "e" "f" "g")
               (list "b" "c" "d" "e" "f" "g")
               (list "c" "d" "e" "f" "g")
               (list "d" "e" "f" "g")
               (list "e" "f" "g")
               (list "f" "g")
               (list "g")))

; List-of-1String -> List-of-prefixes
; A list p is a prefix of l if p and l are the same up through all items in p
(define (prefixes los)
  (subset (reverse los)))

(define (subset los)
  (cond
    [(empty? los) '()]
    [else (cons (reverse los) (subset (rest los)))]))
(check-expect (prefixes (list "a" "b" "c" "d" "e" "f" "g"))
              (list
               (list "a" "b" "c" "d" "e" "f" "g")
               (list "a" "b" "c" "d" "e" "f")
               (list "a" "b" "c" "d" "e")
               (list "a" "b" "c" "d")
               (list "a" "b" "c")
               (list "a" "b")
               (list "a")))

               
               
               
               