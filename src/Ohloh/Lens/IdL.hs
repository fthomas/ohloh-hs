-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.Lens.IdL where

import Data.Lens.Common

class IdL a where
  idL :: Lens a String
