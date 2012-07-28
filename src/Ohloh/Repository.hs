module Ohloh.Repository (
  RepositoryType(..),
  Repository(..),
  readXmlString,
  showXmlString
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data RepositoryType =
  SvnRepository |
  CvsRepository |
  GitRepository |
  HgRepository  |
  BzrRepository |
  SvnSyncRepository
  deriving (Eq, Read, Show)

data Repository = Repository {
  id :: String,
  repoType :: RepositoryType,
  url :: String,
  moduleName :: Maybe String,
  username :: Maybe String,
  password :: Maybe String,
  loggedAt :: String,
  commits :: Int,
  ohlohJobStatus :: String
} deriving (Eq, Read, Show)

instance XmlPickler Repository where
  xpickle = xpRepository

instance ReadXmlString Repository
instance ShowXmlString Repository

xpRepository :: PU Repository
xpRepository =
  xpElem "repository" $
    xpWrap (uncurry9 Repository,
            \(Repository i  rt  u  mn  un  pw  la  c  ojs) ->
                        (i, rt, u, mn, un, pw, la, c, ojs)) $
    xp9Tuple (xpElem "id" xpText0)
             (xpElem "type" xpPrim)
             (xpElem "url" xpText0)
             (xpOption (xpElem "module_name" xpText0))
             (xpOption (xpElem "username" xpText0))
             (xpOption (xpElem "password" xpText0))
             (xpElem "logged_at" xpText0)
             (xpElem "commits" xpInt)
             (xpElem "ohloh_job_status" xpText0)
