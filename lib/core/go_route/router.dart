import 'package:exam1/core/go_route/routes.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/auth_models.dart';
import '../../presentation/auth/pages/otp_verification_page.dart';
import '../../presentation/auth/pages/password_creation_page.dart';
import '../../presentation/auth/pages/phone_input_page.dart';
import '../../presentation/auth/pages/sign_in_screen.dart';
import '../../presentation/auth/pages/sign_up_page.dart';
import '../../presentation/home/pages/main_dashboard.dart';
import '../../presentation/splash/splash_screen.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: AppPaths.introFlow, // Splash o'rniga to'g'ridan-to'g'ri intro (splash)
    routes: [
      GoRoute(
        path: AppPaths.initialRoute, // Splash screen
        builder: (context, state) => const AppSplashScreen(),
      ),
      GoRoute(
        path: AppPaths.introFlow, // Onboarding bo'lishi mumkin
        builder: (context, state) => const AppSplashScreen(), // Hozircha Splash, keyin OnboardingScreen bo'ladi
      ),
      GoRoute(
        path: AppPaths.userSignIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppPaths.userSignUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppPaths.providePhoneNumber,
        builder: (context, state) {
          final RegistrationPayload? payload = state.extra as RegistrationPayload?;
          return PhoneInputScreen(registrationPayload: payload);
        },
      ),
      GoRoute(
        path: AppPaths.verifyOtpCode,
        builder: (context, state) {
          final RegistrationPayload? payload = state.extra as RegistrationPayload?;
          return OtpVerificationScreen(registrationPayload: payload);
        },
      ),
      GoRoute(
        path: AppPaths.createNewPassword,
        builder: (context, state) {
          final RegistrationPayload? payload = state.extra as RegistrationPayload?;
          return PasswordCreationScreen(registrationPayload: payload);
        },
      ),
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) =>  HomePage(),
      ),
    ],
  );
}