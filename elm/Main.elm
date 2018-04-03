module Main exposing (main)

import Html exposing (text)
import JsonStrings exposing (..)
import Json.Decode as Decode exposing (..)
import String.Interpolate exposing (interpolate)


type alias Player =
    { name : String, winPercent : Maybe Float }


main =
    gladJson
        |> decodePlayer
        |> introduce
        |> text


decodePlayer =
    Decode.map2 Player
        (field "name" string)
        (field "winPercent" (nullable float))
        |> decodeString


introduce result =
    case result of
        Ok player ->
            case player.winPercent of
                Just percentage ->
                    interpolate "{0} wins {1}% of the time." [ player.name, toString percentage ]

                Nothing ->
                    interpolate "{0} is a new player." [ player.name ]

        Err message ->
            "Here's what went wrong. \n\n" ++ message



-- Best criticism of Elm I've seen, mostly about the Foreign Function Interface, (FFI), restriction coming with the 0.19 compiler.
-- https://lukeplant.me.uk/blog/posts/two-experiences-with-elm/
-- There is praise for the language in there too, the most interesting being about tests
-- https://lukeplant.me.uk/blog/posts/two-experiences-with-elm/#fewertests
-- Analysis of a React/Electron app ported to Elm/Electron https://toast.al/posts/code/2016-12-01-rewriting-react-and-releasing-elm-into-the-wild.html
-- Phoenix gets paired with Elm on the front-end commonly.
-- Who uses Elm: (Some credit to this blog post https://www.imaginarycloud.com/blog/elm-javascript-reinvented-2/)
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
