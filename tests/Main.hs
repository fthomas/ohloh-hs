import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

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

prop_p a = readAccountFromString (showPickled [] a) == Just a

instance Arbitrary Account where
  arbitrary = do
    x <- arbitrary
    y <- arbitrary
    return (Account x y)
