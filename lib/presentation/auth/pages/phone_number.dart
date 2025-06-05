// // lib/presentation/auth/pages/phone_number_page.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//
//
// import '../../../../core/go_route/routes.dart';
// import '../login/widget/custom_background_clipper.dart';
//
//
// class PhoneNumberPage extends StatefulWidget {
//   const PhoneNumberPage({super.key});
//
//   @override
//   State<PhoneNumberPage> createState() => _PhoneNumberPageState();
// }
//
// class _PhoneNumberPageState extends State<PhoneNumberPage> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//
//   var phoneNumberFormatter = MaskTextInputFormatter(
//     mask: '(##) ###-##-##',
//     filter: { "#": RegExp(r'[0-9]') },
//     type: MaskAutoCompletionType.lazy,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _phoneNumberController.text = '+998 ';
//     _phoneNumberController.selection = TextSelection.fromPosition(
//       TextPosition(offset: _phoneNumberController.text.length),
//     );
//   }
//
//   @override
//   void dispose() {
//     _phoneNumberController.dispose();
//     super.dispose();
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
//                   SizedBox(height: screenHeight * 0.1),
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
//                     "O'quv platformasiga kirish uchun telefon raqamingizni kiriting",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Telefon raqami",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _phoneNumberController,
//                     keyboardType: TextInputType.phone,
//                     style: const TextStyle(color: Colors.black),
//                     inputFormatters: [phoneNumberFormatter],
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 12.0),
//                         child: Icon(Icons.phone, color: Colors.grey),
//                       ),
//                       hintStyle: const TextStyle(color: Colors.grey),
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
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // "Kirish" tugmasini bosganda, "password" sahifasiga o'tish
//                         String unmaskedNumber = phoneNumberFormatter.getUnmaskedText();
//
//                         if (unmaskedNumber.length == 9) {
//                           print('Kiritilgan raqam (maskasiz): $unmaskedNumber');
//                           print('Raqam to\'g\'ri formatda. Password sahifasiga o\'tilmoqda.');
//                           context.go(AppRoutes.onetimepassword); // <-- Mana shu qator o'zgartirildi
//                         } else {
//                           print('Telefon raqami noto\'g\'ri formatda. Iltimos, to\'g\'ri kiriting.');
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Telefon raqami to\'liq kiritilmagan!')),
//                           );
//                         }
//                       },
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