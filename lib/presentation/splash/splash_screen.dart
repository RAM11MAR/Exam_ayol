// lib/presentation/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../core/go_route/routes.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.go(AppPaths.userSignIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Figma dizayniga ko'ra fon rangi oq.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Kontentni vertikal ravishda markazga joylashtirish.
          children: [
            // Matn va rasm kombinatsiyasidan iborat asosiy logotip.
            Row(
              mainAxisSize: MainAxisSize.min, // Qatorni o'z elementlari atrofida ixcham ushlab turish.
              children: [
                // Logotipning "Ayol" matn qismi.
                Text(
                  "Ayol",
                  style: TextStyle(
                    fontSize: 36, // Figma'dagi ko'rinishiga mos keladigan katta shrift o'lchami.
                    fontWeight: FontWeight.bold, // "Ayol" uchun qalin shrift.
                    color: Color(0xFF333333), // Matn uchun to'q kulrang rang.
                    fontFamily: 'Inter', // Inter yoki shunga o'xshash sans-serif shrifti.
                  ),
                ),
                // Logotipning "Uchun" matn qismi.
                Text(
                  "Uchun",
                  style: TextStyle(
                    fontSize: 36, // "Ayol" bilan bir xil o'lcham.
                    fontWeight: FontWeight.normal, // "Uchun" uchun oddiy shrift og'irligi.
                    color: Color(0xFF333333), // Matn uchun to'q kulrang rang.
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 10), // Matn va ikona orasidagi kichik bo'shliq.
                // Pushti yurak/siluet ikonasi.
                Image.asset(
                  'assets/images/ayol.png', // Ikona rasmining manzili.
                  width: 50, // Dizaynga mos keladigan kenglik.
                  height: 50, // Dizaynga mos keladigan balandlik.
                ),
              ],
            ),
            const SizedBox(height: 10), // Asosiy logotip va sarlavha orasidagi bo'shliq.
            // Asosiy logotip ostidagi sarlavha matni.
            const Text(
              "ayolar uchun maktabi",
              style: TextStyle(
                fontSize: 16, // Sarlavha uchun kichikroq shrift o'lchami.
                color: Color(0xFF666666), // Sarlavha uchun ochiqroq kulrang rang.
                fontFamily: 'Inter',
              ),
            ),
            // CircularProgressIndicator va "Yuklanmoqda..." matni
            // taqdim etilgan Figma dizaynida mavjud bo'lmagani sababli olib tashlandi.
          ],
        ),
      ),
    );
  }
}
