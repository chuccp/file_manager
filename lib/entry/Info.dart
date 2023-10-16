import 'package:file_manager/entry/address.dart';

import '../util/json.dart';

class InfoItem {
  InfoItem({this.hasInit, this.remoteAddress, this.hasSignIn});

  bool? hasInit = false;

  bool? hasSignIn = false;

  List<String>? remoteAddress;

  List<AddressItem>? get address => remoteAddress?.map((e) {
        List<String> adr = e.split(":");
        return AddressItem(adr.first, int.parse(adr.last));
      }).toList();

  factory InfoItem.fromJson(Map<String, dynamic> json) {
    return InfoItem(
        hasInit: Json.getBool(json, "hasInit"),
        remoteAddress: Json.getListString(json, 'remoteAddress'),
        hasSignIn: Json.getBool(json, 'hasSignIn'));
  }
}
