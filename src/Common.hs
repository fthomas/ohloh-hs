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
