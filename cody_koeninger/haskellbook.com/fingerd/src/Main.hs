{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}

module Main where

import Control.Exception
import Control.Monad (forever)
import Data.List (intersperse)
import Data.Text (Text)
import qualified Data.Text as T
import Data.Text.Encoding (decodeUtf8, encodeUtf8)
import Data.Typeable
import Database.SQLite.Simple hiding (close)
import qualified Database.SQLite.Simple as SQLite
import Database.SQLite.Simple.Types
import Network.Socket hiding (close, recv)
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import Network.Socket.ByteString (recv, sendAll)
import Text.RawString.QQ
import User

data DuplicateData = DuplicateData deriving (Eq, Show, Typeable)

instance Exception DuplicateData

getUser :: Connection
        -> Text
        -> IO (Maybe User)
getUser conn username = do
  results <- query conn getUserQuery (Only username)
  case results of
    [] -> return $ Nothing
    [user] -> return $ Just user
    _ -> throwIO DuplicateData

createDatabase :: IO ()
createDatabase = do
  conn <- open "finger.db"
  execute_ conn createUsers
  execute conn insertUser meRow
  rows <- query_ conn allUsers
  mapM_ print (rows :: [User])
  SQLite.close conn
  where meRow :: UserRow
        meRow = (Null, "cody", "/bin/bash", "/Users/cody", "cody k", "555-123-4567")

returnUsers :: Connection
            -> Socket
            -> IO ()
returnUsers dbConn soc = do
  rows <- query_ dbConn allUsers
  let usernames = map username rows
      newlineSeparated = T.concat $ intersperse "\n" usernames
  sendAll soc (encodeUtf8 newlineSeparated)

formatUser :: User -> ByteString
formatUser (User _ username shell homeDir realName _) = BS.concat
  ["Login: ", e username, "\t\t\t\t",
   "Name: ", e realName, "\n",
   "Dir: ", e homeDir, "\t\t\t",
   "Shell: ", e shell, "\n"]
  where e = encodeUtf8

returnUser :: Connection
           -> Socket
           -> Text
           -> IO ()
returnUser dbConn soc username = do
  maybeUser <- getUser dbConn (T.strip username)
  case maybeUser of
    Nothing -> do
      putStrLn ("Couldn't find " ++ (show username))
      return ()
    Just user ->
      sendAll soc (formatUser user)

handleQuery :: Connection
            -> Socket
            -> IO ()
handleQuery dbConn soc = do
  msg <- recv soc 1024
  case msg of
    "\r\n" -> returnUsers dbConn soc
    name ->
      returnUser dbConn soc (decodeUtf8 name)

handleQueries :: Connection
              -> Socket
              -> IO ()
handleQueries dbConn sock = forever $ do
  (soc, _) <- accept sock
  putStrLn "Got connection, handling query"
  handleQuery dbConn soc
  sClose soc

main :: IO ()
main = withSocketsDo $ do
  addrinfos <-
    getAddrInfo
    (Just (defaultHints
          {addrFlags = [AI_PASSIVE]}))
    Nothing
    (Just "79")
  let serveraddr = head addrinfos
  sock <- socket (addrFamily serveraddr)
          Stream defaultProtocol
  bindSocket sock (addrAddress serveraddr)
  listen sock 1
  conn <- open "finger.db"
  handleQueries conn sock
  SQLite.close conn
  sClose sock
