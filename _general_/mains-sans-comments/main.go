package main

import (
  "encoding/json"
  jsonStrings "./json"
  "github.com/davecgh/go-spew/spew"
  "gopkg.in/guregu/null.v3"
  "fmt"
)

func main() {
  type Player struct {
    Name string
    WinPercent null.Float
  }
  var m Player

  err := json.Unmarshal([]byte(jsonStrings.GoodJson), &m)

  if err != nil {
    spew.Dump(m)
    panic(err)
  } else if m.WinPercent.Valid {
    fmt.Printf("%v wins %v%% of the time.", m.Name, m.WinPercent.Float64)
  } else {
    fmt.Printf("%v is a new player.", m.Name)
  }
}
