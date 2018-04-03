module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Number.Format (toString)
import Simple.JSON (readJSON)
import JsonStrings (badJSON, gladJSON, goodJSON)

type Player =
  { name :: String
  , winPercent :: Maybe Number
  }


main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  let
    (parsed :: Either _ Player) = readJSON badJSON
    logEitherMyRecord (Left error) = log $ "failed to parse"
    logEitherMyRecord (Right player) =
      case player.winPercent of
        Nothing -> log $ player.name <> " is a new player"
        Just (winPercent :: Number) -> log $ player.name <> " wins " <> (toString winPercent) <> "% of the time."
  logEitherMyRecord parsed
