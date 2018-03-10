{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

import           Data.Aeson

import qualified Data.ByteString.Lazy
import           GHC.Generics
import           JsonStrings

jsonToDecode = Data.ByteString.Lazy.readFile "good.json"

data Player = Player
  { name       :: String
  , winPercent :: Maybe Float
  } deriving (Show, Generic, FromJSON)

main = do
  result <- (eitherDecode <$> jsonToDecode) :: IO (Either String [Player])
  case result of
    Left err   -> print err
    Right name -> print name -- Installing hfmt to format my code felt necessary
-- because I wasn't finding a good way to make my data type look
-- tidy on my own. It took forever to install.
-- I can say the same for the Aeson module. It took far longer than
-- I expected to install that package.
-- The complexity seems unnecessary.
-- Hoogle is a hilarious name, but it's awesome.
-- It lets you seach for functions base on their type signature!
-- E.g. https://www.haskell.org/hoogle/?hoogle=String+-%3E+ByteString
-- Heredoc is not part of the core language, but a module.
-- Documancy - https://hackage.haskell.org/package/heredoc-0.2.0.0/docs/Text-Heredoc.html
-- I had to go to stack overflow to find out that I needed the LANGUAGE declarations on top to make heredocs work.
-- I tried using the heredocs but the Aeson library expects a certain type of ByteString
-- that is easiest to get from reading a file, and not easy to get from reading a string,
-- so I gave up on that and just saved to a file named good.json.
-- Unfortunately that refuses to decode properly and I haven't figured out why.
-- Here is the message I get, "Error in $: expected [a], encountered Object".
-- Still, look at jsonStrings.hs for example heredocs.
-- And... I've given up on Haskell. Other people have had the same problem that I did,
-- but somehow turning on the OverloadedStrings pragma solved it for them, but not me.
-- Note that means using the comment atop main.hs, and setting a compiler flag on the command line.
-- For some reason, setting that pragma is not necessary for DeriveGeneric, but the compiler flag is necessary.
