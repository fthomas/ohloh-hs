-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referenceaccount/>
module Ohloh.Account (
  Account(..),
  xpAccount
) where

import Data.Lens.Common
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.KudoScore
import Ohloh.Lens.IdL
import Ohloh.Lens.NameL
import Ohloh.Lens.UpdatedAtL

data Account = Account {
  accId :: String,
  accName :: String,
  accAbout :: Maybe String,
  accLogin :: String,
  accCreatedAt :: String,
  accUpdatedAt :: String,
  accHomepageUrl :: Maybe String,
  accTwitterAccount :: Maybe String,
  accUrl :: String,
  accHtmlUrl :: String,
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
    xpWrap (uncurry18 Account,
            \(Account i  n  a  log  ca  ua  hu  ta  u  htu  au  es  pc  l  cc  la  lo  ks) ->
                     (i, n, a, log, ca, ua, hu, ta, u, htu, au, es, pc, l, cc, la, lo, ks)) $
    xp18Tuple (xpElem "id" xpText0)
              (xpElem "name" xpText0)
              (xpOption (xpElem "about" xpText0))
              (xpElem "login" xpText0)
              (xpElem "created_at" xpText0)
              (xpElem "updated_at" xpText0)
              (xpOption (xpElem "homepage_url" xpText0))
              (xpOption (xpElem "twitter_account" xpText0))
              (xpElem "url" xpText0)
              (xpElem "html_url" xpText0)
              (xpElem "avatar_url" xpText0)
              (xpElem "email_sha1" xpText0)
              (xpElem "posts_count" xpInt)
              (xpOption (xpElem "location" xpText0))
              (xpOption (xpElem "country_code" xpText0))
              (xpOption (xpElem "latitude" xpText0))
              (xpOption (xpElem "longitude" xpText0))
              (xpOption xpKudoScore)

instance IdL Account where
  idL = lens accId $ \id acc -> acc { accId = id }

instance NameL Account where
  nameL = lens accName $ \name acc -> acc { accName = name }

instance UpdatedAtL Account where
  updatedAtL = lens accUpdatedAt $ \updatedAt acc -> acc { accUpdatedAt = updatedAt }
