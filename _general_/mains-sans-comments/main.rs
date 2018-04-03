extern crate json;
extern crate serde_json;

#[macro_use]
extern crate serde_derive;
use serde_json::Error;
mod json_strings;

#[derive(Serialize, Deserialize)]
struct Player {
    name: String,
    winPercent: Option<f32>,
}

fn main() {
  let parsed: Result<Player, Error> = serde_json::from_str(&json_strings::good());

  match parsed {
    Ok(player) =>
      match player.winPercent {
        Some(win_percent) =>
          println!("{} wins {:?}% of the time.", player.name, win_percent),

        None =>
          println!("{} is a new player.", player.name),
      }
    Err(err) => println!("Oh no! {}", err),
  }
}
