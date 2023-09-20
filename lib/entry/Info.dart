
class InfoItem {
  InfoItem(this.hasConfig);

  final bool hasConfig;

  factory InfoItem.fromJson(Map<String, dynamic> json) {
    bool hasConfig = false;
    if (json.containsKey('hasConfig')) {
      hasConfig = json['hasConfig'];
    }
    return InfoItem(hasConfig);
  }
}
