-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.StackEntry (
  StackEntry(..),
  xpStackEntry
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.Project

data StackEntry = StackEntry {
  seId :: String,
  seCreatedAt :: String,
  seStackId :: String,
  seProjectId :: String,
  seProject :: Maybe Project
} deriving (Eq, Read, Show)

instance XmlPickler StackEntry where
  xpickle = xpStackEntry

instance ReadXmlString StackEntry
instance ShowXmlString StackEntry

xpStackEntry :: PU StackEntry
xpStackEntry =
  xpElem "stack_entry" $
    xpWrap (uncurry5 StackEntry,
            \(StackEntry i  ca  si  pi  p) ->
                        (i, ca, si, pi, p)) $
    xp5Tuple (xpElem "id" xpText0)
             (xpElem "created_at" xpText0)
             (xpElem "stack_id" xpText0)
             (xpElem "project_id" xpText0)
             (xpOption xpProject)
