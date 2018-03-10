// No heredocs in C, but string concatenation is easy.

const char * player_schema = "{"
  "\"name\": null,"
  "\"winPercent\": null"
"}";

const char * good_json = "{"
  "\"name\": \"Nooby McNooberson\","
  "\"winPercent\": null"
"}";

const char * glad_json = "{"
  "\"name\": \"Mikhail Tal\","
  "\"winPercent\": 85.2"
"}";

const char * sad_json = "{"
  "\"name\": \"Nooby McNooberson\","
  "\"winPercent\": false"
"}";

const char * bad_json = "{"
  "\"name\": \"Nooby McNooberson\","
  "'winPercent': null"
"}";

const char * rad_json = "{"
  "\"zip\": 123,"
  "\"zop\": null,"
  "\"zub\": \"Boom!\""
"}";
