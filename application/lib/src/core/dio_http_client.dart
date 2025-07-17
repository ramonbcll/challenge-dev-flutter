import 'http_client.dart';
import 'package:dio/dio.dart';

class DioHttpClient implements HttpClientCommon {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<HttpClientResponse> delete(HttpClientRequest request) async {
    try {
      final response = await _dio.delete(
        request.url,
        options: Options(headers: request.headers),
        queryParameters: request.queryParameters,
      );
      return HttpClientResponse(
        data: response.data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (e) {
      throw HttpClientExpection(
        data: e.response?.data,
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpClientExpection(data: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<HttpClientResponse> get(HttpClientRequest request) async {
    try {
      final response = await _dio.get(
        request.url,
        options: Options(headers: request.headers),
        queryParameters: request.queryParameters,
      );
      return HttpClientResponse(
        data: response.data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (e) {
      throw HttpClientExpection(
        data: e.response?.data,
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpClientExpection(data: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<HttpClientResponse> post(HttpClientRequest request) async {
    try {
      final response = await _dio.post(
        request.url,
        options: Options(headers: request.headers),
        queryParameters: request.queryParameters,
      );
      return HttpClientResponse(
        data: response.data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (e) {
      throw HttpClientExpection(
        data: e.response?.data,
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpClientExpection(data: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<HttpClientResponse> put(HttpClientRequest request) async {
    try {
      final response = await _dio.put(
        request.url,
        options: Options(headers: request.headers),
        queryParameters: request.queryParameters,
      );
      return HttpClientResponse(
        data: response.data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (e) {
      throw HttpClientExpection(
        data: e.response?.data,
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw HttpClientExpection(data: e.toString(), statusCode: 500);
    }
  }
}
