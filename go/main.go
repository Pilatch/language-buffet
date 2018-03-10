package main

// The Go compiler seems pretty neat because I can tell it to both compile and
// then run in one command without some ridiculous amount of setup like Java.
// Also it's garbage collected, has pointers, but not pointer math.

import (
  "encoding/json"
  jsonStrings "./json"
  "github.com/davecgh/go-spew/spew"
  "gopkg.in/guregu/null.v3"
  "fmt"
)

// Installing a third party library for the first time was not painless.
// Getting the GOPATH and GOROOT set up correctly took too long because
// the documentation was not intuitive.
// Also notice that I had to create a subfolder called json just so I could import
// my local stuff.

func main() {
  type Player struct {
    Name string
    WinPercent null.Float // regular ol' float64 is not nullable
  }
  // Using a third-party library to handle a nullable float field,
  // but I'm not convinced it's succinct or safe.
  var m Player

  // Passing a reference to an existing variable seems like a silly way
  // for a function to perform its duty, and reminds me of PHP.
  err := json.Unmarshal([]byte(jsonStrings.GoodJson), &m)

  if err != nil {
    // If the JSON is malformed, as in BadJson, the program will not bomb out.
    // It will return an error though.
    // In that case the variable m will have its initial values 0, 0, and "".
    // RadJson is valid, but has no fields that match the Player struct.
    // Then err is nil, but m has its initial values.
    // This is similar to how it's handled in Google Gson.
    // Using SadJson will result in an unmarshal error trying to convert bool to null.Float.
    // TODO add schema validation to ensure we have the expected data structure.
    spew.Dump(m) // You need a third-party library to easily inspect your structs.
    panic(err)
  } else if m.WinPercent.Valid { // So, a null is invalid I guess in this library.
    fmt.Printf("%v wins %v%% of the time.", m.Name, m.WinPercent.Float64)
  } else {
    fmt.Printf("%v is a new player.", m.Name)
  }
  // Inspecting the Unmarshaled GoodJson shows that the null was converted
  // to a zero for the float. For my program to understand that I could have a float or null
  // in a certain field, apparently I'd need to create a nullable float type,
  // but that's not the end of the story. There are further gotchas according to this discussion.
  // https://groups.google.com/forum/#!topic/golang-nuts/JOFWAqrTbUs
}
