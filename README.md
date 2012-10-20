ohloh-hs
========

Haskell Interface to the [Ohloh API](http://meta.ohloh.net/getting_started/).

Building
--------

ohloh-hs uses the [Cabal](http://www.haskell.org/cabal/) build system.
To build ohloh-hs' tests and tools, run these command in its source tree:

    cabal configure --enable-tests
    cabal build

If the build succeeded, the `cmdoh` tool for example can be called via:

    ./dist/build/cmdoh/cmdoh

Examples
--------

    cmdoh fetch -k YOUR_API_KEY_HERE language haskell
