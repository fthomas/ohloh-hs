-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE DeriveDataTypeable #-}

module Main where

import System.Console.CmdArgs

import Ohloh

data CmdOh = Read {file :: Maybe FilePath}
           | None
             deriving (Show, Data, Typeable)

readCmd = Read {file = def}

main :: IO ()
main = do
  x <- cmdArgs (modes [readCmd, None])
  print x
