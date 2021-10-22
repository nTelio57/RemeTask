class API_Response<T>{
  API_Response(this.body, this.statusCode, this.reasonPhrase);

  T? body;
  int? statusCode;
  String? reasonPhrase;
}