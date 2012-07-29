-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE TemplateHaskell, TypeOperators #-}

module Ohloh.Project (
  Project(Project)
) where

import Control.Category
import Data.Label
import Prelude hiding ((.), id)
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Analysis
import Ohloh.Common

data Project = Project {
  _id :: String,
  _name :: String,
  _createdAt :: String,
  _updatedAt :: String,
  _description :: Maybe String,
  _homepageUrl :: Maybe String,
  _downloadUrl :: Maybe String,
  _urlName :: String,
  _mediumLogoUrl :: String,
  _smallLogoUrl :: String,
  _stackCount :: Int,
  _averageRating :: Double,
  _ratingCount :: Int,
  _analysisId :: String,
  _analysis :: Analysis
} deriving (Eq, Read, Show)

mkLabels [''Project]

instance XmlPickler Project where
  xpickle = xpProject

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
              (xpElem "analysis" xpickle)
