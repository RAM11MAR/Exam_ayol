// lib/main.dart
import 'package:exam1/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // SystemChrome uchun
import 'core/go_route/router.dart'; // Yangi AuthBloc

void main() {
  // StatusBar rangini o'zgartirishni bu yerda o'rnatish
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Shaffof status bar
    statusBarIconBrightness: Brightness.light, // Status bar icon rangini yorug' qilish
    statusBarBrightness: Brightness.dark, // iOS uchun
  ));
  runApp(const FemEduApp());
}

class FemEduApp extends StatelessWidget {
  const FemEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(), // AuthBloc ni yaratish
        ),
        // Boshqa BlocProviderlar shu yerda qo'shiladi
      ],
      child: MaterialApp.router(
        title: 'Ayol Uchun Ilm', // Ilova nomi
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink, // Asosiy ranglar
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Boshqa umumiy tema sozlamalari
        ),
        routerConfig: AppRouter.goRouter, // GoRouter ni ulash
      ),
    );
  }
}