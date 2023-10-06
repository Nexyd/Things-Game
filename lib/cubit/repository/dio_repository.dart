import 'package:dio/dio.dart';
import 'package:pastebin/pastebin.dart';

class DioRepository {
  late Dio client;
  final baseUrl = "https://pastebin.com";
  final rawBaseUrl = "https://pastebin.com/raw";
  final userKey = "2d7a99b044ec751a72423a9ab2c9b4da";
  final pastebin = withSingleApiDevKey(
    apiDevKey: "KMyCYinFCWJDdNlTQRYhYBDz2kLog4vB",
  );

  DioRepository() {
    client = _getClient();
  }

  Future<String> getRawJson(String url) async {
    final response = await client.get(url);
    return response.data;
  }

  Dio _getClient() {
    client = Dio(
      BaseOptions(
        baseUrl: 'https://pastebin.com/raw/',
        receiveDataWhenStatusError: true,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    client.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

    return client;
  }
}
