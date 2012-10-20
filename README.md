ohloh-hs
========

ohloh-hs is a Haskell Interface to the [Ohloh API][].

[Ohloh API]: http://meta.ohloh.net/getting_started/

Building
--------

ohloh-hs uses the [Cabal](http://www.haskell.org/cabal/) build system.
To build ohloh-hs' tests and tools, run these command in its source tree:

    cabal configure --enable-tests
    cabal build

If the build succeeded, you can for example run the `cmdoh` tool:

    dist/build/cmdoh/cmdoh --help

Examples
--------

    cmdoh fetch -k YOUR_API_KEY_HERE language haskell

    cmdoh read -f tests/queries/language.xml


Author
------

ohloh-hs was written by Frank S. Thomas <<frank@timepit.eu>>
