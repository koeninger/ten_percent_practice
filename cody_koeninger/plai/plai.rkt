#lang plai-typed


(define-type ExprC
  [numC (n : number)]
  [plusC (l : ExprC) (r : ExprC)]
  [multC (l : ExprC) (r : ExprC)]
  [idC (s : symbol)]
  [appC (fun : symbol) (arg : ExprC)]
  [ifC (b : ExprC) (t : ExprC) (f : ExprC)])

(define-type ExprS
  [numS (n : number)]
  [plusS (l : ExprS) (r : ExprS)]
  [bminusS (l : ExprS) (r : ExprS)]
  [uminusS (e : ExprS)]
  [multS (l : ExprS) (r : ExprS)]
  [ifS (b : ExprS) (t : ExprS) (f : ExprS)])

(define-type FunDefC
  [fdC (name : symbol) (arg : symbol) (body : ExprC)])

(define (parse [s : s-expression]) : ExprC
  (cond
    [(s-exp-number? s) (numC (s-exp->number s))]
    [(s-exp-list? s)
     (let ([sl (s-exp->list s)])
       (case (s-exp->symbol (first sl))
         [(+) (plusC (parse (second sl)) (parse (third sl)))]
         [(*) (multC (parse (second sl)) (parse (third sl)))]
         [(if) (ifC (parse (second sl)) (parse (third sl)) (parse (fourth sl)))]
         [else (error 'parse "invalid list input")]))]
    [else (error 'parse "invalid input")]))

(define (subst [what : number] [for : symbol] [in : ExprC]) : ExprC
  (subst_ (numC what) for in))

(define (subst_ [what : ExprC] [for : symbol] [in : ExprC]) : ExprC
  (type-case ExprC in
    [numC (_) in]
    [idC (s) (cond
               [(symbol=? s for) what]
               [else in])]
    [appC (fun arg) (appC fun (subst_ what for arg))]
    [plusC (l r) (plusC (subst_ what for l) (subst_ what for r))]
    [multC (l r) (multC (subst_ what for l) (subst_ what for r))]
    [ifC (b t f) (ifC (subst_ what for b) (subst_ what for t) (subst_ what for f))]))

(define (get-fundef [n : symbol] [fds : (listof FunDefC)]) : FunDefC
  (cond
    [(empty? fds) (error 'get-fundef "reference to undefined function")]
    [(cons? fds) (cond
                   [(equal? n (fdC-name (first fds))) (first fds)]
                   [else (get-fundef n (rest fds))])]))

(define (interp [e : ExprC] [fds : (listof FunDefC)]) : number
  (type-case ExprC e
    [numC (n) n]
    [plusC (l r) (+ (interp l fds) (interp r fds))]
    [multC (l r) (* (interp l fds) (interp r fds))]
    [appC (f a) (local ([define fd (get-fundef f fds)])
                  (interp (subst (interp a fds) (fdC-arg fd) (fdC-body fd)) fds))]
    [idC (_) (error 'interp "unbound identifier")]
    [ifC (b t f) (if (eq? (interp b fds) 0) (interp f fds) (interp t fds))]))

(define (desugar [as : ExprS]) : ExprC
  (type-case ExprS as
    [numS (n) (numC n)]
    [plusS (l r) (plusC (desugar l) (desugar r))]
    [bminusS (l r) (plusC (desugar l) (multC (numC -1) (desugar r)))]
    [uminusS (e) (multC (numC -1) (desugar e))]
    [multS (l r) (multC (desugar l) (desugar r))]
    [ifS (b t f) (ifC (desugar b) (desugar t) (desugar f))]))