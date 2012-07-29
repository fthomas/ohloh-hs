-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# LANGUAGE TemplateHaskell, TypeOperators #-}

module Ohloh.Repository (
  Repository(Repository),
  RepositoryType(..)
) where

import Control.Category
import Data.Label
import Prelude hiding ((.), id)
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
  _id :: String,
  _repoType :: RepositoryType,
  _url :: String,
  _moduleName :: Maybe String,
  _username :: Maybe String,
  _password :: Maybe String,
  _loggedAt :: String,
  _commits :: Int,
  _ohlohJobStatus :: String
} deriving (Eq, Read, Show)

mkLabels [''Repository]

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
