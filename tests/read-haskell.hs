import Text.Show.Pretty
import Text.XML.HXT.Core

import Web.Ohloh

main = do
  res <- runX $ xunpickleDocument xpResponse [ withRemoveWS yes ] "read-haskell.xml"
  putStrLn $ ppShow $ head res
