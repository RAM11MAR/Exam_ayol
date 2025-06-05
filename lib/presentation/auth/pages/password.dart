// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../login/widget/custom_background_clipper.dart';
//
// class PasswordPage extends StatefulWidget {
//   const   PasswordPage({super.key});
//
//   @override
//   State<PasswordPage> createState() => _PasswordPageState();
// }
//
// class _PasswordPageState extends State<PasswordPage> {
//   // Parol va uni tasdiqlash uchun text fieldlar
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   // Parol ko'rinishini boshqarish uchun o'zgaruvchilar (ko'z ikonkasini bosganda)
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//
//   @override
//   void dispose() {
//     // Sahifa yopilganda controllerlarni tozalash
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   // "Kirish" tugmasini bosganda ishlaydigan funksiya
//   void _createPassword() {
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;
//
//     // Parol maydonlari bo'sh emasligini tekshirish
//     if (password.isEmpty || confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Parol va parolni tasdiqlash bo\'sh bo\'lmasligi kerak!')),
//       );
//       return; // Keyingi qadamga o'tishni to'xtatish
//     }
//
//     // Parollarning mos kelishini tekshirish
//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Parollar mos kelmadi!')),
//       );
//       return;
//     }
//
//     if (password.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Parol kamida 6 belgidan iborat bo\'lishi kerak!')),
//       );
//       return;
//     }
//
//     print("Yangi parol muvaffaqiyatli o'rnatildi: $password");
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Yangi parol muvaffaqiyatli o\'rnatildi!')),
//     );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//       statusBarBrightness: Brightness.dark,
//     ));
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E2E5B),
//       body: Stack(
//         children: [
//           // Yuqori qismdagi pushti va egri fon
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ClipPath(
//               clipper: CurvedBackgroundClipper(), // Maxsus egri clipper
//               child: Container(
//                 height: screenHeight * 0.5, // Ekranning yarmini egallaydi
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFFEA3B7A), // Pushti boshlanish rangi
//                       Color(0xFFC7006F), // To'q pushti tugash rangi
//                     ],
//                     begin: Alignment.topLeft, // Yuqori chapdan
//                     end: Alignment.bottomRight, // Pastki o'ngga
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SafeArea( // Xavfsiz hudud (notch, status bar ostida)
//             child: SingleChildScrollView( // Kontent uzun bo'lsa scroll qilish uchun
//               padding: const EdgeInsets.symmetric(horizontal: 24.0), // Gorizontal chekinish
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center, // Elementlarni markazga joylash
//                 children: [
//                   SizedBox(height: screenHeight * 0.1), // Yuqoridan bo'sh joy
//                   const Text(
//                     "Xush kelibsiz!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 8), // Matnlar orasidagi bo'sh joy
//                   const Text(
//                     "O'quv platformasiga kirish uchun quyida berilgan maydonlarni to'ldirib ro'yxatdan o'ting",
//                     textAlign: TextAlign.center, // Matnni markazga
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70, // Sal oqish rang
//                     ),
//                   ),
//                   const SizedBox(height: 32), // Pastdan bo'sh joy
//
//                   // "Ro'yxatdan o'tish" sarlavhasi
//                   Align(
//                     alignment: Alignment.centerLeft, // Chapga joylash
//                     child: Text(
//                       "Ro'yxatdan o'tish",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white, // Oq rang
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16), // Sarlavha va input orasidagi bo'sh joy
//
//                   // Parol kiritish maydoni
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: !_isPasswordVisible, // Parolni yashirish/ko'rsatish
//                     style: const TextStyle(color: Colors.black), // Kiritilgan matn rangi
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white, // Orqa fon oq
//                       prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey), // Qulf ikonka
//                       hintText: "Parol", // O'rnatuvchi matn
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       suffixIcon: IconButton( // Ko'z ikonka
//                         icon: Icon(
//                           _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() { // Ko'rinish holatini o'zgartirish
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),
//                       border: OutlineInputBorder( // Chegara stili
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder( // Fokuslanganda chegara
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Color(0xFFEA3B7A)), // Pushti chegara
//                       ),
//                       enabledBorder: OutlineInputBorder( // Oddiy holatda chegara
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                     ),
//                   ),
//                   const SizedBox(height: 16), // Inputlar orasidagi bo'sh joy
//
//                   // Parolni tasdiqlash maydoni
//                   TextField(
//                     controller: _confirmPasswordController,
//                     obscureText: !_isConfirmPasswordVisible, // Parolni yashirish/ko'rsatish
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                       hintText: "Parolni tasdiqlash",
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                           });
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Color(0xFFEA3B7A)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                     ),
//                   ),
//                   const SizedBox(height: 24), // Pastdan bo'sh joy
//
//                   // "Kirish" tugmasi
//                   SizedBox(
//                     width: double.infinity, // Kengligi to'liq ekran
//                     height: 50, // Balandligi
//                     child: ElevatedButton(
//                       onPressed: _createPassword, // Yuqoridagi funksiyani chaqirish
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFEA3B7A), // Tugma rangi
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12), // Burchaklarni yumaloqlash
//                         ),
//                         elevation: 0, // Soyani olib tashlash
//                       ),
//                       child: const Text(
//                         "Kirish", // Tugma matni
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white, // Matn rangi
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24), // Qo'shimcha bo'sh joy
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }