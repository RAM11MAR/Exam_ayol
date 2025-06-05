// lib/core/api/client.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import yo'llarini loyihangizga moslang!
import '../../core/exceptions/custom_exception.dart'; // custom_exception.dart ning to'g'ri yo'li

import '../../data/models/user_model.dart';
import 'interceptors/auth_interceptor.dart'; // user_model.dart ning to'g'ri yo'li

class ApiClient {
  late Dio _dio;
  // Baza URL manzilingizni to'g'ri kiriting.
  // Agar emulator yoki real qurilma ishlatayotgan bo'lsangiz, IP manzil to'g'ri ekanligiga ishonch hosil qiling.
  final String _baseUrl = "http:// 192.168.1.100:8888/api/v1";

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10), // Ulanish vaqti
        receiveTimeout: const Duration(seconds: 10), // Ma'lumot qabul qilish vaqti
      ),
    );
    // Interseptorni qo'shish
    _dio.interceptors.add(AuthInterceptor());
  }

  // Dio xatolarini umumiy boshqarish metodi
  void _handleDioError(DioException e, String defaultMessage) {
    String errorMessage = defaultMessage;
    if (e.response != null && e.response!.data != null) {
      if (e.response!.data is Map && e.response!.data.containsKey('message') && e.response!.data['message'] is String) {
        errorMessage = e.response!.data['message'];
      } else if (e.response!.data is String) {
        errorMessage = e.response!.data; // Ba'zan xato xabari to'g'ridan-to'g'ri string bo'lishi mumkin
      }
    } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      errorMessage = "Ulanish vaqti tugadi. Internet aloqangizni tekshiring.";
    } else if (e.type == DioExceptionType.badResponse) {
      errorMessage = "Serverdan xato javob: ${e.response!.statusCode}. Iltimos, keyinroq urinib ko'ring.";
    } else if (e.type == DioExceptionType.unknown) {
      errorMessage = "Noma'lum internet xatosi. Aloqangizni tekshiring.";
    } else if (e.type == DioExceptionType.cancel) {
      errorMessage = "So'rov bekor qilindi.";
    }
    throw CustomException(message: errorMessage);
  }

  // Ro'yxatdan o'tish (Register)
  // Endi Map<String, dynamic> qabul qiladi
  Future<bool> signUp(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '/auth/register', // Ro'yxatdan o'tish uchun API endpoint
        data: data, // JSON formatida yuboriladigan ma'lumot
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true; // Muvaffaqiyatli ro'yxatdan o'tish
      } else {
        throw CustomException(message: response.statusMessage ?? "Ro'yxatdan o'tishda kutilmagan xato.");
      }
    } on DioException catch (e) {
      _handleDioError(e, "Ro'yxatdan o'tishda xato yuz berdi.");
      return false; // Error handled by _handleDioError, this line is for formality
    } catch (e) {
      throw CustomException(message: "Ro'yxatdan o'tishda kutilmagan xato: ${e.toString()}");
    }
  }

  // Tizimga kirish (Login)
  Future<User?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/auth/login", // Login uchun API endpoint
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final userData = response.data;
        final User user = User.fromJson(userData);

        // Access token'ni saqlash
        if (user.accessToken != null && user.accessToken!.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', user.accessToken!);
        } else if (userData['accessToken'] != null && userData['accessToken'].isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', userData['accessToken']);
        }
        return user;
      } else {
        throw CustomException(message: response.statusMessage ?? 'Login bo\'yicha xato.');
      }
    } on DioException catch (e) {
      _handleDioError(e, "Tizimga kirishda xato yuz berdi.");
      return null;
    } catch (e) {
      throw CustomException(message: "Tizimga kirishda kutilmagan xato: ${e.toString()}");
    }
  }

  // Telefon raqamiga OTP yuborish
  Future<void> sendOtpToPhoneNumber(String phoneNumber) async {
    try {
      final response = await _dio.post(
        '/auth/send-otp-phone', // OTP yuborish uchun API endpoint
        data: {'phoneNumber': phoneNumber},
      );
      if (response.statusCode != 200) {
        throw CustomException(message: response.data['message'] ?? 'OTP yuborishda xato.');
      }
    } on DioException catch (e) {
      _handleDioError(e, "OTP yuborishda xato yuz berdi.");
    } catch (e) {
      throw CustomException(message: "Kutilmagan xato: ${e.toString()}");
    }
  }

  // OTP tasdiqlash
  Future<void> verifyOtpPhoneNumber(String phoneNumber, String otpCode) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp-phone', // OTP tasdiqlash uchun API endpoint
        data: {
          'phoneNumber': phoneNumber,
          'otpCode': otpCode,
        },
      );
      if (response.statusCode != 200) {
        throw CustomException(message: response.data['message'] ?? 'OTP tasdiqlashda xato.');
      }
    } on DioException catch (e) {
      _handleDioError(e, "OTP tasdiqlashda xato yuz berdi.");
    } catch (e) {
      throw CustomException(message: "Kutilmagan xato: ${e.toString()}");
    }
  }

  // Yangi parol o'rnatish
  Future<void> setNewPassword(String phoneNumber, String newPassword) async {
    try {
      final response = await _dio.post(
        '/auth/set-new-password', // Yangi parol o'rnatish uchun API endpoint
        data: {
          'phoneNumber': phoneNumber,
          'newPassword': newPassword,
        },
      );
      if (response.statusCode != 200) {
        throw CustomException(message: response.data['message'] ?? 'Parol o\'rnatishda xato.');
      }
    } on DioException catch (e) {
      _handleDioError(e, "Parol o'rnatishda xato yuz berdi.");
    } catch (e) {
      throw CustomException(message: "Kutilmagan xato: ${e.toString()}");
    }
  }

  // Foydalanuvchi ma'lumotlarini olish (agar tokenni tekshirish uchun ishlatilsa)
  // Bu metod "AuthCheckStatus" eventida ishlatilishi mumkin
  Future<User?> fetchCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me'); // Hozirgi foydalanuvchi ma'lumotlari uchun endpoint
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      _handleDioError(e, "Foydalanuvchi ma'lumotlarini olishda xato.");
      return null;
    } catch (e) {
      throw CustomException(message: "Kutilmagan xato: ${e.toString()}");
    }
  }
}