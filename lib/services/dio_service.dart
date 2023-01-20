// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class DioServices {
  static Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();

    return await dio
        .get(
      url,
      options: Options(
        responseType: ResponseType.json,
        method: "GET",
      ),
    )
        .then((response) {
      // print("Response: ${response.data}");
      return response;
    });
  }
}
