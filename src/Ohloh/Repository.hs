-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referencerepository/>
module Ohloh.Repository (
  Repository(..),
  RepositoryType(..),
  xpRepository
) where

import Data.Lens.Common
import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common
import Ohloh.Lens.IdL

data RepositoryType =
  SvnRepository |
  CvsRepository |
  GitRepository |
  HgRepository  |
  BzrRepository |
  SvnSyncRepository
  deriving (Eq, Read, Show)

data Repository = Repository {
  repoId :: String,
  repoRepoType :: RepositoryType,
  repoUrl :: String,
  repoModuleName :: Maybe String,
  repoUsername :: Maybe String,
  repoPassword :: Maybe String,
  repoLoggedAt :: String,
  repoCommits :: Int,
  repoOhlohJobStatus :: String
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

instance IdL Repository where
  idL = lens repoId $ \id repo -> repo { repoId = id }
