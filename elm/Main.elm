module Main exposing (main)

import Html exposing (text)
import JsonStrings exposing (..)
import Json.Decode exposing (..)
import String.Interpolate exposing (interpolate)


-- type (without the alias) creates a new tagged union type.
-- In Elm, they're just referred to as union types.
-- A type alias however, leverages existing types.


type alias Player =
    { name : String, winPercent : Maybe Float }


main =
    -- Pipelining sends output from one function to the last input of the next function.
    -- This is the opposite of how Elixir does it, where input is sent to the first argument.
    -- If I understand correctly the <| operator is the same as Haskell's $ operator.
    gladJson
        |> decodePlayer
        |> introduce
        |> text


decodePlayer : String -> Result String Player
decodePlayer =
    -- map2 returns a Decoder.
    -- http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Decode#map2
    -- This is a two-part process. Decoding is both a compile-time and a run-time check.
    -- At compile time we make sure the decoder is properly mapping JSON fields to our Elm data structure.
    -- At run time decodeString is executed, which will produce a result with an error if either the JSON is invalid,
    -- or it does not have a shape the decoder expects.
    -- Notice we're not fully executing the decodeString function here.
    -- We're doing partial application by giving decodeString the decoder it needs as its first argument,
    -- which then returns a function with the signature String -> Result String Player
    -- http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Decode#decodeString
    -- This could also be written, perhaps more clearly, like so:
    -- let decoder = Decode.map2 ...
    -- in decodeString decoder
    decodeString <|
        map2 Player
            (field "name" string)
            (field "winPercent" (nullable float))



-- These functions don't all have type annotations, but probably should in a professional setting.
-- If you have an IDE with nifty plugins, (I'm thinking of Atom), then you can have the editor
-- automatically infer these type annotations.
-- Otherwise you can run
--   elm-make --warn Main.elm


introduce : Result String Player -> String
introduce result =
    -- Documentation on Result type http://package.elm-lang.org/packages/elm-lang/core/latest/Result
    -- Pattern match all the things. Elm does exhaustive case checking.
    case result of
        Ok player ->
            case player.winPercent of
                -- We can't use if/else because we need to unpack the Result and Maybe.
                -- We could do the following, but in the latter case it'll output
                -- "Mikhail Tal wins Just 85.2% of the time." (notice the "Just").
                --   if player.winPercent == Nothing then
                --      interpolate "{0} is a new player." [ player.name ]
                --   else
                --      interpolate "{0} wins {1}% of the time." [ player.name, toString player.winPercent ]
                Nothing ->
                    interpolate "{0} is a new player." [ player.name ]

                Just percentage ->
                    interpolate "{0} wins {1}% of the time." [ player.name, toString percentage ]

        Err message ->
            "Error decoding player: " ++ message



-- Elm is a domain-specific language for writing web applications.
-- Been around since 2012.
-- Its state architecture inspired Redux. https://redux.js.org/#influences
-- Best criticism of Elm I've seen, mostly about the Foreign Function Interface (FFI), restriction coming with the 0.19 compiler:
-- https://lukeplant.me.uk/blog/posts/two-experiences-with-elm/
-- There is praise for the language in there too, the most interesting being about tests
-- https://lukeplant.me.uk/blog/posts/two-experiences-with-elm/#fewertests
-- A rebuttal to that argument is that in the future Elm will compile to code to execute in other virtual machines, not just JS,
-- such as Web Assemply (WASM), BEAM (Erlang's virtual machine) and LLVM. https://llvm.org/
--   https://discourse.elm-lang.org/t/typed-arrays-for-elm/623/7
-- An interesting exploration of how fuzz testing can solve problems for you
--   https://ellie-app.com/nHNx6brVja1/0
-- Analysis of a React/Electron app ported to Elm/Electron https://toast.al/posts/code/2016-12-01-rewriting-react-and-releasing-elm-into-the-wild.html
-- Phoenix commonly gets paired with Elm:
--   http://codeloveandboards.com/blog/2017/02/02/phoenix-and-elm-a-real-use-case-pt-1/
--   https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499
--   https://becoming-functional.com/integrating-phoenix-and-elm-part-1-b66cf4294d13
-- Who uses Elm: (Some credit to this blog post https://www.imaginarycloud.com/blog/elm-javascript-reinvented-2/)
-- Elm 0.18 package count growing at about 1.5 per day. https://www.reddit.com/r/elm/comments/79qucw/789_packages_for_018_listed_in_packageelmlangorg/drao2lp/
-- Apparently there's also a directory for packages that go off-the-ranch a bit. http://elm-directory.herokuapp.com/
-- Amazon AWS Elm dev job - https://www.amazon.jobs/en/jobs/592545/front-end-engineer-aws
-- Azara https://www.azara.io/ https://www.reddit.com/r/elm/comments/827q57/azara_is_hiring_elm_developers/
-- Buddy Loans https://www.buddyloans.com/
-- CARFAX
-- CBANC (all front end dev is Elm) https://www.cbancnetwork.com/
-- CircuitHub https://circuithub.com/
-- CurrySoftware https://www.curry-software.com/en/
-- Day One https://dayoneapp.com/
-- Daily Drip https://github.com/dailydrip
-- Drip Engineering https://www.drip.com/
-- Future of Coding teaches Elm to 4th graders http://futureofcoding.org
-- Gizra https://www.gizra.com/
-- Grammarly https://www.grammarly.com/
-- No Red Ink https://www.noredink.com/
-- Pivotal Tracker https://www.pivotaltracker.com/
-- Prezi https://prezi.com/
-- Prima Assicurazioni https://www.prima.it/
-- YariLabs http://www.yarilabs.com/
