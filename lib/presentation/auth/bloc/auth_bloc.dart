
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

// Haqiqiy AuthRepository ni bu yerda import qilasiz
// import 'package:ayol_uchun/data/repositories/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final AuthRepository authRepository; // Agar repository ishlatilsa

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Backendga so'rov yuborish logikasi bu yerda bo'ladi
      // final response = await authRepository.login(event.credentials);
      // Agar backendga ulanish kerak bo'lsa, bu yerda simulyatsiya qilaman:
      await Future.delayed(const Duration(seconds: 2)); // Simulyatsiya

      // Muvaffaqiyatli login
      emit(const AuthSuccess(message: "Muvaffaqiyatli kirdingiz!"));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Backendga ro'yxatdan o'tish so'rovini yuborish logikasi
      // final response = await authRepository.register(event.registerData);
      // Agar backendga ulanish kerak bo'lsa, bu yerda simulyatsiya qilaman:
      await Future.delayed(const Duration(seconds: 2)); // Simulyatsiya

      // Muvaffaqiyatli ro'yxatdan o'tish
      emit(const AuthSuccess(message: "Ro'yxatdan muvaffaqiyatli o'tdingiz!"));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Logout logikasi
      await Future.delayed(const Duration(seconds: 1));
      emit(const AuthSuccess(message: "Chiqib ketdingiz!"));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}