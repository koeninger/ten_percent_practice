#lang plai-typed


(define-type ExprC
  [numC (n : number)]
  [plusC (l : ExprC) (r : ExprC)]
  [multC (l : ExprC) (r : ExprC)]
  [varC (s : symbol)]
  [appC (fun : ExprC) (arg : ExprC)]
  [lamC (arg : symbol) (body : ExprC)]
  [setC (var : symbol) (arg : ExprC)]
  [seqC (b1 : ExprC) (b2 : ExprC)]
  [objC (ns : (listof symbol)) (es : (listof ExprC))]
  [msgC (o : ExprC) (n : symbol)]
  [ifC (b : ExprC) (t : ExprC) (f : ExprC)])

(define-type ExprS
  [numS (n : number)]
  [plusS (l : ExprS) (r : ExprS)]
  [bminusS (l : ExprS) (r : ExprS)]
  [uminusS (e : ExprS)]
  [multS (l : ExprS) (r : ExprS)]
  [ifS (b : ExprS) (t : ExprS) (f : ExprS)])

(define-type Value
  [numV (n : number)]
  [closV (arg : symbol) (body : ExprC) (env : Env)]
  [objV (ns : (listof symbol)) (vs : (listof Value))])

(define-type-alias Location number)

(define-type Binding
  [bind (name : symbol) (val : Location)])

(define-type-alias Env (listof Binding))
(define mt-env empty)
(define (extend-env [x : 'x] [xs : (listof 'x)])
  (letrec
      ([ret (cons x xs)]
      ; [_ (display ret)]
      ; [__ (display "\n\n")]
       )
    ret))

(define-type Storage
  [cell (location : Location) (val : Value)])
(define-type-alias Store (listof Storage))
(define mt-store empty)
(define (override-store [c : Storage] [s : Store]) : Store
  (cond
    [(empty? s) (list c)]
    [(equal? (cell-location c) (cell-location (first s))) (cons c (rest s))]
    [else (cons (first s) (override-store c (rest s)))]))

(define-type Result
  [v*s (v : Value) (s : Store)])

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

(define (lookup [for : symbol] [env : Env]) : Location
  (cond
    [(empty? env) (error 'lookup "unbound identifier")]
    [(equal? for (bind-name (first env))) (bind-val (first env))]
    [else (lookup for (rest env))]))

(define (fetch [loc : Location] [sto : Store]) : Value
  (cond
    [(empty? sto) (error 'fetch "unbound location")]
    [(equal? loc (cell-location (first sto))) (cell-val (first sto))]
    [else (fetch loc (rest sto))]))

(define (num+ [l : Value] [r : Value]) : Value
  (cond
    [(and (numV? l) (numV? r))
     (numV (+ (numV-n l) (numV-n r)))]
    [else (error 'num+ "argument was not a number")]))

(define (num* [l : Value] [r : Value]) : Value
  (cond
    [(and (numV? l) (numV? r))
     (numV (* (numV-n l) (numV-n r)))]
    [else (error 'num* "argument was not a number")]))

(define new-loc
  (let ([n (box 0)])
    (lambda ()
      (begin
        (set-box! n (add1 (unbox n)))
        (unbox n)))))

(define (lookup-msg [s : symbol] [obj : Value]) : Value
  (type-case Value obj
    [objV (ns vs)
          (local [(define (go [ns : (listof symbol)] [vs : (listof Value)])
                    (cond
                      [(empty? ns) (error 'lookup-msg "not found")]
                      [(equal? s (first ns)) (first vs)]
                      [else (go (rest ns) (rest vs))]))]
            (go ns vs))]
    [else (error 'lookup-msg "expected objV")]))

(define (interp [e : ExprC] [env : Env] [sto : Store]) : Result
  (type-case ExprC e
    [numC (n) (v*s (numV n) sto)]
    [plusC (l r) (type-case Result (interp l env sto)
                   [v*s (v-l s-l)
                        (type-case Result (interp r env s-l)
                          [v*s (v-r s-r)
                               (v*s (num+ v-l v-r) s-r)])])]
    [multC (l r) (type-case Result (interp l env sto)
                   [v*s (v-l s-l)
                        (type-case Result (interp r env s-l)
                          [v*s (v-r s-r)
                               (v*s (num* v-l v-r) s-r)])])]
    [lamC (a b) (v*s (closV a b env) sto)]
    [appC (f a) (type-case Result (interp f env sto)
                  [v*s (v-f s-f)
                       (type-case Result (interp a env s-f)
                         [v*s (v-a s-a)
                              (let ([where (new-loc)])
                                (interp (closV-body v-f)
                                        (extend-env (bind (closV-arg v-f)
                                                          where)
                                                    (closV-env v-f))
                                        (override-store (cell where v-a) s-a)))])])]
    [varC (n) (v*s (fetch (lookup n env) sto) sto)]
    [setC (var val) (type-case Result (interp val env sto)
                      [v*s (v-val s-val)
                           (let ([where (lookup var env)])
                             (v*s v-val
                                  (override-store (cell where v-val)
                                                  s-val)))])]
    [seqC (b1 b2) (type-case Result (interp b1 env sto)
                    [v*s (v-b1 s-b1)
                         (interp b2 env s-b1)])]
    [objC (ns es) (v*s (objV ns (map (lambda (e)
                                  (v*s-v (interp e env sto))) ; this is wrong, should allow mutation of sto
                                es))
                       sto)]
    [msgC (o n) (v*s (lookup-msg n (v*s-v (interp o env sto))) sto)] ; likewise wrong, should allow mutation of sto
    [ifC (b t f) (type-case Result (interp b env sto)
                   [v*s (v-b s-b)
                        (if (equal? v-b (numV 0))
                            (interp f env s-b)
                            (interp t env s-b))])]))
    
(define (desugar [as : ExprS]) : ExprC
  (type-case ExprS as
    [numS (n) (numC n)]
    [plusS (l r) (plusC (desugar l) (desugar r))]
    [bminusS (l r) (plusC (desugar l) (multC (numC -1) (desugar r)))]
    [uminusS (e) (multC (numC -1) (desugar e))]
    [multS (l r) (multC (desugar l) (desugar r))]
    [ifS (b t f) (ifC (desugar b) (desugar t) (desugar f))]))