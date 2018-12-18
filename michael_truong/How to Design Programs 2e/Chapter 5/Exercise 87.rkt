#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define-struct editor [string index])

(define max-width 200)
(define max-height 20)
(define font-size 11)

(define (text-box ed)
  (beside (text (editor-pre ed) font-size "black")
          (rectangle 1 max-height "solid" "red")
          (text (editor-post ed) font-size "black")))

(define (render ed)
  (overlay/align "left" "center"
                 (text-box ed)
                 (empty-scene max-width max-height)))

(define (string-first str)
  (cond
    [(> (string-length str) 0) (substring str 0 1)]
    [else str]))

(define (string-last str)
  (cond
    [(> (string-length str) 0) (substring str (- (string-length str) 1))]
    [else str]))

(define (string-remove-first str)
  (cond
    [(> (string-length str) 0) (substring str 1)]
    [else str]))

(define (string-remove-last str)
  (cond
    [(> (string-length str) 0) (substring str 0 (- (string-length str) 1))]
    [else str]))

(define (limit old-ed new-ed)
  (cond
    [(<= (image-width (text-box new-ed)) max-width) new-ed]
    [else old-ed]))

(check-expect (render (edit (make-editor "helloworld" 0) "_")) (render (make-editor "_helloworld" 1)))
(check-expect (render (edit (make-editor "helloworld" 1) "_")) (render (make-editor "h_elloworld" 2)))
(check-expect (render (edit (make-editor "helloworld" 5) "_")) (render (make-editor "hello_world" 6)))
(check-expect (render (edit (make-editor "helloworld" 9) "_")) (render (make-editor "helloworl_d" 10)))
(check-expect (render (edit (make-editor "helloworld" 10) "_")) (render (make-editor "helloworld_" 11)))
(check-expect (render (edit (make-editor "" 0) "_")) (render (make-editor "_" 1)))

(check-expect (render (edit (make-editor "helloworld" 0) "\b")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 1) "\b")) (render (make-editor "elloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 5) "\b")) (render (make-editor "hellworld" 4)))
(check-expect (render (edit (make-editor "helloworld" 9) "\b")) (render (make-editor "helloword" 8)))
(check-expect (render (edit (make-editor "helloworld" 10) "\b")) (render (make-editor "helloworl" 9)))
(check-expect (render (edit (make-editor "" 0) "\b")) (render (make-editor "" 0)))

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

(check-expect (render (edit (make-editor "helloworld" 0) "\t")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 0) "\r")) (render (make-editor "helloworld" 0)))
(check-expect (render (edit (make-editor "helloworld" 0) "hello_world")) (make-editor "helloworld" 0)))

(define (edit ed ke)
  (cond
    [(cond
      [(= (string-length ke) 1) (cond
                                   [(string=? ke "\b") (make-editor (string-remove-last (editor-pre ed))
                                                                    (editor-post ed))]
                                   [(string=? ke "\t") ed]
                                   [(string=? ke "\r") ed]
                                   [else (limit ed (make-editor (string-append (editor-pre ed) ke) (editor-post ed)))])]
      [(> (string-length ke) 1) (cond
                                   [(string=? ke "left") (make-editor (string-remove-last (editor-pre ed))
                                                                      (string-append (string-last (editor-pre ed))
                                                                                     (editor-post ed)))]
                                   [(string=? ke "right") (make-editor (string-append (editor-pre ed)
                                                                                      (string-first (editor-post ed)))
                                                                       (string-remove-first (editor-post ed)))]
                                   [else ed])])]
    [else (make-editor (editor-pre ed) (editor-post ed))]))

(define (run initial-state)
  (big-bang initial-state
    [to-draw render]
    [on-key edit]))

(test)
(run (make-editor "" 0))