module KudoScore (
  KudoScore
) where

data KudoScore = KudoScore {
  createdAt :: String,
  kudoRank :: Int,
  position :: Int,
  maxPosition :: Int,
  positionDelta :: Int
} deriving (Eq, Read, Show)
