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
    (un : sh : hd : rn : ph : []) ->
      execute conn insertUser meRow
      where meRow :: UserRow
            meRow = (Null, T.pack un, T.pack sh, T.pack hd, T.pack rn, T.pack ph)
    _ -> throwIO BadUserRow
  SQLite.close conn
