-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.SizeFact (
  SizeFact(..),
  xpSizeFact
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data SizeFact = SizeFact {
  sfMonth :: String,
  sfCode :: Int,
  sfComments :: Int,
  sfBlanks :: Int,
  sfCommentRatio :: Double,
  sfCommits :: Int,
  sfManMonths :: Int
} deriving (Eq, Read, Show)

instance XmlPickler SizeFact where
  xpickle = xpSizeFact

instance ReadXmlString SizeFact
instance ShowXmlString SizeFact

xpSizeFact :: PU SizeFact
xpSizeFact =
  xpElem "size_fact" $
    xpWrap (uncurry7 SizeFact,
            \(SizeFact m  c  co  b  cr  cm  mm) ->
                      (m, c, co, b, cr, cm, mm)) $
    xp7Tuple (xpElem "month" xpText0)
             (xpElem "code" xpInt)
             (xpElem "comments" xpInt)
             (xpElem "blanks" xpInt)
             (xpElem "comment_ratio" xpPrim)
             (xpElem "commits" xpInt)
             (xpElem "man_months" xpInt)
