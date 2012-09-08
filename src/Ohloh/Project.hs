-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | <http://meta.ohloh.net/referenceproject/>
module Ohloh.Project (
  Project(..),
  xpProject
) where

import Data.Lens.Common
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Analysis
import Ohloh.Common
import Ohloh.Lens.IdL
import Ohloh.Lens.NameL

data Project = Project {
  projId :: String,
  projName :: String,
  projCreatedAt :: String,
  projUpdatedAt :: String,
  projDescription :: Maybe String,
  projHomepageUrl :: Maybe String,
  projDownloadUrl :: Maybe String,
  projUrlName :: String,
  projMediumLogoUrl :: String,
  projSmallLogoUrl :: String,
  projStackCount :: Int,
  projAverageRating :: Double,
  projRatingCount :: Int,
  projAnalysisId :: String,
  projAnalysis :: Analysis
} deriving (Eq, Read, Show)

instance XmlPickler Project where
  xpickle = xpProject

instance ResultType Project
instance ReadXmlString Project
instance ShowXmlString Project

xpProject :: PU Project
xpProject =
  xpElem "project" $
    xpWrap (uncurry15 Project,
            \(Project i  n  ca  ua  d  hu  du  un  mlu  slu  sc  ar  rc  ai  a) ->
                     (i, n, ca, ua, d, hu, du, un, mlu, slu, sc, ar, rc, ai, a)) $
    xp15Tuple (xpElem "id" xpText0)
              (xpElem "name" xpText0)
              (xpElem "created_at" xpText0)
              (xpElem "updated_at" xpText0)
              (xpOption (xpElem "description" xpText0))
              (xpOption (xpElem "homepage_url" xpText0))
              (xpOption (xpElem "download_url" xpText0))
              (xpElem "url_name" xpText0)
              (xpElem "medium_logo_url" xpText0)
              (xpElem "small_logo_url" xpText0)
              (xpElem "stack_count" xpInt)
              (xpElem "average_rating" xpPrim)
              (xpElem "rating_count" xpInt)
              (xpElem "analysis_id" xpText0)
              xpAnalysis

instance IdL Project where
  idL = lens projId $ \id proj -> proj { projId = id }

instance NameL Project where
  nameL = lens projName $ \name proj -> proj { projName = name }
