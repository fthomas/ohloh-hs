-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.ResultType (
  ResultType(..),
  xpResultType
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Account
import Ohloh.ActivityFact
import Ohloh.Analysis
import Ohloh.ContributorFact
import Ohloh.ContributorLanguageFact
import Ohloh.Enlistment
import Ohloh.Factoid
import Ohloh.Kudo
import Ohloh.Language
import Ohloh.Project
import Ohloh.SizeFact
import Ohloh.Stack

-- | ResultType is a simple sum type that can hold those types which can be part
--   of the @\/response\/result@ element (see 'Ohloh.Response.respResult').
data ResultType =
  AccountR Account |
  ActivityFactR ActivityFact |
  AnalysisR Analysis |
  ContributorFactR ContributorFact |
  ContributorLanguageFactR ContributorLanguageFact |
  EnlistmentR Enlistment |
  FactoidR Factoid |
  KudoR Kudo |
  LanguageR Language |
  ProjectR Project |
  SizeFactR SizeFact |
  StackR Stack
  deriving (Eq, Read, Show)

instance XmlPickler ResultType where
  xpickle = xpResultType

xpResultType :: PU ResultType
xpResultType = xpAlt tag ps
  where
    tag (AccountR _)                 = 0
    tag (ActivityFactR _)            = 1
    tag (AnalysisR _)                = 2
    tag (ContributorFactR _)         = 3
    tag (ContributorLanguageFactR _) = 4
    tag (EnlistmentR _)              = 5
    tag (FactoidR _)                 = 6
    tag (KudoR _)                    = 7
    tag (LanguageR _)                = 8
    tag (ProjectR _)                 = 9
    tag (SizeFactR _)                = 10
    tag (StackR _)                   = 11
    ps = [
        xpWrap (AccountR, \(AccountR x) -> x)
               xpAccount,
        xpWrap (ActivityFactR, \(ActivityFactR x) -> x)
               xpActivityFact,
        xpWrap (AnalysisR, \(AnalysisR x) -> x)
               xpAnalysis,
        xpWrap (ContributorFactR, \(ContributorFactR x) -> x)
               xpContributorFact,
        xpWrap (ContributorLanguageFactR, \(ContributorLanguageFactR x) -> x)
               xpContributorLanguageFact,
        xpWrap (EnlistmentR, \(EnlistmentR x) -> x)
               xpEnlistment,
        xpWrap (FactoidR, \(FactoidR x) -> x)
               xpFactoid,
        xpWrap (KudoR, \(KudoR x) -> x)
               xpKudo,
        xpWrap (LanguageR, \(LanguageR x) -> x)
               xpLanguage,
        xpWrap (ProjectR, \(ProjectR x) -> x)
               xpProject,
        xpWrap (SizeFactR, \(SizeFactR x) -> x)
               xpSizeFact,
        xpWrap (StackR, \(StackR x) -> x)
               xpStack
      ]
