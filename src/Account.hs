module Account (
  Account(..),
  readAccountFromString
) where

import Text.XML.HXT.Arrow.Pickle

import Text.XML.HXT.Core

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

xpAccount :: PU Account
xpAccount =
  xpElem "account" $
    xpWrap (\(id, name) -> Account id name,
            \a -> (Account.id a, name a)) $
    xpPair (xpElem "id" xpText0)
           (xpElem "name" xpText0)



-- move to common
unpickleAccount :: XmlTree -> Maybe Account
unpickleAccount = unpickleDoc xpAccount

readAccountFromString :: String -> Maybe Account
readAccountFromString xml =
  case runLA xread xml of
    [] -> Nothing
    (x:xs) -> unpickleDoc xpAccount x

-- class ReadXmlString
