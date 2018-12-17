#lang racket

(require 2htdp/image)
(require test-engine/racket-tests)

(define-struct editor [pre post])

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) 11 "black")
                         (rectangle 1 20 "solid" "red")
                         (text (editor-post ed) 11 "black"))
                 (empty-scene 200 20)))

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

(check-expect (render (edit (make-editor "" "helloworld") "_")) (render (make-editor "_" "helloworld")))
(check-expect (render (edit (make-editor "h" "elloworld") "_")) (render (make-editor "h_" "elloworld")))
(check-expect (render (edit (make-editor "hello" "world") "_")) (render (make-editor "hello_" "world")))
(check-expect (render (edit (make-editor "helloworl" "d") "_")) (render (make-editor "helloworl_" "d")))
(check-expect (render (edit (make-editor "helloworld" "") "_")) (render (make-editor "helloworld_" "")))
(check-expect (render (edit (make-editor "" "") "_")) (render (make-editor "_" "")))

(check-expect (render (edit (make-editor "" "helloworld") "\b")) (render (make-editor "" "helloworld")))
(check-expect (render (edit (make-editor "h" "elloworld") "\b")) (render (make-editor "" "elloworld")))
(check-expect (render (edit (make-editor "hello" "world") "\b")) (render (make-editor "hell" "world")))
(check-expect (render (edit (make-editor "helloworl" "d") "\b")) (render (make-editor "hellowor" "d")))
(check-expect (render (edit (make-editor "helloworld" "") "\b")) (render (make-editor "helloworl" "")))
(check-expect (render (edit (make-editor "" "") "\b")) (render (make-editor "" "")))

(check-expect (render (edit (make-editor "" "helloworld") "left")) (render (make-editor "" "helloworld")))
(check-expect (render (edit (make-editor "h" "elloworld") "left")) (render (make-editor "" "helloworld")))
(check-expect (render (edit (make-editor "hello" "world") "left")) (render (make-editor "hell" "oworld")))
(check-expect (render (edit (make-editor "helloworl" "d") "left")) (render (make-editor "hellowor" "ld")))
(check-expect (render (edit (make-editor "helloworld" "") "left")) (render (make-editor "helloworl" "d")))
(check-expect (render (edit (make-editor "" "") "left")) (render (make-editor "" "")))

(check-expect (render (edit (make-editor "" "helloworld") "right")) (render (make-editor "h" "elloworld")))
(check-expect (render (edit (make-editor "h" "elloworld") "right")) (render (make-editor "he" "lloworld")))
(check-expect (render (edit (make-editor "hello" "world") "right")) (render (make-editor "hellow" "orld")))
(check-expect (render (edit (make-editor "helloworl" "d") "right")) (render (make-editor "helloworld" "")))
(check-expect (render (edit (make-editor "helloworld" "") "right")) (render (make-editor "helloworld" "")))
(check-expect (render (edit (make-editor "" "") "right")) (render (make-editor "" "")))

(check-expect (render (edit (make-editor "hello" "world") "\t")) (render (make-editor "hello" "world")))
(check-expect (render (edit (make-editor "hello" "world") "\r")) (render (make-editor "hello" "world")))
(check-expect (render (edit (make-editor "hello" "world") "hello_world")) (render (make-editor "hello" "world")))

(define (edit ed ke)
  (cond
    [(cond
      [(= (string-length ke) 1) (cond
                                   [(string=? ke "\b") (make-editor (string-remove-last (editor-pre ed))
                                                                    (editor-post ed))]
                                   [(string=? ke "\t") ed]
                                   [(string=? ke "\r") ed]
                                   [else (make-editor (string-append (editor-pre ed)
                                                                     ke)
                                                      (editor-post ed))])]
      [(> (string-length ke) 1) (cond
                                   [(string=? ke "left") (make-editor (string-remove-last (editor-pre ed))
                                                                      (string-append (string-last (editor-pre ed))
                                                                                     (editor-post ed)))]
                                   [(string=? ke "right") (make-editor (string-append (editor-pre ed)
                                                                                      (string-first (editor-post ed)))
                                                                       (string-remove-first (editor-post ed)))]
                                   [else ed])])]
    [else (make-editor (editor-pre ed) (editor-post ed))]))

(test)