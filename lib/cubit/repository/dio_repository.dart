import 'package:dio/dio.dart';

class DioRepository {
  late Dio client;
  final baseUrl = "";
  final rawBaseUrl = "";

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
        baseUrl: rawBaseUrl,
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
