{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

import           Data.Aeson

import qualified Data.ByteString.Lazy
import           GHC.Generics

jsonToDecode = Data.ByteString.Lazy.readFile "glad.json"

data Player = Player
  { name       :: String
  , winPercent :: Maybe Float
  } deriving (Show, Generic, FromJSON)

main = do
  result <- (eitherDecode <$> jsonToDecode) :: IO (Either String Player)
  case result of
    Left err -> print err
    Right player ->
      case winPercent player of
        Nothing -> print $ (name player) ++ " is a new player."
        Just winPercent ->
          print $
          (name player) ++ " wins " ++ (show winPercent) ++ "% of the time."
