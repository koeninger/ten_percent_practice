#lang br/quicklang
(require brag/support racket/sequence)

(module+ reader
  (provide read-syntax))

(define lex-bit
  (lexer
   ["#$" empty]
   ["%" 'taco]
   [any-char (lex-bit input-port)]))

(define (tokenize ip)
  (define ts
    (for/list ([tok (in-port lex-bit ip)])
      tok))
  (for/list ([g (in-slice 7 ts)])
    g))

(define (parse toks)
  (for/list ([tok (in-list toks)])
    (integer->char
     (for/sum ([val (in-list tok)]
               [power (in-naturals)]
               #:when (eq? val 'taco))
       (expt 2 power)))))

(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (strip-context
   (with-syntax ([PT parse-tree])
     #'(module untaco racket
         (display (list->string 'PT))))))