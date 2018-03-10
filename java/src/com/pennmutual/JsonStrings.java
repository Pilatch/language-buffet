package com.pennmutual;

class JsonStrings {
	
  static String playerSchema =
"  {" +
"      \"type\": \"object\"," +
"      \"properties\": {" +
"          \"name\": {\"type\": \"string\"}," +
"          \"winPercent\": {\"type\": [\"number\", \"null\"]}" +
"      }" +
"  }";

	
  static String goodJson =
"  {" +
"      \"name\": \"Nooby McNoobington\"," +
"      \"winPercent\": null" +
"  }";

  static String gladJson =
"  {" +
"      \"name\": \"Mikhail Tal\"," +
"      \"winPercent\": 85.2" +
"  }";

  // Trying to bind this one to a Foo will result in an error being thrown.
  static String sadJson =
"  {" +
"      \"name\": \"Nooby McNoobington\"," +
"      \"winPercent\": false" +
"  }";

  // Single quotes or no quotes? No problem!
  // But a trailing comma? That's a paddlin'.
  static String badJson =
"  {" +
"      \"name\": \"Nooby McNoobington\"," +
"      'winPercent': 13.3" +
"  }";

  // This one actually causes an error to be thrown when parsed.
  static String dudJson = "I ain't JSON!";

  // What happens when our JSON has a completely different structure?
  static String radJson =
"  {" +
"      \"biz\": 345," +
"      \"quiz\": 13.3," +
"      \"whiz\": \"Nooby McNoobington\"" +
"  }";

  // Results in the target object just having its initial values.
  // (Same with radJson.)
  static String nulledJson =
"  {" +
"      \"name\": null" +
"      \"winPercent\": null" +
"  }";
}
