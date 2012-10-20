-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Web.Ohloh.Response (
  Response(..),
  xpResponse
) where

import Text.XML.HXT.Arrow.Pickle

import Web.Ohloh.Common
import Web.Ohloh.ResultType

data Response = Response {
  respStatus :: String,
  respError :: Maybe String,
  respItemsReturned :: Maybe Int,
  respItemsAvailable :: Maybe Int,
  respFirstItemPosition :: Maybe Int,
  respResult :: [ResultType]
} deriving (Eq, Show, Read)

instance XmlPickler Response where
  xpickle = xpResponse

instance ReadXmlString Response
instance ShowXmlString Response

xpResponse :: PU Response
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
