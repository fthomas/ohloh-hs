-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | <http://meta.ohloh.net/referencefactoid/>
module Ohloh.Factoid (
  Factoid(..),
  FactoidType(..),
  xpFactoid
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data FactoidType =
  FactoidActivityDecreasing |
  FactoidActivityIncreasing |
  FactoidAgeYoung           |
  FactoidAgeOld             |
  FactoidAgeVeryOld         |
  FactoidCommentsVeryLow    |
  FactoidCommentsLow        |
  FactoidCommentsHigh       |
  FactoidCommentsVeryHigh   |
  FactoidTeamSizeZero       |
  FactoidTeamSizeOne        |
  FactoidTeamSizeSmall      |
  FactoidTeamSizeLarge      |
  FactoidTeamSizeVeryLarge  |
  FactoidGplConflict
  deriving (Eq, Read, Show)

data Factoid = Factoid {
  factId :: String,
  factAnalysisId :: String,
  factType :: FactoidType,
  factDescription :: String,
  factSeverity :: Int,
  factLicenseId :: Maybe String
} deriving (Eq, Read, Show)

instance XmlPickler Factoid where
  xpickle = xpFactoid

instance ReadXmlString Factoid
instance ShowXmlString Factoid

xpFactoid :: PU Factoid
xpFactoid =
  xpElem "factoid" $
    xpWrap (uncurry6 Factoid,
            \(Factoid i  ai  t  d  s  li) ->
                     (i, ai, t, d, s, li)) $
    xp6Tuple (xpElem "id" xpText0)
             (xpElem "analysis_id" xpText0)
             (xpElem "type" xpPrim)
             (xpElem "description" xpText0)
             (xpElem "severity" xpInt)
             (xpOption (xpElem "license_id" xpText0))
