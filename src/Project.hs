module Project (
  Project
) where

data Project = Project {
  id :: String,
  name :: String
} deriving (Eq, Read, Show)
