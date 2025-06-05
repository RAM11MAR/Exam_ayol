// lib/presentation/auth/pages/phone_input_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // TextInputFormatter uchun
import 'package:go_router/go_router.dart';
import '../../../core/go_route/routes.dart';
import '../../../data/models/auth_models.dart';
import '../widgets/auth_background_clipper.dart';

class PhoneInputScreen extends StatefulWidget {
  final RegistrationPayload? registrationPayload; // Parametrni qabul qilish

  const PhoneInputScreen({super.key, this.registrationPayload});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _proceedToOtpVerification() {
    if (_phoneController.text.isEmpty || _phoneController.text.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iltimos, to\'g\'ri telefon raqamini kiriting!')),
      );
      return;
    }

    // Telefon raqamini RegistrationPayloadga qo'shish
    final updatedPayload = widget.registrationPayload?.copyWith(
      phoneNumber: _phoneController.text,
    );

    context.go(AppPaths.verifyOtpCode, extra: updatedPayload); // OTP sahifasiga o'tish
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2E2E5B),
      body: Stack(
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
                    "Telefon raqamingiz", // Matn o'zgarishi
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "SMS orqali tasdiqlash kodi yuborish uchun raqamingizni kiriting",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildPhoneInputField(_phoneController),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _proceedToOtpVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEA3B7A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Davom etish", // Matn o'zgarishi
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop(); // Orqaga qaytish
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
                        "Bekor qilish", // Matn o'zgarishi
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
    );
  }

  Widget _buildPhoneInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        // (99) 123-45-67 format uchun
        // LengthLimitingTextInputFormatter(9), // Raqamlar sonini cheklash
        // _PhoneNumberFormatter(), // Maxsus formatter kerak bo'lishi mumkin
      ],
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, color: Colors.grey),
              SizedBox(width: 8),
              Text("+998", style: TextStyle(color: Colors.black, fontSize: 16)),
              SizedBox(width: 8),
              VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
              SizedBox(width: 8),
            ],
          ),
        ),
        hintText: "99 123 45 67",
        hintStyle: const TextStyle(color: Colors.grey),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }
}