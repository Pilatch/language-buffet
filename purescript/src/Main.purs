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
    (parsed :: Either _ Player) = readJSON gladJSON
    logEitherMyRecord (Left error) = log $ "failed to parse"
    logEitherMyRecord (Right player) =
      case player.winPercent of
        Nothing -> log $ player.name <> " is a new player"
        Just (winPercent :: Number) -> log $ player.name <> " wins " <> (toString winPercent) <> "% of the time."
  logEitherMyRecord parsed

-- Much thanks to https://www.youtube.com/watch?v=CEDOFwpoorQ
-- Previously I was trying to accomplish this with Argonaut.
-- Get it, JSON and the Argonauts? Anyhow, that was too complex for my purpose.

-- FFI is not taboo. Even a simple JSON-parsing library talks about it
-- https://github.com/purescript-contrib/purescript-argonaut-core/blob/master/README.md
-- Some confusing documentation on Either type https://pursuit.purescript.org/packages/purescript-either/3.0.0/docs/Data.Either#t:Either
-- Compare that to Elm's Maybe http://package.elm-lang.org/packages/elm-lang/core/latest/Maybe
-- And Rust's Option https://doc.rust-lang.org/std/option/
-- And Haskell's Maybe https://wiki.haskell.org/Maybe
-- The quickstart guide and much of what you find on Pursuit (the centralized documentation thing)
-- advises you to use Bower as a package manager.

-- There is also the psc-package thing. https://github.com/purescript/psc-package/releases
-- But using that is restrictive because of the concept of package-sets.
-- I tried but fell back to bower.
-- My guess is that this is tied to the fragile structure of NPM modules.

-- Helpful example on how to decode JSON. https://www.dgendill.com/posts/2017-03-05-purescript-json.html

-- They want you to buy a book to learn this language. https://leanpub.com/purescript/
-- Can't blame them. You probably do need to read a book for this one.
-- Otherwise the source must be with you, in the Jedi sense.

-- It wasn't until I came across some source code meant for an example that I got something working.
-- https://github.com/justinwoo/simple-json-example/tree/4246670cf93cf8ac410818520d4ea859753b0ff4

-- Finding the toString function was surprisingly difficult. It took a lot of searching.
-- Something tells me that google isn't indexing their documentation properly, or their SEO is lacking.

-- The compiler is not terribly helpful, and the only way I made progress was by scrapping the whole
-- project and starting over, re-installing the dependencies.

-- Writing new code with SublimeText is very slow. It seems like it's trying to search too much stuff
-- to do auto-completion or something, which does'nt even work, nor would I expect it to because
-- I didn't install any Purescript-specif module.

-- Importing a local module was intuitive and easy.

-- The compiler can infer the type of things that you just put in as underscore `_`.
-- But when you follow the warning that the compiler gives you, it's not easy to figure out
-- exactly what you need to import to gain access to that type. I'm guessing the source must be with you
-- to properly determine what that type is.

-- I can't even get this thing to console.log out a random variable. Apparently I need to find a
-- custom toString function to make that happen. This is galling becaues in node and in browsers
-- you can console.log out anything you want.

-- Want to run this in a browser?
-- https://stackoverflow.com/questions/46403106/how-to-get-from-pulp-init-to-running-code-in-browser
