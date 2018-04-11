package main

import (
  jsonStrings "./json"
  "encoding/json"
  "fmt"
  "github.com/davecgh/go-spew/spew"
  "github.com/xeipuuv/gojsonschema"
  "gopkg.in/guregu/null.v3"
)

type Player struct {
  Name       string
  WinPercent null.Float
}

func introduce(player Player) {
  if player.WinPercent.Valid {
    fmt.Printf("%v wins %v%% of the time.", player.Name, player.WinPercent.Float64)
  } else {
    fmt.Printf("%v is a new player.", player.Name)
  }

}

func main() {
  playerJson := jsonStrings.GladJson
  playerSchema := `{
    "type": "object",
    "required": ["name", "winPercent"],
    "properties": {
      "name": {"type": "string"},
      "winPercent": {"type": ["number", "null"]}
    }
  }`
  playerLoader := gojsonschema.NewStringLoader(playerJson)
  schemaLoader := gojsonschema.NewStringLoader(playerSchema)

  validationResult, validationErr := gojsonschema.Validate(schemaLoader, playerLoader)
  if validationErr != nil {

    fmt.Printf("Error parsing player JSON %v", validationErr.Error())
  } else if validationResult.Valid() {
    var player Player

    json.Unmarshal([]byte(playerJson), &player)

    introduce(player)

  } else {
    fmt.Printf("Invalid player.")

    spew.Dump(validationResult.Errors())
  }
}
