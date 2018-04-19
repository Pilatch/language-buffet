extern crate json;
extern crate serde_json;

#[macro_use]
extern crate serde_derive;
mod json_strings;

#[derive(Deserialize)]
struct Player {
    name: String,
    winPercent: Option<f32>,
}

fn introduce (player: Player) {
  match player.winPercent {
    Some(win_percent) =>
      println!("{} wins {:?}% of the time.", player.name, win_percent),

    None =>
      println!("{} is a new player.", player.name),
    }
}

fn main() {
  match serde_json::from_str(&json_strings::glad()) {
    Ok(player) => introduce(player),
    Err(err) => println!("Here's what went wrong. \n\n{}", err),
  }
}