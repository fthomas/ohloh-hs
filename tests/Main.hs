import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Test.QuickCheck
import Test.QuickCheck.Arbitrary

import Account

import Text.XML.HXT.Core -- ?

main :: IO ()
main = defaultMain tests

tests = [
    testGroup "Account" [
      testProperty "aaa" prop_p
    ]
  ]

prop_p a = (readXmlString (showXmlString a) :: Maybe Account) == Just a

-- http://www.w3.org/TR/REC-xml/#charsets
legalXmlChars :: String
legalXmlChars = ['\x9', '\xA', '\xD']
             ++ ['\x20' .. '\xD7FF']
             ++ ['\xE000' .. '\xFFFD']
             -- ++ ['\x10000' .. '\x10FFFF']

instance Arbitrary Account where
  arbitrary = do
    id <- listOf $ elements legalXmlChars
    name <- listOf $ elements legalXmlChars
    return (Account id name)
