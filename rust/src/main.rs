extern crate json;
extern crate serde_json;

// Macros look like voodoo and the language authors caution against creating them
// except as a feature of last resort.
// https://doc.rust-lang.org/1.7.0/book/macros.html
#[macro_use]
extern crate serde_derive;
use serde_json::Error;
mod json_strings;

#[derive(Serialize, Deserialize)]
struct Player {
    name: String,
    winPercent: Option<f32>, // holy moly, I can have a "nullable" float and it was easy to define.
}

// Rust does not have the "Billion Dollar Mistake". Its FAQ answers that you can
// express the lack of a value with the Option type, which can be Some(T) or None.

// Rust also guarantees no null or dangling pointers by forcing each reference
// to borrow its value, during which time the value in memory cannot by destroyed or moved.
// You also cannot declare a variable unless it has a concrete value of that type.

// Rust has no exceptions as those do not play well with multi-threading,
// complicate understanding of flow-control, and don't leverage the type system as intended.

fn main() {
  // This will not throw an error when parsing fails as it returns a Result which can be Ok|Err.

  let parsed: Result<Player, Error> = serde_json::from_str(&json_strings::good());

  match parsed {
    Ok(player) =>
      match player.winPercent {
        Some(win_percent) =>
          println!("{} wins {:?}% of the time.", player.name, win_percent),

        None =>
          println!("{} is a new player.", player.name),
      }
      // The funky Elvis operator in the first argument of println! is what allows us to pass a Result
      // as the second argument, rather than a String. This is helpful for debugging purposes.
    Err(err) => println!("Oh no! {}", err),
      // println! ends with a bang because it's a macro,
      // which "expands to something" type-safe at compile time.
      // Macros can do things functions cannot, such as cause a wrapping function
      // to conditionally return, variadic arguments, access to language expressions passed to them,
      // rather than their results... probably other things too.
  }
}

// My Impression

// Rust is a large, powerful language with a terse, special-character-sprinked syntax
// that would require a lot of wrote memorization for me to become proficient.
// Its goals are clear and level-headed. It has frequent updates from the Mozilla development team.
// Its package manager cargo is easy to use.
// Rust compiles to system-native binary.
// Rust is probably superior to Go in terms of its goals, but with an unattractive learning curve.
