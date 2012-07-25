import Test.QuickCheck
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Account
import KudoScore

main :: IO ()
main = defaultMain tests

tests = [
    testGroup "Account" [
      testProperty "showRead" prop_showReadAccount
    ],
    testGroup "KudoScore" [
      testProperty "showRead" prop_showReadKudoScore
    ]
  ]

prop_showReadAccount x
  = ((readXmlString . showXmlString) x :: Maybe Account) == Just x

prop_showReadKudoScore x
  = ((readXmlString . showXmlString) x :: Maybe KudoScore) == Just x


-- | List of legal XML characters, excluding '\xD' : ['\x10000' .. '\x10FFFF'].
--   See http://www.w3.org/TR/REC-xml/#charsets
legalXmlChars :: [Char]
legalXmlChars = ['\x9', '\xA'] ++ ['\x20' .. '\xD7FF'] ++ ['\xE000' .. '\xFFFD']

xmlTextGen :: Gen String
xmlTextGen = (listOf . elements) legalXmlChars

instance Arbitrary Account where
  arbitrary = do
    i <- xmlTextGen
    n <- xmlTextGen
    return (Account i n)

instance Arbitrary KudoScore where
  arbitrary = do
    ca <- xmlTextGen
    kr <- arbitrary
    p  <- arbitrary
    mp <- arbitrary
    pd <- arbitrary
    return (KudoScore ca kr p mp pd)
