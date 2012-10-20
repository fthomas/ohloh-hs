-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}

module Main where

import Data.Maybe
import System.Console.CmdArgs
import Text.Show.Pretty
import Text.XML.HXT.Core
import Text.XML.HXT.Curl

import Web.Ohloh

data CmdOh = Read {file :: Maybe FilePath}
           | Fetch {key :: String, queryItem :: String, queryArgs :: [String]}
             deriving (Show, Data, Typeable)

cmdRead = Read {
  file = def &= typ "FILE" &= help "Read data from FILE"
}

cmdFetch = Fetch {
  key = def &= typ "KEY" &= help "Ohloh API key",
  queryItem = def &= argPos 0,
  queryArgs = def &= args &= typ "ITEM_ARGS"
}

main :: IO ()
main = do
  args <- cmdArgs $ modes [cmdRead, cmdFetch]
  handleArgs args

handleArgs Read{..} = do
  res <- runX $ xunpickleDocument xpResponse [ withRemoveWS yes ] $ fromMaybe "" file
  putStrLn $ ppShow $ head res

handleArgs Fetch{..} = do
  let maybeUrl = queryUrl queryItem queryArgs `withApiKey` key
  case maybeUrl of
    Nothing  -> putStrLn $ "Unknown query item: " ++ queryItem
    Just url -> do
      res <- runX $ xunpickleDocument xpResponse [ withRemoveWS yes, withCurl [] ] url
      putStrLn $ ppShow $ head res
