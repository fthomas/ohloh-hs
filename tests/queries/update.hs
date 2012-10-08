import qualified Data.ByteString as BS
import Network.Curl.Download

import Ohloh

key = ""

downloadFile item args = do
  let Just url = queryUrl item args `withApiKey` key
  let filename = item ++ ".xml"

  putStrLn $ "Downloading " ++ url
  content <- openURI url
  case content of
    Left  x -> putStrLn x
    Right x -> BS.writeFile filename x

main = do
  downloadFile "account" ["fst"]
  downloadFile "activity_facts" ["ohloh-hs", "latest"]
  downloadFile "analysis" ["ohloh-hs", "latest"]
  downloadFile "contributor_facts" ["ohloh-hs"]
  downloadFile "enlistments" ["ohloh-hs"]
  downloadFile "factoids" ["ohloh-hs"]
  downloadFile "language" ["haskell"]
  downloadFile "project" ["ohloh-hs"]
  downloadFile "size_facts" ["ohloh-hs", "latest"]
  downloadFile "stacks" ["ghc"]
