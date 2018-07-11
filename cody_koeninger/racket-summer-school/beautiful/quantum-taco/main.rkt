#lang br/quicklang

(require syntax/parse)
(module+ reader
  (provide read-syntax))

(define (tokenize ip)
  (let ((x (read ip)))
    ;(displayln x)
    (if (eof-object? x) empty (cons x (tokenize ip)))))

(define (parse toks)
  (cond
    [(list? toks)
     (map parse toks)]
    [(pair? toks)
     (cons (parse (car toks)) (parse (cdr toks)))]
    [else
     'taco]))

#;
  (define (parse toks)
    (map token-to-taco toks))
#;
(define (token-to-taco tok)
  (syntax-parse tok
    [(arg ...)
     (define args (syntax->list #'(arg ...)))
     #`#,(map token-to-taco args)]
    [_ 'taco]))

 
(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (with-syntax ([(PT ...) parse-tree])
    #'(module tacofied racket
        'PT ...)))