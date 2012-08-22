-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

module Ohloh.Common where

import Text.XML.HXT.Core

class ReadXmlString a where
  readXmlString :: (XmlPickler a) => String -> Maybe a
  readXmlString xml =
    case runLA xread xml of
      [] -> Nothing
      (x:_) -> unpickleDoc xpickle x

class ShowXmlString a where
  showXmlString :: (XmlPickler a) => a -> String
  showXmlString = showPickled []

uncurry3 :: (t1 -> t2 -> t3 -> t) -> (t1, t2, t3) -> t
uncurry3 f (x1, x2, x3) =
         f  x1  x2  x3

uncurry4 :: (t1 -> t2 -> t3 -> t4 -> t) -> (t1, t2, t3, t4) -> t
uncurry4 f (x1, x2, x3, x4) =
         f  x1  x2  x3  x4

uncurry5 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t) -> (t1, t2, t3, t4, t5) -> t
uncurry5 f (x1, x2, x3, x4, x5) =
         f  x1  x2  x3  x4  x5

uncurry6 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t) -> (t1, t2, t3, t4, t5, t6) -> t
uncurry6 f (x1, x2, x3, x4, x5, x6) =
         f  x1  x2  x3  x4  x5  x6

uncurry7 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t) -> (t1, t2, t3, t4, t5, t6, t7) -> t
uncurry7 f (x1, x2, x3, x4, x5, x6, x7) =
         f  x1  x2  x3  x4  x5  x6  x7

uncurry9 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9) -> t
uncurry9 f (x1, x2, x3, x4, x5, x6, x7, x8, x9) =
         f  x1  x2  x3  x4  x5  x6  x7  x8  x9

uncurry10 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10) -> t
uncurry10 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10

uncurry11 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11) -> t
uncurry11 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11

uncurry13 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13) -> t
uncurry13 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13

uncurry14 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14) -> t
uncurry14 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14

uncurry15 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t15 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15) -> t
uncurry15 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14  x15
