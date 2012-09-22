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

import Ohloh.Response

data CmdOh = Read {file :: Maybe FilePath}
           | Fetch
             deriving (Show, Data, Typeable)

cmdRead = Read {file = def}
cmdFetch = Fetch

main :: IO ()
main = do
  args <- cmdArgs $ modes [cmdRead, cmdFetch]
  handleArgs args

handleArgs Read{..} = do
  doc <- runX $ readDocument [ withRemoveWS yes ] $ fromMaybe "" file
  putStrLn $ ppShow $ unpickleDoc xpResponse $ head doc

handleArgs args@Fetch{..} = do
  print args
