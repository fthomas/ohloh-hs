import Data.ByteString as BS
import Data.Maybe
import Network.Curl.Download

import Ohloh

key = ""

downloadFile item args = do
  let url = fromJust $ queryUrl item args `withApiKey` key
  content <- openURI url
  case content of
    Left  _ -> return ()
    Right x -> BS.writeFile (item ++ ".xml") x

main = do
  downloadFile "account" ["fst"]
  downloadFile "activity_facts" ["ohloh-hs", "latest"]
  downloadFile "analysis" ["ohloh-hs", "latest"]
  downloadFile "language" ["haskell"]
  downloadFile "project" ["ohloh-hs"]
  downloadFile "size_facts" ["ohloh-hs", "latest"]
