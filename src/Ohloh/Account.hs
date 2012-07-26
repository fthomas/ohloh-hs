module Ohloh.Account (
  Account(..),
  readXmlString,
  showXmlString
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.KudoScore

data Account = Account {
  id :: String,
  name :: String,
  createdAt :: String,
  updatedAt :: String,
  homepageUrl :: String, -- optional
  avatarUrl :: String,
  emailSha1 :: String,
  postsCount :: Int,
  location :: String, --optional
  countryCode :: String, --optional
  latitude :: String, --optional
  longitude :: String, --optional
  kudoScore :: Maybe KudoScore
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
              (xpElem "homepage_url" xpText0)
              (xpElem "avatar_url" xpText0)
              (xpElem "email_sha1" xpText0)
              (xpElem "posts_count" xpInt)
              (xpElem "location" xpText0)
              (xpElem "country_code" xpText0)
              (xpElem "latitude" xpText0)
              (xpElem "longitude" xpText0)
              (xpOption (xpElem "kudo_score" xpickle))
