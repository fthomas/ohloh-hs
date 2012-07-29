-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE TemplateHaskell, TypeOperators #-}

module Ohloh.KudoScore (
  KudoScore(KudoScore)
) where

import Control.Category
import Data.Label
import Prelude hiding ((.), id)
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data KudoScore = KudoScore {
  _createdAt :: String,
  _kudoRank :: Int,
  _position :: Int,
  _maxPosition :: Int,
  _positionDelta :: Int
} deriving (Eq, Read, Show)

mkLabels [''KudoScore]

instance XmlPickler KudoScore where
  xpickle = xpKudoScore

instance ReadXmlString KudoScore
instance ShowXmlString KudoScore

xpKudoScore :: PU KudoScore
xpKudoScore =
  xpElem "kudo_score" $
    xpWrap (uncurry5 KudoScore,
            \(KudoScore ca  kr  p  mp  pd) ->
                       (ca, kr, p, mp, pd)) $
    xp5Tuple (xpElem "created_at" xpText0)
             (xpElem "kudo_rank" xpInt)
             (xpElem "position" xpInt)
             (xpElem "max_position" xpInt)
             (xpElem "position_delta" xpInt)
