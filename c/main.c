#include <stdio.h>
// Thanks clib!
// Parson is really simple. Unlike the other libraries we've dealt with,
// you supply a much simpler JSON schema.
#include "deps/parson/parson.c"
#include "json_strings.c"

int main() {
  const char * player_schema = "{"
    "\"name\": null,"
    "\"winPercent\": null"
  "}";

  JSON_Value *schema = json_parse_string(player_schema);
  JSON_Value *player_value = json_parse_string(glad_json);
  int validation_result = json_validate(schema, player_value);

  if (validation_result == JSONError || player_value == NULL) { // being extra safe with that null check
    // Passing it rad_json will result in an error.
    printf("JSON error");
    return 1;
  }

  JSON_Object *player_object = json_object(player_value);
  // If you provide a bad json string and don't validate,
  // the following function will return zero by default.
  // Maybe this is how you C. You don't blow up. Return something, darnit!
  const char * name = json_object_get_string(player_object, "name");
  // You have to check this way to avoid a pointer comparisons against int, which JSONNull is.
  // Was a small challenge. May the source be with you. Test source code in this case.
  if (json_object_has_value_of_type(player_object, "winPercent", JSONNull)) {
    printf("%s is a new player.", name);
  } else {
    const double winPercent = json_object_get_number(player_object, "winPercent");
    // We can get to here with a NULL player_value, it would print "(null) wins 0.000000% percent of the time.".
    printf("%s wins %f%% percent of the time.", name, winPercent);
  }
  return 0;
}

// C was originally developed by Dennis Ritchie between 1969 and 1973 at Bell Labs,
// and used to re-implement the Unix operating system. (It was originally written in assembly.)
// This allowed it to be much more portable.

// I've always been intimidated by C.

// There are header files and linking before compiling, so what does that mean?
// Your code may not necessarily be portable. You're expected to <code>./configure</code> before you <code>make install</code>
// if you're going to distribute your source code.

// C has a reputation for being very fast but dangerous.
// There are decades worth of software horror about dangling pointers, memory leaks,
// buffer overflows, security flaws. <code>malloc</code> in general has been sited
// for numerous problems such as the Heartbleed bug - https://www.seancassidy.me/diagnosis-of-the-openssl-heartbleed-bug.html.
// The paradox here is that our low-level, ubiquitous utilities such as openssl need to be be fast,
// but for that same reason are unlikely to be safe.

// My experience with this little exercise has been quite different from what I expected.
// The compiler is mostly friendly once you know the magic formula for verbosity.
// However GCC is a little slower than I expected, compared to Go.
// Using the <code>clib</code> package manager was fast and easy.
// Including a dependency was as simple as including my own source file.
// The syntax is easy to understand because, duh, it's where C-like syntax comes from!
// Unused variables result in compiler errors like Go.
// There are no exceptions.
// Because you can't throw, you always return something.

// A language where you have explicit control over memory is excellent for
// modern games where simulating an immersive reality is paramount.
// See frustum culling, a common technique. http://www.lighthouse3d.com/tutorials/view-frustum-culling/
// To achieve 60 frames per second, you have 16 milliseconds "to calculate, animate, do collision and draw the scene".
// Keep doing that.
// http://www.david-amador.com/2011/08/hurry-you-only-have-16-ms-to-render-everything/
