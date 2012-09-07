-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | <http://meta.ohloh.net/referencelanguage/>
module Ohloh.Language (
  Language(..),
  xpLanguage
) where

import Data.Lens.Common
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.Lens.IdL

data Language = Language {
  langId :: String,
  langName :: String,
  langNiceName :: String,
  langCategory :: String,
  langCode :: Int,
  langComments :: Int,
  langBlanks :: Int,
  langCommentRatio :: Double,
  langProjects :: Int,
  langContributors :: Int,
  langCommits :: Int
} deriving (Eq, Read, Show)

instance XmlPickler Language where
  xpickle = xpLanguage

instance ResultType Language
instance ReadXmlString Language
instance ShowXmlString Language

xpLanguage :: PU Language
xpLanguage =
  xpElem "language" $
    xpWrap (uncurry11 Language,
            \(Language i  n  nn  ca  co  cm  b  cr  p  cn  ci) ->
                      (i, n, nn, ca, co, cm, b, cr, p, cn, ci)) $
    xp11Tuple (xpElem "id" xpText0)
              (xpElem "name" xpText0)
              (xpElem "nice_name" xpText0)
              (xpElem "category" xpText0)
              (xpElem "code" xpInt)
              (xpElem "comments" xpInt)
              (xpElem "blanks" xpInt)
              (xpElem "comment_ratio" xpPrim)
              (xpElem "projects" xpInt)
              (xpElem "contributors" xpInt)
              (xpElem "commits" xpInt)

instance IdL Language where
  idL = lens langId $ \id lang -> lang { langId = id }
