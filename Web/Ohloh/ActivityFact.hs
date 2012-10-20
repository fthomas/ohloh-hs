-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referenceactivity_fact/>
module Web.Ohloh.ActivityFact (
  ActivityFact(..),
  xpActivityFact
) where

import Text.XML.HXT.Arrow.Pickle

import Web.Ohloh.Common

data ActivityFact = ActivityFact {
  afMonth :: String,
  afCodeAdded :: Int,
  afCodeRemoved :: Int,
  afCommentsAdded :: Int,
  afCommentsRemoved :: Int,
  afBlanksAdded :: Int,
  afBlanksRemoved :: Int,
  afCommits :: Int,
  afContributors :: Int
} deriving (Eq, Read, Show)

instance XmlPickler ActivityFact where
  xpickle = xpActivityFact

instance ReadXmlString ActivityFact
instance ShowXmlString ActivityFact

xpActivityFact :: PU ActivityFact
xpActivityFact =
  xpElem "activity_fact" $
    xpWrap (uncurry9 ActivityFact,
            \(ActivityFact m  ca  cr  coa  cor  ba  br  c  co) ->
                          (m, ca, cr, coa, cor, ba, br, c, co)) $
    xp9Tuple (xpElem "month" xpText0)
             (xpElem "code_added" xpInt)
             (xpElem "code_removed" xpInt)
             (xpElem "comments_added" xpInt)
             (xpElem "comments_removed" xpInt)
             (xpElem "blanks_added" xpInt)
             (xpElem "blanks_removed" xpInt)
             (xpElem "commits" xpInt)
             (xpElem "contributors" xpInt)
