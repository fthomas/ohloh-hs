import Text.Show.Pretty
import Text.XML.HXT.Core

import Ohloh

xpProjectResponse = xpResponse :: PU (Response Project)

main = do
  res <- runX $
    xunpickleDocument xpProjectResponse [ withRemoveWS yes ] "subversion.xml"
  putStrLn $ ppShow $ head res
