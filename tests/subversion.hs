import Text.Show.Pretty
import Text.XML.HXT.Core

import Ohloh

main = do
  res <- runX $
    xunpickleDocument xpResponse [ withRemoveWS yes ] "subversion.xml"
  putStrLn $ ppShow $ head res
