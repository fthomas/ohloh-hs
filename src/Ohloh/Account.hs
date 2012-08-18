-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | <http://meta.ohloh.net/referenceaccount/>
module Ohloh.Account (
  Account(..),
  xpAccount
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.KudoScore

data Account = Account {
  accId :: String,
  accName :: String,
  accCreatedAt :: String,
  accUpdatedAt :: String,
  accHomepageUrl :: Maybe String,
  accAvatarUrl :: String,
  accEmailSha1 :: String,
  accPostsCount :: Int,
  accLocation :: Maybe String,
  accCountryCode :: Maybe String,
  accLatitude :: Maybe String,
  accLongitude :: Maybe String,
  accKudoScore :: Maybe KudoScore
} deriving (Eq, Read, Show)

instance XmlPickler Account where
  xpickle = xpAccount

instance ReadXmlString Account
instance ShowXmlString Account

xpAccount :: PU Account
xpAccount =
  xpElem "account" $
    xpWrap (uncurry13 Account,
            \(Account i  n  ca  ua  hu  au  es  pc  l  cc  la  lo  ks) ->
                     (i, n, ca, ua, hu, au, es, pc, l, cc, la, lo, ks)) $
    xp13Tuple (xpElem "id" xpText0)
              (xpElem "name" xpText0)
              (xpElem "created_at" xpText0)
              (xpElem "updated_at" xpText0)
              (xpOption (xpElem "homepage_url" xpText0))
              (xpElem "avatar_url" xpText0)
              (xpElem "email_sha1" xpText0)
              (xpElem "posts_count" xpInt)
              (xpOption (xpElem "location" xpText0))
              (xpOption (xpElem "country_code" xpText0))
              (xpOption (xpElem "latitude" xpText0))
              (xpOption (xpElem "longitude" xpText0))
              (xpOption xpKudoScore)
