-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referencecontributor_language_fact/>
module Web.Ohloh.ContributorLanguageFact (
  ContributorLanguageFact(..),
  xpContributorLanguageFact
) where

import Text.XML.HXT.Arrow.Pickle

import Web.Ohloh.Common

data ContributorLanguageFact = ContributorLanguageFact {
  clfAnalysisId :: String,
  clfContributorId :: String,
  clfContributorName :: String,
  clfLanguageId :: String,
  clfLanguageNiceName :: String,
  clfCommentRatio :: Double,
  clfManMonths :: Int,
  clfCommits :: Int,
  clfMedianCommits :: Int
} deriving (Eq, Read, Show)

instance XmlPickler ContributorLanguageFact where
  xpickle = xpContributorLanguageFact

instance ReadXmlString ContributorLanguageFact
instance ShowXmlString ContributorLanguageFact

xpContributorLanguageFact :: PU ContributorLanguageFact
xpContributorLanguageFact =
  xpElem "contributor_language_fact" $
    xpWrap (uncurry9 ContributorLanguageFact,
            \(ContributorLanguageFact ai  ci  cn  li  lnn  cr  mm  c  mc) ->
                                     (ai, ci, cn, li, lnn, cr, mm, c, mc)) $
    xp9Tuple (xpElem "analysis_id" xpText0)
             (xpElem "contributor_id" xpText0)
             (xpElem "contributor_name" xpText0)
             (xpElem "language_id" xpText0)
             (xpElem "language_nice_name" xpText0)
             (xpElem "comment_ratio" xpPrim)
             (xpElem "man_months" xpInt)
             (xpElem "commits" xpInt)
             (xpElem "median_commits" xpInt)
