module Project (
  Project(..),
  readXmlString,
  showXmlString
) where

import Text.XML.HXT.Arrow.Pickle

import Analysis
import Common

data Project = Project {
  id :: String,
  name :: String,
  createdAt :: String,
  updatedAt :: String,
  description :: Maybe String,
  homepageUrl :: Maybe String,
  downloadUrl :: Maybe String,
  urlName :: String,
  mediumLogoUrl :: String,
  smallLogoUrl :: String,
  stackCount :: Int,
  averageRating :: Double,
  ratingCount :: Int,
  analysisId :: String,
  analysis :: Analysis
} deriving (Eq, Read, Show)

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
