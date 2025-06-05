// lib/data/repositories/auth_repository.dart

import 'package:shared_preferences/shared_preferences.dart';

 // <--- Bu yerda to'g'rilandi
import '../../core/client.dart';
import '../../core/exceptions/custom_exception.dart';
// import '../models/register_model.dart'; // <--- Endi kerak emas
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  // Foydalanuvchini ro'yxatdan o'tkazish
  Future<void> register(Map<String, dynamic> data) async {
    try {
      await apiClient.signUp(data);
    } catch (e) {
      rethrow;
    }
  }

  // Foydalanuvchi login (kirish)
  Future<User> login(String email, String password) async {
    try {
      final User? user = await apiClient.login(email, password);

      if (user == null) {
        throw CustomException(message: 'Login muvaffaqiyatsiz. Noto\'g\'ri email yoki parol.');
      }

      if (user.accessToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', user.accessToken!);
      }
      return user;
    } on CustomException catch (e) {
      rethrow;
    } catch (e) {
      throw CustomException(message: 'Noma\'lum xato yuz berdi: ${e.toString()}');
    }
  }

  // OTP yuborish
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await apiClient.sendOtpToPhoneNumber(phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  // OTP tasdiqlash
  Future<void> verifyOtp(String phoneNumber, String otpCode) async {
    try {
      await apiClient.verifyOtpPhoneNumber(phoneNumber, otpCode);
    } catch (e) {
      rethrow;
    }
  }

  // Yangi parol o'rnatish
  Future<void> setNewPassword(String phoneNumber, String newPassword) async {
    try {
      await apiClient.setNewPassword(phoneNumber, newPassword);
    } catch (e) {
      rethrow;
    }
  }

  // Tokenni olish
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Foydalanuvchini tizimdan chiqarish (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}