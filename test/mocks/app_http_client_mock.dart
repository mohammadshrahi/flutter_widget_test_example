import 'package:dio/src/response.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/cancel_token.dart';
import 'package:weather_widget_test_app/core/app_http_client.dart';
import 'dart:convert';
import 'dart:io';

class MockAppHttpClient extends HttpClient {
  static int statusCode = 200;
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (path.contains('api.weatherstack.com/current')) {
        final res = await getResponse(
            await _getData('current_weather_response.json'), path);
        return res as Response<T>;
      }
    } catch (e) {
      rethrow;
    }
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> _getData(String filePath) async {
    try {
      var dir = Directory.current.path;
      var input = File('$dir/test/mocks/$filePath').readAsStringSync();
      var map = jsonDecode(input);
      return map;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> getResponse<T>(T data, String path) async {
    return Response(
        requestOptions: RequestOptions(
          path: path,
        ),
        data: data,
        statusCode: statusCode);
  }

  static void setStatusCode(int status) {
    statusCode = status;
  }
}
