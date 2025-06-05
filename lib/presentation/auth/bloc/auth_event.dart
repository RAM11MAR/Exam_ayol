// lib/presentation/auth/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final Map<String, dynamic> credentials;
  const AuthLoginRequested({required this.credentials});

  @override
  List<Object> get props => [credentials];
}

class AuthRegisterRequested extends AuthEvent {
  final Map<String, dynamic> registerData;
  const AuthRegisterRequested({required this.registerData});

  @override
  List<Object> get props => [registerData];
}

class AuthLogoutRequested extends AuthEvent {}