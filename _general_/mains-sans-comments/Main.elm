module Main exposing (main)

import Html exposing (text)
import JsonStrings exposing (..)
import Json.Decode exposing (..)
import String.Interpolate exposing (interpolate)


type alias Player =
    { name : String, winPercent : Maybe Float }


main =
    gladJson
        |> decodePlayer
        |> introduce
        |> text


decodePlayer =
    decodeString <|
        map2 Player
            (field "name" string)
            (field "winPercent" (nullable float))


introduce result =
    case result of
        Ok player ->
            case player.winPercent of
                Nothing ->
                    interpolate "{0} is a new player." [ player.name ]

                Just percentage ->
                    interpolate "{0} wins {1}% of the time." [ player.name, toString percentage ]

        Err message ->
            "Error decoding player: " ++ message
