-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | <http://meta.ohloh.net/referencestack/>
module Ohloh.Stack (
  Stack(..),
  xpStack
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Account
import Ohloh.Common
import Ohloh.StackEntry

data Stack = Stack {
  staId :: String,
  staUpdatedAt :: String,
  staProjectCount :: Int,
  staStackEntries :: [StackEntry],
  staAccountId :: String,
  staAccount :: Maybe Account
} deriving (Eq, Read, Show)

instance XmlPickler Stack where
  xpickle = xpStack

instance ResultType Stack
instance ReadXmlString Stack
instance ShowXmlString Stack

xpStack :: PU Stack
xpStack =
  xpElem "stack" $
    xpWrap (uncurry6 Stack,
            \(Stack i  ua  pc  se  ai  a) ->
                   (i, ua, pc, se, ai, a)) $
    xp6Tuple (xpElem "id" xpText0)
             (xpElem "updated_at" xpText0)
             (xpElem "project_count" xpInt)
             (xpElem "stack_entries" (xpList xpickle))
             (xpElem "account_id" xpText0)
             (xpOption xpAccount)
