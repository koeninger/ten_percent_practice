{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}

module Main where

import Control.Exception
import Data.Typeable
import qualified Data.Text as T
import qualified System.Environment as SE
import Database.SQLite.Simple hiding (close)
import qualified Database.SQLite.Simple as SQLite
import Database.SQLite.Simple.Types
import User

data BadUserRow = BadUserRow deriving (Eq, Show, Typeable)
instance Exception BadUserRow

main :: IO ()
main = do
  conn <- open "finger.db"
  args <- SE.getArgs
  case args of
    ("insert" : un : sh : hd : rn : ph : []) ->
      execute conn insertUser (Null, T.pack un, T.pack sh, T.pack hd, T.pack rn, T.pack ph)
    ("update" : un : sh : hd : rn : ph : []) ->
      execute conn updateUser (T.pack sh, T.pack hd, T.pack rn, T.pack ph, T.pack un)
    _ -> throwIO BadUserRow
  SQLite.close conn
