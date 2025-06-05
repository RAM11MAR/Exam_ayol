// // lib/presentation/auth/pages/password_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'dart:async';
//
// import '../../../../core/go_route/routes.dart'; // AppRoutes ni import qilish
// import '../login/widget/custom_background_clipper.dart';
//
//
// class OneTimePasswordPage extends StatefulWidget {
//   const OneTimePasswordPage({super.key});
//
//   @override
//   State<OneTimePasswordPage> createState() => _OneTimePasswordPageState();
// }
//
// class _OneTimePasswordPageState extends State<OneTimePasswordPage> {
//   final List<TextEditingController> _controllers =
//   List.generate(6, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
//
//   final String _correctOtp = "111111"; // Tasdiqlash kodi uchun default qiymat
//
//   bool _showMessageBox = true; // Yuqoridagi xabar qutisini ko'rsatish/yashirish holati
//   late Timer _messageTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     _messageTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           _showMessageBox = false;
//         });
//       }
//     });
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _focusNodes[0].requestFocus();
//     });
//   }
//
//   @override
//   void dispose() {
//     _messageTimer.cancel();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   void _nextField(String value, int index) {
//     if (value.length == 1 && index < _focusNodes.length - 1) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     } else if (value.length == 1 && index == _focusNodes.length - 1) {
//       FocusScope.of(context).unfocus();
//       _checkOtpAndShowDialog(); // Parolni tekshirib, dialog oynasini ko'rsatish
//     }
//   }
//
//   void _checkOtpAndShowDialog() {
//     String enteredOtp = _controllers.map((e) => e.text).join();
//     if (enteredOtp == _correctOtp) {
//       print('Tasdiqlash kodi to\'g\'ri!');
//       _showSuccessDialog(); // Muvaffaqiyat dialogini ko'rsatish
//     } else {
//       print('Noto\'g\'ri tasdiqlash kodi. Qayta urinib ko\'ring.');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Noto\'g\'ri tasdiqlash kodi! Qayta urinib ko\'ring.')),
//       );
//       // Agar noto'g'ri bo'lsa, kataklarni tozalash (ixtiyoriy)
//       for (var controller in _controllers) {
//         controller.clear();
//       }
//       _focusNodes[0].requestFocus(); // Fokusni birinchi katakka qaytarish
//     }
//   }
//
//   // Muvaffaqiyatli tasdiqlash dialog oynasini ko'rsatish funksiyasi
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Dialog oynasini tashqarini bosib yopib bo'lmasin
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent, // Orqa fonni shaffof qilish
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white, // Dialog foni oq
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFE0F7FA), // Och havorang fon
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check,
//                     color: Color(0xFF26A69A), // To'q yashil check
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   "Muvaffaqiyatli tasdiqlandi",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "Telefon raqamingiz muvaffaqiyatli tasdiqlandi",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Dialog oynasini yopish
//                       context.go(AppRoutes.password); // Yangi parol sahifasiga o'tish
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF26A69A), // Yashil rang
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: const Text(
//                       "Tushunarli",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
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
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ClipPath(
//               clipper: CurvedBackgroundClipper(),
//               child: Container(
//                 height: screenHeight * 0.5,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFFEA3B7A),
//                       Color(0xFFC7006F),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Xabar qutisi
//                   if (_showMessageBox)
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       margin: const EdgeInsets.only(top: 24, bottom: 24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.green.shade600, width: 1.5),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.check_circle, color: Colors.green.shade600),
//                           const SizedBox(width: 10),
//                           const Expanded(
//                             child: Text(
//                               "Telefon raqamingizga tasdiqlash kodi yuborildi",
//                               style: TextStyle(color: Colors.black87, fontSize: 13),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 _showMessageBox = false;
//                               });
//                             },
//                             child: Icon(Icons.close, color: Colors.grey.shade600),
//                           ),
//                         ],
//                       ),
//                     ),
//                   SizedBox(height: _showMessageBox ? 0 : screenHeight * 0.1),
//
//                   const Text(
//                     "Xush kelibsiz!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "O'quv platformasiga kirish uchun quyida telefon raqamingizga yuborilgan tasdiqlash kodini kiriting",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Tasdiqlash kodi",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(6, (index) {
//                       return SizedBox(
//                         width: 50,
//                         height: 50,
//                         child: TextField(
//                           controller: _controllers[index],
//                           focusNode: _focusNodes[index],
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
//                           maxLength: 1,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             counterText: "",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Color(0xFFEA3B7A), width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           onChanged: (value) {
//                             _nextField(value, index);
//                           },
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _checkOtpAndShowDialog, // Endi bu funksiyani chaqiramiz
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFEA3B7A),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         "Kirish",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         context.go(AppRoutes.register);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E2E5B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: const BorderSide(color: Colors.white70),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         "Ro'yxatdan o'tish",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }