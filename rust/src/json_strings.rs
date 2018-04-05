// Documentation did not start with the simplest usage of modules first.
// It assumed some nesting, so I was considerably confused when I had to
// call json_strings::json_strings::good() because I had put good inside
// a "mod" named json_strings in a file called json_strings.
// It took me some time to even properly parse the compiler messages to correct this.

pub fn good() -> String {
  // There's nothing intuitive about r#"..."
  r#"{
    "name": "Nooby McNoobington",
    "winPercent": null
  }"#.to_string()
}

pub fn glad() -> String {
  r#"{
    "name": "Mikhail Tal",
    "winPercent": 85.2
  }"#.to_string()
}

pub fn dead() -> String {
  r#"{
    "name": "Never McWonAGame",
    "winPercent": 0
  }"#.to_string()
}

pub fn sad() -> String {
  r#"{
    "name": "Nooby McNoobington",
    "winPercent": false
  }"#.to_string()
}

pub fn bad() -> String {
  r#"{
    "name": "Nooby McNoobington",
    'winPercent': 13.3
  }"#.to_string()
}

pub fn rad() -> String {
  r#"{
    "foo": "Nooby McNoobington",
    "baz": 13.3
  }"#.to_string()
}