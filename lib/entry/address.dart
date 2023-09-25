class AddressItem {
  AddressItem(this.host, this.port);

  int port;
  String host;

  @override
  String toString() {
    return "$host:$port";
  }
}
