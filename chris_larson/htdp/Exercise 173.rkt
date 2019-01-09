;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 173|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define TTT (cons
 (cons "TTT" '())
 (cons
  '()
  (cons
   '()
   (cons
    '()
    (cons
     (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
     (cons
      '()
      (cons
       (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
       (cons
        '()
        (cons
         (cons "the" (cons "cryptic" (cons "admonishment" '())))
         (cons
          '()
          (cons
           (cons "T.T.T." '())
           (cons
            '()
            (cons
             '()
             (cons
              '()
              (cons
               (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
               (cons '() (cons (cons "slowly" (cons "you" (cons "climb," '()))) (cons '() (cons (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '()))))) (cons '() (cons (cons "Things" (cons "Take" (cons "Time." '()))) (cons '() (cons '() (cons '() (cons (cons "Piet" (cons "Hein" '())) (cons '() '())))))))))))))))))))))))))))
(define TTT-NO-ARTICLES (cons
 (cons "TTT" '())
 (cons
  '()
  (cons
   '()
   (cons
    '()
    (cons
     (cons "Put" (cons "up" (cons "in" (cons "place" '()))))
     (cons
      '()
      (cons
       (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
       (cons
        '()
        (cons
         (cons "cryptic" (cons "admonishment" '()))
         (cons
          '()
          (cons
           (cons "T.T.T." '())
           (cons
            '()
            (cons
             '()
             (cons
              '()
              (cons
               (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
               (cons
                '()
                (cons
                 (cons "slowly" (cons "you" (cons "climb," '())))
                 (cons
                  '()
                  (cons
                   (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '())))))
                   (cons '() (cons (cons "Things" (cons "Take" (cons "Time." '()))) (cons '() (cons '() (cons '() (cons (cons "Piet" (cons "Hein" '())) (cons '() '())))))))))))))))))))))))))))

; String -> File
; opens filename, removes articles, saves file
(define (file-remove-articles n)
  (write-file (string-append "no-articles-" n) (collapse (remove-articles (read-words/line n)))))

; List-of-strings -> String
; removes articles from los
(define (line-remove-articles los)
  (cond
    [(empty? los) '()]
    [else (if (article? (first los)) (line-remove-articles (rest los)) (cons (first los) (line-remove-articles (rest los))))]))
(check-expect (line-remove-articles (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))) (cons "Put" (cons "up" (cons "in" (cons "place" '())))))

; String -> Boolean
; checks is string is an article
(define (article? s)
  (cond
    [(or (string=? s "a") (string=? s "an") (string=? s "the")) #true]
    [else #false]))
(check-expect (article? "a") #true)
(check-expect (article? "add") #false)

; List-list-of-string
; remove articles from each line
(define (remove-articles llos)
  (cond
    [(empty? llos) '()]
    [else (cons (line-remove-articles (first llos)) (remove-articles (rest llos)))]))
(check-expect (remove-articles TTT) TTT-NO-ARTICLES)

; List-of-lines -> string
; concats a list of list-of-strings into a single string
(define (collapse lol)
  (cond
    [(empty? lol) ""]
    [else (string-append (collapse-line (first lol)) (if (empty? (rest lol)) "" "\n") (collapse (rest lol)))]))
(check-expect (collapse (read-words/line "ttt.txt")) "TTT\n\n\n\nPut up in a place\n\nwhere it's easy to see\n\nthe cryptic admonishment\n\nT.T.T.\n\n\n\nWhen you feel how depressingly\n\nslowly you climb,\n\nit's well to remember that\n\nThings Take Time.\n\n\n\nPiet Hein\n\n")

; List-of-strings -> string
; combines los to a single string separated by " "
(define (collapse-line los)
  (cond
    [(empty? los) ""]
    [else (string-append (first los) (if (empty? (rest los)) "" " ") (collapse-line (rest los)))]))
(check-expect (collapse-line (cons "the" (cons "cryptic" (cons "admonishment" '())))) "the cryptic admonishment")
