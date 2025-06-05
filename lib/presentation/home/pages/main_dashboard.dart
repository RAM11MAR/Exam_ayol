// lib/presentation/home/pages/main_dashboard.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/go_route/routes.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';


class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayol Uchun Ilm', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFEA3B7A),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
              context.go(AppPaths.userSignIn); // Logoutdan keyin login sahifasiga
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Xush kelibsiz! Bu bosh sahifa.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Misol: boshqa sahifaga o'tish
                // context.go('/some-other-feature');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Xususiyatlar tez orada qo\'shiladi!')),
                );
              },
              child: const Text('Boshlash'),
            ),
          ],
        ),
      ),
    );
  }
}