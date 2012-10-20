-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

-- | Common operations for 'Ohloh' types and convenience functions.
module Web.Ohloh.Common where

import Text.Format
import Text.XML.HXT.Core

queryPaths :: [(String, String)]
queryPaths = [
    ("account",             "accounts/{0}.xml"),
    ("accounts",            "accounts.xml"),
    ("activity_facts",      "projects/{0}/analyses/{1}/activity_facts.xml"),
    ("analysis",            "projects/{0}/analyses/{1}.xml"),
    ("contributor_fact",    "projects/{0}/contributors/{1}.xml"),
    ("contributor_facts",   "projects/{0}/contributors.xml"),
    ("enlistment",          "projects/{0}/enlistments/{1}.xml"),
    ("enlistments",         "projects/{0}/enlistments.xml"),
    ("factoid",             "projects/{0}/factoids/{1}.xml"),
    ("factoids",            "projects/{0}/factoids.xml"),
    ("kudos",               "accounts/{0}/kudos.xml"),
    ("kudos_sent",          "accounts/{0}/kudos/sent.xml"),
    ("language",            "languages/{0}.xml"),
    ("languages",           "languages.xml"),
    ("project",             "projects/{0}.xml"),
    ("projects",            "projects.xml"),
    ("size_facts",          "projects/{0}/analyses/{1}/size_facts.xml"),
    ("stack",               "accounts/{0}/stacks/{1}.xml"),
    ("stacks",              "projects/{0}/stacks.xml")
  ]

-- | Return an URL for the different items that can be queried:
--
-- > queryUrl "project" ["ohloh-hs"] == Just "http://www.ohloh.net/projects/ohloh-hs.xml"
-- > queryUrl "projects" []          == Just "http://www.ohloh.net/projects.xml"
--
--   A list of possible items can be retrieved with @map fst 'queryPaths'@.
queryUrl :: String -> [String] -> Maybe String
queryUrl x args = do
  let url = "http://www.ohloh.net/"
  path <- lookup x queryPaths
  return $ url ++ (format path args)

-- | Append an API key to an URL, i.e.
--
-- > queryUrl "language" ["haskell"] `withApiKey` "YOUR_API_KEY"
--
--   returns @Just \"http:\/\/www.ohloh.net\/languages\/haskell.xml?api_key=YOUR_API_KEY\"@.
withApiKey :: Maybe String -> String -> Maybe String
withApiKey url key = fmap (++ "?api_key=" ++ key) url

class ReadXmlString a where
  readXmlString :: (XmlPickler a) => String -> Maybe a
  readXmlString xml =
    case runLA xread xml of
      [] -> Nothing
      (x:_) -> unpickleDoc xpickle x

class ShowXmlString a where
  showXmlString :: (XmlPickler a) => a -> String
  showXmlString = showPickled []

-- | Like 'uncurry' but for functions with 3 arguments.
uncurry3 :: (t1 -> t2 -> t3 -> t) -> (t1, t2, t3) -> t
uncurry3 f (x1, x2, x3) =
         f  x1  x2  x3

-- | Like 'uncurry' but for functions with 4 arguments.
uncurry4 :: (t1 -> t2 -> t3 -> t4 -> t) -> (t1, t2, t3, t4) -> t
uncurry4 f (x1, x2, x3, x4) =
         f  x1  x2  x3  x4

-- | Like 'uncurry' but for functions with 5 arguments.
uncurry5 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t) -> (t1, t2, t3, t4, t5) -> t
uncurry5 f (x1, x2, x3, x4, x5) =
         f  x1  x2  x3  x4  x5

-- | Like 'uncurry' but for functions with 6 arguments.
uncurry6 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t) -> (t1, t2, t3, t4, t5, t6) -> t
uncurry6 f (x1, x2, x3, x4, x5, x6) =
         f  x1  x2  x3  x4  x5  x6

-- | Like 'uncurry' but for functions with 7 arguments.
uncurry7 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t) -> (t1, t2, t3, t4, t5, t6, t7) -> t
uncurry7 f (x1, x2, x3, x4, x5, x6, x7) =
         f  x1  x2  x3  x4  x5  x6  x7

-- | Like 'uncurry' but for functions with 8 arguments.
uncurry8 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8) -> t
uncurry8 f (x1, x2, x3, x4, x5, x6, x7, x8) =
         f  x1  x2  x3  x4  x5  x6  x7  x8

-- | Like 'uncurry' but for functions with 9 arguments.
uncurry9 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9) -> t
uncurry9 f (x1, x2, x3, x4, x5, x6, x7, x8, x9) =
         f  x1  x2  x3  x4  x5  x6  x7  x8  x9

-- | Like 'uncurry' but for functions with 10 arguments.
uncurry10 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10) -> t
uncurry10 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10

-- | Like 'uncurry' but for functions with 11 arguments.
uncurry11 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11) -> t
uncurry11 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11

-- | Like 'uncurry' but for functions with 13 arguments.
uncurry13 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13) -> t
uncurry13 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13

-- | Like 'uncurry' but for functions with 14 arguments.
uncurry14 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14) -> t
uncurry14 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14

-- | Like 'uncurry' but for functions with 15 arguments.
uncurry15 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t15 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15) -> t
uncurry15 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14  x15

-- | Like 'uncurry' but for functions with 16 arguments.
uncurry16 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t15 -> t16 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16) -> t
uncurry16 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14  x15  x16

-- | Like 'uncurry' but for functions with 17 arguments.
uncurry17 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t15 -> t16 -> t17 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17) -> t
uncurry17 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14  x15  x16  x17

-- | Like 'uncurry' but for functions with 18 arguments.
uncurry18 :: (t1 -> t2 -> t3 -> t4 -> t5 -> t6 -> t7 -> t8 -> t9 -> t10 -> t11 -> t12 -> t13 -> t14 -> t15 -> t16 -> t17 -> t18 -> t) -> (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18) -> t
uncurry18 f (x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18) =
          f  x1  x2  x3  x4  x5  x6  x7  x8  x9  x10  x11  x12  x13  x14  x15  x16  x17  x18
