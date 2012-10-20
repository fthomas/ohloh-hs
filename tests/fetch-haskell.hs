import Text.Show.Pretty
import Text.XML.HXT.Core
import Text.XML.HXT.Curl

import Web.Ohloh

-- Insert your API Key here:
apiKey = ""
myQueryUrl = "http://www.ohloh.net/languages/haskell.xml?api_key=" ++ apiKey

main = do
  res <- runX $ xunpickleDocument xpResponse [ withRemoveWS yes, withCurl [] ] $ myQueryUrl
  putStrLn $ ppShow $ head res
