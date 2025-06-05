// lib/presentation/auth/pages/otp_verification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/go_route/routes.dart';
import '../../../data/models/auth_models.dart';
import '../widgets/auth_background_clipper.dart'; // Yangi clipper

class OtpVerificationScreen extends StatefulWidget {
  final RegistrationPayload? registrationPayload; // Parametrni qabul qilish

  const OtpVerificationScreen({super.key, this.registrationPayload});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());

  final String _predefinedOtp = "111111"; // Tasdiqlash kodi uchun default qiymat

  bool _isInfoBoxVisible = true; // Yuqoridagi xabar qutisini ko'rsatish/yashirish holati
  late Timer _infoBoxTimer;

  @override
  void initState() {
    super.initState();
    _infoBoxTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isInfoBoxVisible = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    _infoBoxTimer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _moveToNextOrPreviousField(String value, int index) {
    if (value.length == 1 && index < _otpFocusNodes.length - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    } else if (value.length == 1 && index == _otpFocusNodes.length - 1) {
      FocusScope.of(context).unfocus();
      _verifyOtpAndShowResult(); // Parolni tekshirib, dialog oynasini ko'rsatish
    }
  }

  void _verifyOtpAndShowResult() {
    String enteredOtp = _otpControllers.map((e) => e.text).join();
    if (enteredOtp == _predefinedOtp) {
      debugPrint('OTP kodi to\'g\'ri!');
      _showSuccessVerificationDialog(); // Muvaffaqiyat dialogini ko'rsatish
    } else {
      debugPrint('Noto\'g\'ri OTP kodi. Qayta urinib ko\'ring.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Noto\'g\'ri tasdiqlash kodi! Qayta urinib ko\'ring.')),
      );
      // Agar noto'g'ri bo'lsa, kataklarni tozalash (ixtiyoriy)
      for (var controller in _otpControllers) {
        controller.clear();
      }
      _otpFocusNodes[0].requestFocus(); // Fokusni birinchi katakka qaytarish
    }
  }

  // Muvaffaqiyatli tasdiqlash dialog oynasini ko'rsatish funksiyasi
  void _showSuccessVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog oynasini tashqarini bosib yopib bo'lmasin
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent, // Orqa fonni shaffof qilish
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white, // Dialog foni oq
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F7FA), // Och havorang fon
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF26A69A), // To'q yashil check
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Raqam Tasdiqlandi!", // Matn o'zgarishi
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Telefon raqamingiz muvaffaqiyatli tasdiqlandi. Endi parolingizni o'rnating.", // Matn o'zgarishi
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dialog oynasini yopish
                      // Keyingi sahifaga (parol yaratish) o'tish va RegistrationPayloadni uzatish
                      context.go(AppPaths.createNewPassword, extra: widget.registrationPayload); // <--- O'zgarish
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26A69A), // Yashil rang
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
              ],
            ),
          ),
        );
      },
    );
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
                  // Xabar qutisi
                  if (_isInfoBoxVisible)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.only(top: 24, bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade600, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green.shade600),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              "Telefon raqamingizga tasdiqlash kodi yuborildi",
                              style: TextStyle(color: Colors.black87, fontSize: 13),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isInfoBoxVisible = false;
                              });
                            },
                            child: Icon(Icons.close, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: _isInfoBoxVisible ? 0 : screenHeight * 0.1),

                  const Text(
                    "Tasdiqlash kodi", // Matn o'zgarishi
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Yuborilgan 6 xonali kodni kiriting", // Matn o'zgarishi
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Kodni kiriting", // Matn o'zgarishi
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                          maxLength: 1,
                          obscureText: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            counterText: "",
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
                          ),
                          onChanged: (value) {
                            _moveToNextOrPreviousField(value, index);
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verifyOtpAndShowResult,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEA3B7A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Kodni tasdiqlash", // Matn o'zgarishi
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
                      ),
                      child: const Text(
                        "Raqamni o'zgartirish", // Matn o'zgarishi
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
}