-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referencestack/>
module Web.Ohloh.Stack (
  Stack(..),
  xpStack
) where

import Data.Lens.Common
import Text.XML.HXT.Arrow.Pickle

import Web.Ohloh.Account
import Web.Ohloh.Common
import Web.Ohloh.Lens.IdL
import Web.Ohloh.Lens.UpdatedAtL
import Web.Ohloh.StackEntry

-- | 'Stack' represents a collection of 'Web.Ohloh.Project.Project's used by
--   a single person.
data Stack = Stack {
  staId :: String,
  staTitle :: String,
  staDescription :: String,
  staUpdatedAt :: String,
  staProjectCount :: Int,
  staStackEntries :: [StackEntry],
  staAccountId :: String,
  staAccount :: Maybe Account
} deriving (Eq, Read, Show)

instance XmlPickler Stack where
  xpickle = xpStack

instance ReadXmlString Stack
instance ShowXmlString Stack

xpStack :: PU Stack
xpStack =
  xpElem "stack" $
    xpWrap (uncurry8 Stack,
            \(Stack i  t  d  ua  pc  se  ai  a) ->
                   (i, t, d, ua, pc, se, ai, a)) $
    xp8Tuple (xpElem "id" xpText0)
             (xpElem "title" xpText0)
             (xpElem "description" xpText0)
             (xpElem "updated_at" xpText0)
             (xpElem "project_count" xpInt)
             (xpElem "stack_entries" (xpList xpickle))
             (xpElem "account_id" xpText0)
             (xpOption xpAccount)

instance IdL Stack where
  idL = lens staId $ \id sta -> sta { staId = id }

instance UpdatedAtL Stack where
  updatedAtL = lens staUpdatedAt $ \updatedAt sta -> sta { staUpdatedAt = updatedAt }
