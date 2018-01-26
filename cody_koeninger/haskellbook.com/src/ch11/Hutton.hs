module Hutton where

    import Text.Printf (printf)
    
    data Expr
        = Lit Integer
        | Add Expr Expr

    eval :: Expr -> Integer
    eval (Lit x) = x
    eval (Add a b) = (eval a) + (eval b)

    printExpr :: Expr -> String
    printExpr (Lit x) = show x
    printExpr (Add a b) = printf "%s + %s" (printExpr a) (printExpr b)
