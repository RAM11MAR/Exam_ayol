// lib/data/models/auth_models.dart

class RegistrationPayload {
  final String firstName;
  final String lastName;
  final String emailAddress; // 'email' o'rniga
  String? phoneNumber;
  String? newPassword; // 'password' o'rniga

  RegistrationPayload({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    this.phoneNumber,
    this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName, // Backend talabiga qarab o'zgarishi mumkin
      'last_name': lastName,
      'email_address': emailAddress,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (newPassword != null) 'password': newPassword, // Backendga password deb yuborish
    };
  }

  RegistrationPayload copyWith({
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? phoneNumber,
    String? newPassword,
  }) {
    return RegistrationPayload(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}

// Login uchun model
class AuthCredentials {
  final String emailOrPhone;
  final String password;

  AuthCredentials({required this.emailOrPhone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'identifier': emailOrPhone, // Backendga moslab o'zgarishi mumkin
      'password': password,
    };
  }
}