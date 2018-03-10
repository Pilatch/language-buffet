{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module JsonStrings
  ( goodJson
  , gladJson
  , badJson
  ) where

import           Text.Heredoc

goodJson =
  [str|
|  {
|    "name": "Nooby McNoobington",
|    "winPercent": null
|  }
|] :: String

gladJson =
  [str|
|  {
|    "name": "Mikhail Tal",
|    "winPercent": 85.2
|  }
|] :: String

badJson =
  [str|
|  {
|    "name": "Nooby McNoobington",
|    'winPercent': null
|  }
|] :: String
