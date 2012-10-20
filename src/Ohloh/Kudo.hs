-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Ohloh API Reference: <http://meta.ohloh.net/referencekudo/>
module Ohloh.Kudo (
  Kudo(..),
  xpKudo
) where

import Text.XML.HXT.Arrow.Pickle

import Ohloh.Common

data Kudo = Kudo {
  kudoCreatedAt :: String,
  kudoSenderAccountId :: String,
  kudoSenderAccountName :: String,
  kudoReceiverAccountId :: Maybe String,
  kudoReceiverAccountName :: Maybe String,
  kudoProjectId :: Maybe String,
  kudoProjectName :: Maybe String,
  kudoContributorId :: Maybe String,
  kudoContributorName :: Maybe String
} deriving (Eq, Read, Show)

instance XmlPickler Kudo where
  xpickle = xpKudo

instance ReadXmlString Kudo
instance ShowXmlString Kudo

xpKudo :: PU Kudo
xpKudo =
  xpElem "kudo" $
    xpWrap (uncurry9 Kudo,
            \(Kudo ca  sai  san  rai  ran  pi  pn  ci  cn) ->
                  (ca, sai, san, rai, ran, pi, pn, ci, cn)) $
    xp9Tuple (xpElem "created_at" xpText0)
             (xpElem "sender_account_id" xpText0)
             (xpElem "sender_account_name" xpText0)
             (xpOption (xpElem "receiver_account_id" xpText0))
             (xpOption (xpElem "receiver_account_name" xpText0))
             (xpOption (xpElem "project_id" xpText0))
             (xpOption (xpElem "project_name" xpText0))
             (xpOption (xpElem "contributor_id" xpText0))
             (xpOption (xpElem "contributor_name" xpText0))
