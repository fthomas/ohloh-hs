import qualified Data.ByteString as BS
import Network.Curl.Download
import Text.XML.HXT.Core

import Ohloh

key = ""

filename item = item ++ ".xml"

downloadFile item args = do
  let Just url = queryUrl item args `withApiKey` key
  putStrLn $ "Downloading " ++ url
  content <- openURI url
  case content of
    Left  x -> putStrLn x
    Right x -> BS.writeFile (filename item) x

unpickleFile item = do
  putStrLn $ "Unpickling " ++ (filename item)
  _ <- runX $ xunpickleDocument xpResponse [ withRemoveWS yes ] (filename item)
  return ()

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

  unpickleFile "account"
  unpickleFile "activity_facts"
  unpickleFile "analysis"
  unpickleFile "contributor_facts"
  unpickleFile "enlistments"
  unpickleFile "factoids"
  unpickleFile "language"
  unpickleFile "project"
  unpickleFile "size_facts"
  unpickleFile "stacks"
