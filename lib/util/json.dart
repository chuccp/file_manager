class Json {
  static String getString(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      if (value.runtimeType == String) {
        return value;
      }
    }
    return "";
  }

  static List<String> getListString(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      if (value.runtimeType == List) {
        List<dynamic> list = value;
        List<String> strList = [];
        for (var value in list) {
          strList.add(value as String);
        }
        return strList;
      }
    }
    return [];
  }

  static List<dynamic> getListDynamic(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      if (value.runtimeType == List) {
        List<dynamic> list = value;
        return list;
      }
    }
    return [];
  }

  static int getInt(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      if (value.runtimeType == int) {
        return value;
      }
    }
    return 0;
  }

  static dynamic getDynamic(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      return value;
    }
    return null;
  }

  //dynamic

  static bool getBool(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      var value = json[key];
      if (value.runtimeType == bool) {
        return value;
      }
    }
    return false;
  }
}
