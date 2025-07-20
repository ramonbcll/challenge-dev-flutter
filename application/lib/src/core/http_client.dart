abstract interface class HttpClientCommon {
  Future<HttpClientResponse> get(HttpClientRequest request);

  Future<HttpClientResponse> post(HttpClientRequest request);

  Future<HttpClientResponse> put(HttpClientRequest request);

  Future<HttpClientResponse> delete(HttpClientRequest request);
}

class HttpClientResponse {
  final dynamic data;
  final int statusCode;

  HttpClientResponse({required this.data, required this.statusCode});
}

class HttpClientRequest {
  final String url;
  final Map<String, String>? headers;
  final Map<String, String>? queryParameters;
  final dynamic body;

  HttpClientRequest({
    required this.url,
    this.headers,
    this.queryParameters,
    this.body,
  });
}

class HttpClientExpection implements Exception {
  HttpClientExpection({this.data, required this.statusCode});

  final dynamic data;
  final int statusCode;
}
