-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE TemplateHaskell, TypeOperators #-}

module Ohloh.Account (
  Account(Account)
) where

import Control.Category
import Data.Label
import Prelude hiding ((.), id)
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.KudoScore

data Account = Account {
  _id :: String,
  _name :: String,
  _createdAt :: String,
  _updatedAt :: String,
  _homepageUrl :: Maybe String,
  _avatarUrl :: String,
  _emailSha1 :: String,
  _postsCount :: Int,
  _location :: Maybe String,
  _countryCode :: Maybe String,
  _latitude :: Maybe String,
  _longitude :: Maybe String,
  _kudoScore :: Maybe KudoScore
} deriving (Eq, Read, Show)

mkLabels [''Account]

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
              (xpOption (xpElem "kudo_score" xpickle))
