#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define-struct editor [string index])

(define MAX-WIDTH 200)
(define MAX-HEIGHT 20)
(define FONT-SIZE 11)

(define (text-box ed)
  (beside (text (substring (editor-string ed) 0 (editor-index ed)) FONT-SIZE "black")
          (rectangle 1 MAX-HEIGHT "solid" "red")
          (text (substring (editor-string ed) (editor-index ed)) FONT-SIZE "black")))

(define (render ed)
  (overlay/align "left" "center"
                 (text-box ed)
                 (empty-scene MAX-WIDTH MAX-HEIGHT)))

(check-expect (string-delete "" -1) "")
(check-expect (string-delete "str" 0) "tr")
(check-expect (string-delete "str" 1) "sr")
(check-expect (string-delete "str" 2) "st")

(define (string-delete str i)
  (cond
    [(>= i 0) (string-append (substring str 0 i) (substring str (add1 i)))]
    [else str]))

(check-expect (string-insert "" 0 "s") "s")
(check-expect (string-insert "str" 0 "_") "_str")
(check-expect (string-insert "str" 1 "_") "s_tr")
(check-expect (string-insert "str" 2 "_") "st_r")
(check-expect (string-insert "str" 3 "_") "str_")

(define (string-insert str i c)
  (string-append (substring str 0 i)
                 c
                 (substring str i)))

(define (limit old-ed new-ed)
  (cond
    [(<= (image-width (text-box new-ed)) MAX-WIDTH) new-ed]
    [else old-ed]))

(check-expect (render (edit (make-editor "helloworld" 0) "\b")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 1) "\b")) (render (make-editor "elloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 5) "\b")) (render (make-editor "hellworld" 4)))
(check-expect (render (edit (make-editor "helloworld" 9) "\b")) (render (make-editor "helloword" 8)))
(check-expect (render (edit (make-editor "helloworld" 10) "\b")) (render (make-editor "helloworl" 9)))
(check-expect (render (edit (make-editor "" 0) "\b")) (render (make-editor "" 0)))

(check-expect (render (edit (make-editor "helloworld" 0) "\t")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 0) "\r")) (render (make-editor "helloworld" 0)))

(check-expect (render (edit (make-editor "helloworld" 0) "_")) (render (make-editor "_helloworld" 1)))
(check-expect (render (edit (make-editor "helloworld" 1) "_")) (render (make-editor "h_elloworld" 2)))
(check-expect (render (edit (make-editor "helloworld" 5) "_")) (render (make-editor "hello_world" 6)))
(check-expect (render (edit (make-editor "helloworld" 9) "_")) (render (make-editor "helloworl_d" 10)))
(check-expect (render (edit (make-editor "helloworld" 10) "_")) (render (make-editor "helloworld_" 11)))
(check-expect (render (edit (make-editor "" 0) "_")) (render (make-editor "_" 1)))

(check-expect (render (edit (make-editor "helloworld" 0) "left")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 1) "left")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 5) "left")) (render (make-editor "helloworld" 4)))
(check-expect (render (edit (make-editor "helloworld" 9) "left")) (render (make-editor "helloworld" 8)))
(check-expect (render (edit (make-editor "helloworld" 10) "left")) (render (make-editor "helloworld" 9)))
(check-expect (render (edit (make-editor "" 0) "left")) (render (make-editor "" 0)))

(check-expect (render (edit (make-editor "helloworld" 0) "right")) (render (make-editor "helloworld" 1)))
(check-expect (render (edit (make-editor "helloworld" 1) "right")) (render (make-editor "helloworld" 2)))
(check-expect (render (edit (make-editor "helloworld" 5) "right")) (render (make-editor "helloworld" 6)))
(check-expect (render (edit (make-editor "helloworld" 9) "right")) (render (make-editor "helloworld" 10)))
(check-expect (render (edit (make-editor "helloworld" 10) "right")) (render (make-editor "helloworld" 10)))
(check-expect (render (edit (make-editor "" 0) "right")) (render (make-editor "" 0)))

(check-expect (render (edit (make-editor "helloworld" 0) "hello_world")) (render (make-editor "helloworld" 0)))

(define (edit ed ke)
  (cond
    [(cond
       [(= (string-length ke) 1) (cond
                                   [(string=? ke "\b") (make-editor (string-delete (editor-string ed) (sub1 (editor-index ed)))
                                                                    (max (sub1 (editor-index ed)) 0))]
                                   [(string=? ke "\t") ed]
                                   [(string=? ke "\r") ed]
                                   [else (limit ed (make-editor (string-insert (editor-string ed)
                                                                               (editor-index ed)
                                                                               ke)
                                                                (add1 (editor-index ed))))])]
       [(> (string-length ke) 1) (cond
                                   [(string=? ke "left") (make-editor (editor-string ed)
                                                                      (max (sub1 (editor-index ed)) 0))]
                                   [(string=? ke "right") (make-editor (editor-string ed)
                                                                       (min (add1 (editor-index ed)) (string-length (editor-string ed))))]
                                   [else ed])])]
    [else ed]))

(define (run state)
  (big-bang state
    [to-draw render]
    [on-key edit]))

(test)
(run (make-editor "" 0))