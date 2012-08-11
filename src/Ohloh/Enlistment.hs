-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.Enlistment (
  Enlistment(..)
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.Repository

data Enlistment = Enlistment {
  enId :: String,
  enProjectId :: String,
  enRepositoryId :: String,
  enRepository :: Repository
} deriving (Eq, Read, Show)

instance XmlPickler Enlistment where
  xpickle = xpEnlistment

instance ReadXmlString Enlistment
instance ShowXmlString Enlistment

xpEnlistment :: PU Enlistment
xpEnlistment =
  xpElem "enlistment" $
    xpWrap (uncurry4 Enlistment,
            \(Enlistment i  pi  ri  r) ->
                        (i, pi, ri, r)) $
    xp4Tuple (xpElem "id" xpText0)
             (xpElem "project_id" xpText0)
             (xpElem "repository_id" xpText0)
             (xpElem "repository" xpickle)
