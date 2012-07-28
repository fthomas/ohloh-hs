-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.Analysis (
  Analysis(..),
  readXmlString,
  showXmlString
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data Analysis = Analysis {
  id :: String,
  projectId :: String,
  updatedAt :: String,
  loggedAt :: String,
  minMonth :: String,
  maxMonth :: String,
  twelveMonthContributorCount :: Int,
  totalCodeLines :: Int,
  mainLanguageId :: String,
  mainLanguageName :: String
} deriving (Eq, Read, Show)

instance XmlPickler Analysis where
  xpickle = xpAnalysis

instance ReadXmlString Analysis
instance ShowXmlString Analysis

xpAnalysis :: PU Analysis
xpAnalysis =
  xpElem "analysis" $
    xpWrap (uncurry10 Analysis,
            \(Analysis i  pi  ua  la  min  max  tmcc  tcl  mli  mln) ->
                      (i, pi, ua, la, min, max, tmcc, tcl, mli, mln)) $
    xp10Tuple (xpElem "id" xpText0)
              (xpElem "project_id" xpText0)
              (xpElem "updated_at" xpText0)
              (xpElem "logged_at" xpText0)
              (xpElem "min_month" xpText0)
              (xpElem "max_month" xpText0)
              (xpElem "twelve_month_contributor_count" xpInt)
              (xpElem "total_code_lines" xpInt)
              (xpElem "main_language_id" xpText0)
              (xpElem "main_language_name" xpText0)
