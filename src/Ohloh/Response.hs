-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE TemplateHaskell, TypeOperators #-}

module Ohloh.Response (
  Response(Response)
) where

import Control.Category
import Data.Label
import Prelude hiding ((.), id)
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data Response a = Response {
  _status :: String,
  _error :: Maybe String,
  _itemsReturned :: Maybe Int,
  _itemsAvailable :: Maybe Int,
  _firstItemPosition :: Maybe Int,
  _result :: [a]
} deriving (Eq, Show, Read)

instance XmlPickler a => XmlPickler (Response a) where
  xpickle = xpResponse

instance ReadXmlString (Response a)
instance ShowXmlString (Response a)

xpResponse :: XmlPickler a => PU (Response a)
xpResponse =
  xpElem "response" $
    xpWrap (uncurry6 Response,
            \(Response s  e  ir  ia  fip  r) ->
                      (s, e, ir, ia, fip, r)) $
    xp6Tuple (xpElem "status" xpText0)
             (xpOption (xpElem "error" xpText0))
             (xpOption (xpElem "items_returned" xpInt))
             (xpOption (xpElem "items_available" xpInt))
             (xpOption (xpElem "first_item_position" xpInt))
             (xpElem "result" xpickle)
