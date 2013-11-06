# ohloh-hs
[![Build Status](https://travis-ci.org/fthomas/ohloh-hs.png?branch=master)](https://travis-ci.org/fthomas/ohloh-hs)

ohloh-hs is a Haskell Interface to the [Ohloh API][], which provides access
to the data of the Ohloh open source directory. It consists mainly of simple
data types for the items exposed by the API and corresponding [HXT][]
pickler functions in order to convert those types from/to XML easily.

[Ohloh API]: http://meta.ohloh.net/getting_started/
[HXT]: http://www.fh-wedel.de/~si/HXmlToolbox/

## Building

ohloh-hs uses the [Cabal](http://www.haskell.org/cabal/) build system.
To build ohloh-hs' tests and tools, run these command in its source tree:

    cabal configure --enable-tests
    cabal build

If the build succeeded, you can for example run the `cmdoh` tool:

    dist/build/cmdoh/cmdoh --help

## Examples

Here are some example invocations of the `cmdoh` tool:

    cmdoh fetch -k YOUR_API_KEY_HERE language haskell

    cmdoh read -f tests/queries/language.xml


## Author

ohloh-hs was written by Frank S. Thomas <<frank@timepit.eu>>
