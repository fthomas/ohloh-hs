import Test.QuickCheck
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Ohloh.Account
import Ohloh.Analysis
import Ohloh.KudoScore
import Ohloh.Project

main :: IO ()
main = defaultMain tests

tests = [
    testGroup "Account" [
      testProperty "showRead" prop_showReadAccount
    ],
    testGroup "Analysis" [
      testProperty "showRead" prop_showReadAnalysis
    ],
    testGroup "KudoScore" [
      testProperty "showRead" prop_showReadKudoScore
    ],
    testGroup "Project" [
      testProperty "showRead" prop_showReadProject
    ]
  ]

prop_showReadAccount x =
  ((readXmlString . showXmlString) x :: Maybe Account) == Just x

prop_showReadAnalysis x =
  ((readXmlString . showXmlString) x :: Maybe Analysis) == Just x

prop_showReadKudoScore x =
  ((readXmlString . showXmlString) x :: Maybe KudoScore) == Just x

prop_showReadProject x =
  ((readXmlString . showXmlString) x :: Maybe Project) == Just x


-- | List of legal XML characters, see http://www.w3.org/TR/REC-xml/#charsets
legalXmlChars :: [Char]
legalXmlChars = ['\x9', '\xA', '\xD']
             ++ ['\x20' .. '\xD7FF']
             ++ ['\xE000' .. '\xFFFD']
             ++ ['\x10000' .. '\x10FFFF']

legalXmlCharsSubset :: [Char]
legalXmlCharsSubset = ['\x9', '\xA']
                   ++ ['\x20' .. '\xFF']

xmlTextGen :: Gen String
xmlTextGen = (listOf . elements) legalXmlCharsSubset

instance Arbitrary Account where
  arbitrary = do
    i  <- xmlTextGen
    n  <- xmlTextGen
    ca <- xmlTextGen
    ua <- xmlTextGen
    hu <- xmlTextGen
    au <- xmlTextGen
    es <- xmlTextGen
    pc <- arbitrary
    l  <- xmlTextGen
    cc <- xmlTextGen
    la <- xmlTextGen
    lo <- xmlTextGen
    ks <- arbitrary
    return (Account i n ca ua hu au es pc l cc la lo ks)

instance Arbitrary Analysis where
  arbitrary = do
    i    <- xmlTextGen
    pi   <- xmlTextGen
    ua   <- xmlTextGen
    la   <- xmlTextGen
    min  <- xmlTextGen
    max  <- xmlTextGen
    tmcc <- arbitrary
    tcl  <- arbitrary
    mli  <- xmlTextGen
    mln  <- xmlTextGen
    return (Analysis i pi ua la min max tmcc tcl mli mln)

instance Arbitrary KudoScore where
  arbitrary = do
    ca <- xmlTextGen
    kr <- arbitrary
    p  <- arbitrary
    mp <- arbitrary
    pd <- arbitrary
    return (KudoScore ca kr p mp pd)

instance Arbitrary Project where
  arbitrary = do
    i   <- xmlTextGen
    n   <- xmlTextGen
    ca  <- xmlTextGen
    ua  <- xmlTextGen
    d   <- xmlTextGen
    hu  <- xmlTextGen
    du  <- xmlTextGen
    un  <- xmlTextGen
    mlu <- xmlTextGen
    slu <- xmlTextGen
    sc  <- arbitrary
    ar  <- arbitrary
    rc  <- arbitrary
    ai  <- xmlTextGen
    a   <- arbitrary
    return (Project i n ca ua (Just d) (Just hu) (Just du) un mlu slu sc ar rc ai a)
