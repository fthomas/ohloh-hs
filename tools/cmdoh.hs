-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE DeriveDataTypeable #-}

module Main (
  main
) where

import System.Console.CmdArgs

import Ohloh

data CmdOh = None
  deriving (Show, Data, Typeable)

main :: IO ()
main = print =<< cmdArgs (modes [None])
