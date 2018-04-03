#include <stdio.h>
#include "deps/parson/parson.c"
#include "json_strings.c"

int main()
{
  JSON_Value *schema = json_parse_string(player_schema);
  JSON_Value *player_value = json_parse_string(good_json);
  int validation_result = json_validate(schema, player_value);

  if (validation_result == JSONError || player_value == NULL) {
    printf("JSON error");
    return 1;
  }

  JSON_Object *player_object = json_object(player_value);
  const char * name = json_object_get_string(player_object, "name");

  if (json_object_has_value_of_type(player_object, "winPercent", JSONNull)) {
    printf("%s is a new player.", name);
  } else {
    const double winPercent = json_object_get_number(player_object, "winPercent");

    printf("%s wins %f%% percent of the time.", name, winPercent);
  }
  return 0;
}
