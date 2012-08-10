-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}

module Main where

import System.Console.CmdArgs

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
  contents <-
    case file of
      Just f  -> readFile f
      Nothing -> getContents
  putStrLn contents

handleArgs args@Fetch{..} = do
  print args
