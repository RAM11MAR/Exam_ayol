// lib/core/interceptors/auth_interceptor.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token != null && options.headers['Authorization'] == null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print('401 Unauthorized: Token yaroqsiz yoki muddati o\'tgan.');
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('accessToken');
        // Bu yerda foydalanuvchini login sahifasiga qaytarish kerak,
        // lekin Dio interseptoridan to'g'ridan-to'g'ri `context.go` ishlatish qiyin.
        // Odatda, bu BLoC yoki Repository orqali ishlanadi.
      });
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}