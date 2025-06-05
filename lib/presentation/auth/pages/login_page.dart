// // lib/presentation/auth/pages/login_page.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/go_route/routes.dart';
// import '../bloc/manager/auth_bloc.dart';
// import '../bloc/manager/auth_event.dart';
// import '../bloc/manager/auth_state.dart';
// import '../login/widget/custom_background_clipper.dart'; // To'g'ri import yo'li
// // import '../login/widget/social_login_button.dart'; // SocialLoginButton olib tashlandi
//
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//
//   // final GoogleSignIn _googleSignIn = GoogleSignIn(); // GoogleSignIn obyektini olib tashladim
//
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _loginUser() {
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text;
//
//     if (email.isEmpty || password.isEmpty) {
//       _showSnackBar('Iltimos, email va parolni to\'ldiring!');
//       return;
//     }
//
//     context.read<AuthBloc>().add(AuthLoginRequested(email: email, password: password));
//   }
//
//   // Google Sign-In funksiyasini olib tashladim
//   // Future<void> _handleGoogleSignIn() async {
//   //   try {
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//   //     if (googleUser != null) {
//   //       _showSnackBar('Google orqali kirdingiz: ${googleUser.email}', isError: false);
//   //       context.go(AppRoutes.home);
//   //     } else {
//   //       _showSnackBar('Google orqali kirish bekor qilindi.');
//   //     }
//   //   } catch (error) {
//   //     print('Google Sign-In Error: $error');
//   //     _showSnackBar('Google orqali kirishda xato yuz berdi: ${error.toString()}');
//   //   }
//   // }
//
//
//   void _showSnackBar(String message, {bool isError = true}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
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
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthLoading) {
//             showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)));
//           } else if (state is AuthAuthenticated) {
//             Navigator.pop(context); // Dialogni yopish
//             _showSnackBar('Muvaffaqiyatli tizimga kirdingiz!', isError: false);
//             context.go(AppRoutes.home);
//           } else if (state is AuthFailure) {
//             Navigator.pop(context); // Dialogni yopish
//             _showSnackBar(state.error, isError: true);
//           }
//         },
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: ClipPath(
//                 clipper: CurvedBackgroundClipper(), // Bu yerda CustomBackgroundClipper ham o'zingizning to'g'ri yo'lidan import qilinishi kerak
//                 child: Container(
//                   height: screenHeight * 0.45,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xFFEA3B7A),
//                         Color(0xFFC7006F),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: screenHeight * 0.35,
//               left: 0,
//               right: 0,
//               height: screenHeight * 0.65 + 100,
//               child: Container(
//                 color: const Color(0xFF2E2E5B),
//               ),
//             ),
//             SafeArea(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: screenHeight * 0.1),
//                     const Text(
//                       "Xush kelibsiz!",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "O'quv platformasiga kirish uchun quyida elektron pochtangiz va parolingizni kiriting",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     // LoginForm ni o'zgaruvchilarni uzatish
//                     _buildEmailPasswordField(
//                       emailController: _emailController,
//                       passwordController: _passwordController,
//                       obscureText: _isPasswordVisible,
//                       onToggleObscureText: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                       onForgotPassword: () {
//                         context.go(AppRoutes.phoneNumber);
//                       },
//                     ),
//                     const SizedBox(height: 24),
//
//                     // Quyidagilar orqali kirish qismi olib tashlandi
//                     // const Row(
//                     //   children: [
//                     //     Expanded(
//                     //       child: Divider(
//                     //         color: Colors.white30,
//                     //         thickness: 1,
//                     //       ),
//                     //     ),
//                     //     Padding(
//                     //       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     //       child: Text(
//                     //         "Quyidagilar orqali kirish",
//                     //         style: TextStyle(color: Colors.white70),
//                     //       ),
//                     //     ),
//                     //     Expanded(
//                     //       child: Divider(
//                     //         color: Colors.white30,
//                     //         thickness: 1,
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     // const SizedBox(height: 24),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     Expanded(
//                     //       child: SocialLoginButton(
//                     //         iconPath: 'assets/icons/google.svg',
//                     //         text: 'Google',
//                     //         onPressed: _handleGoogleSignIn,
//                     //       ),
//                     //     ),
//                     //     const SizedBox(width: 16),
//                     //     Expanded(
//                     //       child: SocialLoginButton(
//                     //         iconPath: 'assets/icons/apple.svg',
//                     //         text: 'Apple',
//                     //         onPressed: () {
//                     //           print('Apple bilan kirish');
//                     //         },
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     // const SizedBox(height: 24),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: _loginUser,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFEA3B7A),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: BlocBuilder<AuthBloc, AuthState>(
//                           builder: (context, state) {
//                             if (state is AuthLoading) {
//                               return const CircularProgressIndicator(color: Colors.white);
//                             }
//                             return const Text(
//                               "Kirish",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: OutlinedButton(
//                         onPressed: () {
//                           context.go(AppRoutes.register);
//                         },
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: Color(0xFFEA3B7A)),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: const Text(
//                           "Ro'yxatdan o'tish",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFFEA3B7A),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Email va Parol TextFieldlarini o'z ichiga oluvchi widget
//   Widget _buildEmailPasswordField({
//     required TextEditingController emailController,
//     required TextEditingController passwordController,
//     required bool obscureText,
//     required VoidCallback onToggleObscureText,
//     required VoidCallback onForgotPassword,
//   }) {
//     return Column(
//       children: [
//         TextField(
//           controller: emailController,
//           keyboardType: TextInputType.emailAddress,
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             prefixIcon: const Icon(Icons.email, color: Colors.grey),
//             hintText: "Email",
//             hintStyle: const TextStyle(color: Colors.grey),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFEA3B7A)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//           ),
//         ),
//         const SizedBox(height: 16),
//         TextField(
//           controller: passwordController,
//           obscureText: obscureText,
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//             hintText: "Parol",
//             hintStyle: const TextStyle(color: Colors.grey),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 obscureText ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.grey,
//               ),
//               onPressed: onToggleObscureText,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFEA3B7A)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: TextButton(
//             onPressed: onForgotPassword,
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             child: const Text(
//               "Parolni unutdingizmi?",
//               style: TextStyle(color: Color(0xFFEA3B7A), fontSize: 14),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }