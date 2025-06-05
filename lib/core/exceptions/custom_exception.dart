// lib/core/exceptions/custom_exception.dart

class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

  @override
  String toString() {
    return 'CustomException: $message';
  }
}