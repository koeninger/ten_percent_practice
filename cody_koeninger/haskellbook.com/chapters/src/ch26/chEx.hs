import Control.Monad.State
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Maybe
import Control.Monad
import Data.Functor.Identity


rDec :: Num a => Reader a a
rDec = ReaderT(Identity . ((-) 1))

rShow :: Show a
      => ReaderT a Identity String
rShow = ReaderT(Identity . show)

rPrintAndInc :: (Num a, Show a)
             => ReaderT a IO a
rPrintAndInc = ReaderT $ \r ->
  do
    putStrLn $ "Hi: " ++ show r
    return $ r + 1

sPrintIncAccum :: (Num a, Show a)
               => StateT a IO String
sPrintIncAccum = StateT $ \s ->
  do
    putStrLn $ "Hi: " ++ show s
    return (show s, s + 1)

isValid :: String -> Bool
isValid v = '!' `elem` v

maybeExcite :: MaybeT IO String
maybeExcite = MaybeT $ do
  v <- getLine
  guard $ isValid v
  return $ Just v

doExcite :: IO ()
doExcite = do
  putStrLn "say something excite!"
  excite <- runMaybeT maybeExcite
  case excite of
    Nothing -> putStrLn "Moar eexcite!"
    Just e ->
      putStrLn ("Good, very excite: " ++ e)
    
