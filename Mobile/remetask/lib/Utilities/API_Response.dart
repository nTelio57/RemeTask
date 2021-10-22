class API_Response<T>{
  API_Response(this.body, this.statusCode);

  T? body;
  int? statusCode;
}