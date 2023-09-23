class Response {
  Response(this.code, this.data);

  final int code;
  final dynamic data;

  bool isOK(){
    return code == 200;
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    int code = 0;
    dynamic data;
    if (json.containsKey('code')) {
      code = json['code'];
    }
    if (json.containsKey('data')) {
      data = json['data'];
    }
    return Response(code, data);
  }
}
