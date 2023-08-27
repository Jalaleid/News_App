import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      //baseUrl: 'https://newsapi.org/',
      baseUrl: 'https://gnews.io/api/'
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }
}
