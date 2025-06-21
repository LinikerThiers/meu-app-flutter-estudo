import 'package:dio/dio.dart';

class JsonPlaceholderCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  JsonPlaceholderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";

    _dio.options.headers = {
      'Accept': 'application/json',
      'User-Agent': 'FlutterApp/1.0',
  };
  }
}