// lib/data/models/register_model.dart

class RegisterModel {
  final String firstName;
  final String lastName;
  final String email;
  String? phoneNumber; // <--- Bu yerda null bo'lishi mumkin
  String? password;    // <--- Bu yerda null bo'lishi mumkin

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber, // Konstruktorda ham qabul qiling
    this.password,    // Konstruktorda ham qabul qiling
  });

  // Bu toJson() metodi to'liq ma'lumotlarni qaytarishi kerak
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber, // Agar mavjud bo'lsa qo'shish
      if (password != null) 'password': password,        // Agar mavjud bo'lsa qo'shish
    };
  }

  // Ma'lumotlarni yangilash uchun copyWith metodi
  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return RegisterModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}