import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'api_endpoints.dart';
import '../errors/exceptions.dart';

@singleton
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }

  Future<Response> postMultipart(String path, FormData formData) async {
    return _dio.post(path, data: formData);
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    handler.next(options);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw const NetworkException(message: 'Délai d\'attente dépassé');
      case DioExceptionType.connectionError:
        throw const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = _extractMessage(err.response?.data);
        throw ServerException(message: message, statusCode: statusCode);
      default:
        throw ServerException(message: err.message ?? 'Erreur inconnue');
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map) return data['message']?.toString() ?? 'Erreur serveur';
    return 'Erreur serveur';
  }
}
