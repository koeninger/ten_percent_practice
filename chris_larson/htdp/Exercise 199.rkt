;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 199|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))

; the 2htdp/itunes library documentation, part 1: 

; (define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).
(define DATE-1 (create-date 2018 02 04 01 02 50))
(define DATE-2 (create-date 1999 10 08 11 02 05))

; (define-struct track
;   [name artist album time track# added play# played])
; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: the track's 
; title, its producing artist, to which album it belongs, 
; its playing time in milliseconds, its position within the 
; album, the date it was added, how often it has been 
; played, and the date when it was last played
(define TRACK-1 (create-track "name" "artist" "album" 10000 10 DATE-1 11 DATE-1))
(define TRACK-2 (create-track "Song Name" "Artist Name" "Album Name" 90000 10 DATE-2 11 DATE-2))

; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))
(define ARTWORK-1 (cons "Artwork Count" (cons 1 '())))
(define NAME-1 (cons "Name" (cons "Name" '())))
(define ALBUM-1 (cons "Album" (cons "Album" '())))

(define ARTWORK-2 (cons "Artwork Count" (cons 2 '())))
(define NAME-2 (cons "Name" (cons "Name 2" '())))
(define ALBUM-2 (cons "Album" (cons "Album 2" '())))

; A BSDN is one of: 
; – Boolean
; – Number
; – String
; – Date
(define LASSOC-1 (list ARTWORK-1 NAME-1 ALBUM-1))
(define LASSOC-2 (list ARTWORK-2 NAME-2 ALBUM-2))

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
(list LASSOC-1 LASSOC-2)

; An LTracks is one of:
; – '()
; – (cons Track LTracks)
(define LTRACKS-1 (list TRACK-1 TRACK-2))
(define LTRACKS-2 (list TRACK-1 TRACK-1 TRACK-2))

; modify the following to use your chosen name
(define ITUNES-LOCATION "/Users/chris/itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))
; LLists
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))

; LTracks -> Number
; adds up play times
(define (total-time t)
  (cond
    [(empty? t) 0]
    [else (+ (track-time (first t)) (total-time (rest t)))]))
(check-expect (total-time LTRACKS-1) 100000)

; LTracks -> List-of-Strings
; list album names
(define (select-all-album-titles t)
  (cond
    [(empty? t) '()]
    [else (cons (track-album (first t)) (select-all-album-titles (rest t)))]))
(check-expect (select-all-album-titles LTRACKS-1) (list "album" "Album Name"))

; List-of-Strings -> List-of-Strings
; removes duplicate strings
(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (if (occurs? (first los) (rest los)) (create-set (rest los)) (cons (first los) (create-set (rest los))))]))
(check-expect (create-set (list "thing1" "thing2" "thing3")) (list "thing1" "thing2" "thing3"))
(check-expect (create-set (list "thing1" "thing1" "thing2" "thing3")) (list "thing1" "thing2" "thing3"))
(check-expect (create-set (list "thing1" "thing2" "thing3" "thing1")) (list "thing2" "thing3" "thing1"))

; String List-of-Strings -> Bool
(define (occurs? s los)
  (cond
    [(empty? los) #false]
    [else (if (string=? s (first los)) #true (occurs? s (rest los)))]))
(check-expect (occurs? "thing1" (list "thing1" "thing2" "thing3")) #true)
(check-expect (occurs? "thing2" (list "thing1" "thing2" "thing3")) #true)
(check-expect (occurs? "thing3" (list "thing1" "thing2" "thing3")) #true)
(check-expect (occurs? "thing4" (list "thing1" "thing2" "thing3")) #false)

; LTracks -> List-of-Strings
; creates list of unique album names
(define (select-album-titles/unique t)
        (create-set (select-all-album-titles t)))
(check-expect (select-album-titles/unique LTRACKS-1) (list "album" "Album Name"))
(check-expect (select-album-titles/unique LTRACKS-2) (list "album" "Album Name"))

; String LTracks -> LTracks
; returns tracks with matching title
(define (select-album s t)
  (cond
    [(empty? t) '()]
    [else (if (string=? s (track-album (first t))) (cons (first t) (select-album s (rest t))) (select-album s (rest t)))]))
(check-expect (select-album "album" LTRACKS-1) (list TRACK-1))
(check-expect (select-album "album" LTRACKS-2) (list TRACK-1 TRACK-1))
(check-expect (select-album "not here" LTRACKS-1) '())

; String Date LTracks -> LTracks
; returns all albums played after date
(define (select-album-date s d t)
  (select-tracks-date d (select-album s t)))

; Date LTracks -> LTracks
; returns tracks plated after date
(define (select-tracks-date d t)
  (cond
    [(empty? t) '()]
    [else (if (date-after d (track-played (first t))) (cons (first t) (select-tracks-date d (rest t))) (select-tracks-date d (rest t)))]))
(check-expect (select-tracks-date (create-date 1998 09 08 11 02 04) LTRACKS-1) LTRACKS-1)
(check-expect (select-tracks-date (create-date 2000 09 08 11 02 04) LTRACKS-1) (list TRACK-1))
(check-expect (select-tracks-date (create-date 2018 02 04 01 02 50) LTRACKS-1) '())

; Date Date -> Bool
; true if first date is older than second date
; year month day hour minute second
(define (date-after d1 d2)
  (cond
    [(< (date-year d1) (date-year d2)) #true]
    [(> (date-year d1) (date-year d2)) #false]
    [(< (date-month d1) (date-month d2)) #true]
    [(> (date-month d1) (date-month d2)) #false]
    [(< (date-day d1) (date-day d2)) #true]
    [(> (date-day d1) (date-day d2)) #false]
    [(< (date-hour d1) (date-hour d2)) #true]
    [(> (date-hour d1) (date-hour d2)) #false]
    [(< (date-minute d1) (date-minute d2)) #true]
    [(> (date-minute d1) (date-minute d2)) #false]
    [(< (date-second d1) (date-second d2)) #true]
    [(> (date-second d1) (date-second d2)) #false]
    [else #false]))
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 02 04 01 02 50)) #false)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2017 02 04 01 02 50)) #false)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 01 04 01 02 50)) #false)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 02 03 01 02 50)) #false)
(check-expect (date-after (create-date 2018 02 04 02 02 50) (create-date 2018 02 04 01 02 50)) #false)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 02 04 01 01 50)) #false)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 02 04 01 02 40)) #false)

(check-expect (date-after (create-date 2017 02 04 01 02 50) (create-date 2018 02 04 01 02 50)) #true)
(check-expect (date-after (create-date 2018 01 04 01 02 50) (create-date 2018 02 04 01 02 50)) #true)
(check-expect (date-after (create-date 2018 02 03 01 02 50) (create-date 2018 02 04 01 02 50)) #true)
(check-expect (date-after (create-date 2018 02 04 01 02 50) (create-date 2018 02 04 02 02 50)) #true)
(check-expect (date-after (create-date 2018 02 04 01 01 50) (create-date 2018 02 04 01 02 50)) #true)
(check-expect (date-after (create-date 2018 02 04 01 02 40) (create-date 2018 02 04 01 02 50)) #true)

; LTracks -> List-of-LTracks
; lists tracks under album
(define (select-albums t)
  (select-albums-list (select-album-titles/unique t) t))
(check-expect (select-albums LTRACKS-1) (list (list TRACK-1) (list TRACK-2)))

; LTracks List-of-albums -> LTracks
; lists tracks under album list
(define (select-albums-list s t)
  (cond
    [(empty? s) '()]
    [else (cons (select-album (first s) t) (select-albums-list (rest s) t))]))
(check-expect (select-albums-list (list "album" "Album Name") LTRACKS-1) (list (list TRACK-1) (list TRACK-2)))

; String, LAssoc, Any -> Assoc
; returns first association whose first item equals s
(define (find-association s loa a)
  (cond
    [(empty? loa) '()]
    [else (if (string=? s (first (first loa))) (first loa) (find-association s (rest loa) a))]))


(check-expect (find-association "Album" LASSOC-1 "") ALBUM-1)
(check-expect (find-association "Album" LASSOC-2 "") ALBUM-2)
(check-expect (find-association "Not Here" LASSOC-2 "") '())