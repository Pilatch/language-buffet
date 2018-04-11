package main

// The Go compiler is fast.
// It also seems pretty neat because I can tell it to both compile and
// then run in one command without some ridiculous amount of setup like Java.
// Also it's garbage collected, has pointers, but not pointer math.

import (
	jsonStrings "./json"
	"encoding/json"
	"fmt"
	"github.com/davecgh/go-spew/spew"
	"github.com/xeipuuv/gojsonschema"
	"gopkg.in/guregu/null.v3"
)

// Installing a third party library for the first time was not painless.
// Getting the GOPATH and GOROOT set up correctly took too long because
// the documentation was not intuitive.
// Also notice that I had to create a subfolder called json just so I could import
// my local stuff.

type Player struct {
	Name       string
	WinPercent null.Float // regular ol' float64 is not nullable
}

// Using a third-party library to handle a nullable float field,
// but I'm not convinced it's succinct or safe.

func introduce(player Player) {
	if player.WinPercent.Valid { // A null is invalid I guess in this library.
		fmt.Printf("%v wins %v%% of the time.", player.Name, player.WinPercent.Float64)
	} else {
		fmt.Printf("%v is a new player.", player.Name)
	}
	// Inspecting the Unmarshaled GoodJson shows that the null was converted
	// to a zero for the float. For my program to understand that I could have a float or null
	// in a certain field, apparently I'd need to create a nullable float type,
	// but that's not the end of the story. There are further gotchas according to this discussion.
	// https://groups.google.com/forum/#!topic/golang-nuts/JOFWAqrTbUs
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
		// We could use the panic() function to crash the program if we wanted to.
		fmt.Printf("Error parsing player JSON %v", validationErr.Error())
	} else if validationResult.Valid() {
		var player Player

		json.Unmarshal([]byte(playerJson), &player)
		// Passing a reference to an existing variable seems like a silly way
		// for a function to perform its duty, and reminds me of PHP.
		// If the JSON is malformed, as in BadJson, the program will not bomb out.
		// It will return an error though.
		// We don't capture that error because we assume our validator would have detected it already.
		// In that case the variable player would have its initial values 0, 0, and "".
		// RadJson is valid, but has no fields that match the Player struct.
		// Then unmarshalErr would be nil, but player has its initial values.
		// This is similar to how it's handled in Google Gson.
		// Using SadJson will result in an unmarshal error trying to convert bool to null.Float.
		// So unmarshaling to a Player instance is not enough to ensure correctness. We need the validator above.
		// To see these results I had to use a third-party library to easily inspect the struct.
		// That meant importing the following:
		// "github.com/davecgh/go-spew/spew"
		// And then calling the following in the code:
		// spew.Dump(player)
		introduce(player)

	} else {
		fmt.Printf("Invalid player.")
		// If we instead did fmt.Printf("Invalid player. %v", validationResult)
		// It would output something like Invalid player. &{[0xc42008e410 0xc42008e4b0] 0}
		spew.Dump(validationResult.Errors())
	}
}
