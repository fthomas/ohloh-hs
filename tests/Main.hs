-- Copyright © 2012 Frank S. Thomas <frank@timepit.eu>
-- All rights reserved.
--
-- Use of this source code is governed by a BSD-style license that
-- can be found in the LICENSE file.

{-# OPTIONS -fno-warn-missing-signatures
            -fno-warn-orphans #-}

import Test.QuickCheck
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Text.XML.HXT.Core

import Ohloh

main :: IO ()
main = defaultMain tests


tests = [
    testGroup "Account" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Account -> Bool)
    ],
    testGroup "ActivityFact" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: ActivityFact -> Bool)
    ],
    testGroup "Analysis" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Analysis -> Bool)
    ],
    testGroup "ContributorLanguageFact" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: ContributorLanguageFact -> Bool)
    ],
    testGroup "Enlistment" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Enlistment -> Bool)
    ],
    testGroup "Factoid" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Factoid -> Bool)
    ],
    testGroup "KudoScore" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: KudoScore -> Bool)
    ],
    testGroup "Language" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Language -> Bool)
    ],
    testGroup "Project" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Project -> Bool)
    ],
    testGroup "Repository" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Repository -> Bool)
    ],
    testGroup "SizeFact" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: SizeFact -> Bool)
    ],
    testGroup "Stack" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: Stack -> Bool)
    ],
    testGroup "StackEntry" [
      testProperty "pickleUnpickle" (prop_pickleUnpickle :: StackEntry -> Bool)
    ]
  ]

prop_pickleUnpickle x = (unpickleDoc xpickle . pickleDoc xpickle) x == Just x


legalXmlCharsSubset = ['\x9', '\xA', '\xD'] ++ ['\x20' .. '\xFF']

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
    return (Account i n ca ua (Just hu) au es pc (Just l) (Just cc) (Just la) (Just lo) ks)

instance Arbitrary ActivityFact where
  arbitrary = do
    m   <- xmlTextGen
    ca  <- arbitrary
    cr  <- arbitrary
    coa <- arbitrary
    cor <- arbitrary
    ba  <- arbitrary
    br  <- arbitrary
    c   <- arbitrary
    co  <- arbitrary
    return (ActivityFact m ca cr coa cor ba br c co)

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

instance Arbitrary ContributorLanguageFact where
  arbitrary = do
    ai  <- xmlTextGen
    ci  <- xmlTextGen
    cn  <- xmlTextGen
    li  <- xmlTextGen
    lnn <- xmlTextGen
    cr  <- arbitrary
    mm  <- arbitrary
    c   <- arbitrary
    mc  <- arbitrary
    return (ContributorLanguageFact ai ci cn li lnn cr mm c mc)

instance Arbitrary Enlistment where
  arbitrary = do
    i  <- xmlTextGen
    pi <- xmlTextGen
    ri <- xmlTextGen
    r  <- arbitrary
    return (Enlistment i pi ri r)

instance Arbitrary FactoidType where
  arbitrary =
    elements [FactoidActivityDecreasing,
              FactoidActivityIncreasing,
              FactoidAgeYoung,
              FactoidAgeOld,
              FactoidAgeVeryOld,
              FactoidCommentsVeryLow,
              FactoidCommentsLow,
              FactoidCommentsHigh,
              FactoidCommentsVeryHigh,
              FactoidTeamSizeZero,
              FactoidTeamSizeOne,
              FactoidTeamSizeSmall,
              FactoidTeamSizeLarge,
              FactoidTeamSizeVeryLarge,
              FactoidGplConflict]

instance Arbitrary Factoid where
  arbitrary = do
    i  <- xmlTextGen
    ai <- xmlTextGen
    t  <- arbitrary
    d  <- xmlTextGen
    s  <- arbitrary
    li <- xmlTextGen
    return (Factoid i ai t d s (Just li))

instance Arbitrary KudoScore where
  arbitrary = do
    ca <- xmlTextGen
    kr <- arbitrary
    p  <- arbitrary
    mp <- arbitrary
    pd <- arbitrary
    return (KudoScore ca kr p mp pd)

instance Arbitrary Language where
  arbitrary = do
    i  <- xmlTextGen
    n  <- xmlTextGen
    nn <- xmlTextGen
    ca <- xmlTextGen
    co <- arbitrary
    cm <- arbitrary
    b  <- arbitrary
    cr <- arbitrary
    p  <- arbitrary
    cn <- arbitrary
    ci <- arbitrary
    return (Language i n nn ca co cm b cr p cn ci)

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

instance Arbitrary RepositoryType where
  arbitrary =
    elements [SvnRepository,
              CvsRepository,
              GitRepository,
              HgRepository,
              BzrRepository,
              SvnSyncRepository]

instance Arbitrary Repository where
  arbitrary = do
    i   <- xmlTextGen
    rt  <- arbitrary
    u   <- xmlTextGen
    mn  <- xmlTextGen
    un  <- xmlTextGen
    pw  <- xmlTextGen
    la  <- xmlTextGen
    c   <- arbitrary
    ojs <- xmlTextGen
    return (Repository i rt u (Just mn) (Just un) (Just pw) la c ojs)

instance Arbitrary SizeFact where
  arbitrary = do
    m  <- xmlTextGen
    c  <- arbitrary
    co <- arbitrary
    b  <- arbitrary
    cr <- arbitrary
    cm <- arbitrary
    mm <- arbitrary
    return (SizeFact m c co b cr cm mm)

instance Arbitrary Stack where
  arbitrary = do
    i  <- xmlTextGen
    ua <- xmlTextGen
    pc <- arbitrary
    se <- arbitrary
    ai <- xmlTextGen
    a  <- arbitrary
    return (Stack i ua pc se ai (Just a))

instance Arbitrary StackEntry where
  arbitrary = do
    i  <- xmlTextGen
    ca <- xmlTextGen
    si <- xmlTextGen
    pi <- xmlTextGen
    p  <- arbitrary
    return (StackEntry i ca si pi (Just p))
