// lib/presentation/auth/pages/password_creation_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/go_route/routes.dart';
import '../../../data/models/auth_models.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_background_clipper.dart';

class PasswordCreationScreen extends StatefulWidget {
  final RegistrationPayload? registrationPayload; // Oldingi sahifalardan kelgan ma'lumotlar

  const PasswordCreationScreen({super.key, this.registrationPayload});

  @override
  State<PasswordCreationScreen> createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _displayMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _finalizeRegistrationProcess() {
    final String newPassword = _newPasswordController.text;
    final String confirmNewPassword = _confirmNewPasswordController.text;

    // Validatsiya
    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      _displayMessage('Iltimos, parollarni to\'ldiring!');
      return;
    }
    if (newPassword.length < 6) {
      _displayMessage('Parol kamida 6 belgidan iborat bo\'lishi kerak!');
      return;
    }
    if (newPassword != confirmNewPassword) {
      _displayMessage('Parollar mos kelmadi!');
      return;
    }

    if (widget.registrationPayload == null) {
      _displayMessage('Ro\'yxatdan o\'tish ma\'lumotlari topilmadi. Qayta urinib ko\'ring.', isError: true);
      return;
    }

    // RegistrationPayload'ni to'liq qilish (parolni qo'shish)
    final RegistrationPayload finalPayload = widget.registrationPayload!.copyWith(
      newPassword: newPassword,
    );

    // Backendga yuborish uchun AuthBloc'ga event yuborish
    context.read<AuthBloc>().add(AuthRegisterRequested(registerData: finalPayload.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFF2E2E5B),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)));
          } else if (state is AuthSuccess) {
            Navigator.pop(context); // Dialog yopish
            _displayMessage(state.message, isError: false);
            context.go(AppPaths.userSignIn); // Muvaffaqiyatli bo'lsa Login sahifasiga
          } else if (state is AuthFailure) {
            Navigator.pop(context); // Dialog yopish
            _displayMessage(state.error, isError: true);
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: AuthBackgroundClipper(),
                child: Container(
                  height: screenHeight * 0.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFEA3B7A),
                        Color(0xFFC7006F),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    const Text(
                      "Yangi parol", // Matn o'zgarishi
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Akkauntingizni himoyalash uchun yangi parol yarating", // Matn o'zgarishi
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Parol",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(_newPasswordController, "Yangi parol", Icons.lock_outline, _isNewPasswordVisible, (value) {
                      setState(() {
                        _isNewPasswordVisible = value;
                      });
                    }),
                    const SizedBox(height: 16),
                    _buildPasswordField(_confirmNewPasswordController, "Parolni qayta kiriting", Icons.lock_outline, _isConfirmNewPasswordVisible, (value) {
                      setState(() {
                        _isConfirmNewPasswordVisible = value;
                      });
                    }),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _finalizeRegistrationProcess, // Ro'yxatdan o'tishni yakunlash
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEA3B7A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const CircularProgressIndicator(color: Colors.white);
                            }
                            return const Text(
                              "Ro'yxatdan o'tishni yakunlash", // Matn o'zgarishi
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop(); // Oldingi sahifaga qaytish
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2E5B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.white70),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Orqaga",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText, IconData icon, bool isVisible, ValueChanged<bool> onVisibilityChanged) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            onVisibilityChanged(!isVisible);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEA3B7A), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
    );
  }
}