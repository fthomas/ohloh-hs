module Common where

import Text.XML.HXT.Core

class ReadXmlString a where
  readXmlString :: (XmlPickler a) => String -> Maybe a
  readXmlString xml =
    case runLA xread xml of
      [] -> Nothing
      (x:xs) -> unpickleDoc xpickle x

class ShowXmlString a where
  showXmlString :: (XmlPickler a) => a -> String
  showXmlString = showPickled []

uncurry3 :: (t1 -> t2 -> t3 -> t) -> (t1, t2, t3) -> t
uncurry3 f (x1, x2, x3) =
         f  x1  x2  x3

uncurry5 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t) -> (t1, t2, t3, t4, t5) -> t
uncurry5 f (x1, x2, x3, x4, x5) =
         f  x1  x2  x3  x4  x5

uncurry13 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13) -> t
uncurry13 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13


