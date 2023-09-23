import 'package:file_manager/entry/address.dart';

class InfoItem {
  InfoItem(this.hasInit, this.remoteAddress);

  final bool hasInit;

  final List<String> remoteAddress;

  List<AddressItem>? get address=>remoteAddress.map((e){
    List<String> adr =  e.split(":");
    return AddressItem(adr.first,int.parse(adr.last));
  }).toList();


  factory InfoItem.fromJson(Map<String, dynamic> json) {
    bool hasInit = false;
    if (json.containsKey('hasInit')) {
      hasInit = json['hasInit'];
    }
    List<String> remoteAddress = [];
    if (json.containsKey('remoteAddress')) {
      List<dynamic> list= json['remoteAddress'];
      for (var value in list) {
        remoteAddress.add(value as String);
      }
    }
    return InfoItem(hasInit, remoteAddress);
  }
}
