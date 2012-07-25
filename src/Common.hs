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

uncurry5 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t) -> (t1, t2, t3, t4, t5) -> t
uncurry5 f (x1, x2, x3, x4, x5) = f x1 x2 x3 x4 x5
