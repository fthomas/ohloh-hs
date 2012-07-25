module Account (
  Account(..),
  readXmlString,
  showXmlString
) where

import Text.XML.HXT.Arrow.Pickle

import Common
import KudoScore

data Account = Account {
  id :: String,
  name :: String
{-,
  createdAt :: String,
  updatedAt :: String,
  homepageUrl :: String,
  avatarUrl :: String,
  emailSha1 :: String,
  postsCount :: Int,
  location :: String,
  countryCode :: String,
  latitude :: String,
  longitude :: String,
  kudoScore :: Maybe KudoScore
-}
} deriving (Eq, Read, Show)

instance XmlPickler Account where
  xpickle = xpAccount

instance ReadXmlString Account
instance ShowXmlString Account

xpAccount :: PU Account
xpAccount =
  xpElem "account" $
    xpWrap (uncurry Account,
            \(Account i n) -> (i, n)) $
    xpPair (xpElem "id" xpText0)
           (xpElem "name" xpText0)
