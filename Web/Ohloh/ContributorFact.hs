-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referencecontributor_fact/>
module Web.Ohloh.ContributorFact (
  ContributorFact(..),
  xpContributorFact
) where

import Text.XML.HXT.Arrow.Pickle

import Web.Ohloh.Common
import Web.Ohloh.ContributorLanguageFact

-- | 'ContributorFact' contains a selection of high-level statistics about a
--   person who commited source code to a 'Web.Ohloh.Project.Project'.
data ContributorFact = ContributorFact {
  cfContributorId :: String,
  cfAccountId :: Maybe String,
  cfAccountName :: Maybe String,
  cfAnalysisId :: String,
  cfContributorName :: String,
  cfPrimaryLanguageId :: String,
  cfPrimaryLanguageNiceName :: String,
  cfCommentRatio :: Double,
  cfFirstCommitTime :: String,
  cfLastCommitTime :: String,
  cfManMonths :: Int,
  cfCommits :: Int,
  cfMedianCommits :: Int,
  cfContributorLanguageFacts :: Maybe [ContributorLanguageFact]
} deriving (Eq, Read, Show)

instance XmlPickler ContributorFact where
  xpickle = xpContributorFact

instance ReadXmlString ContributorFact
instance ShowXmlString ContributorFact

xpContributorFact :: PU ContributorFact
xpContributorFact =
  xpElem "contributor_fact" $
    xpWrap (uncurry14 ContributorFact,
            \(ContributorFact ci  aci  acn  ai  cn  pli  plnn  cr  fct  lct  mm  c  mc  clf) ->
                             (ci, aci, acn, ai, cn, pli, plnn, cr, fct, lct, mm, c, mc, clf)) $
    xp14Tuple (xpElem "contributor_id" xpText0)
              (xpOption (xpElem "account_id" xpText0))
              (xpOption (xpElem "account_name" xpText0))
              (xpElem "analysis_id" xpText0)
              (xpElem "contributor_name" xpText0)
              (xpElem "primary_language_id" xpText0)
              (xpElem "primary_language_nice_name" xpText0)
              (xpElem "comment_ratio" xpPrim)
              (xpElem "first_commit_time" xpText0)
              (xpElem "last_commit_time" xpText0)
              (xpElem "man_months" xpInt)
              (xpElem "commits" xpInt)
              (xpElem "median_commits" xpInt)
              (xpOption (xpElem "contributor_language_facts" xpickle))
