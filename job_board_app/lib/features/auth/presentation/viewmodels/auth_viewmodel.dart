// lib/features/auth/presentation/viewmodels/auth_viewmodel.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

// Base URL is placeholder, change to real backend URL in production.
const _kBaseUrl = 'https://your-backend.com';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: _kBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
});

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(dio: ref.read(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDatasource: ref.read(authRemoteDatasourceProvider),
    secureStorage: const FlutterSecureStorage(),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

final registerUseCaseProvider = Provider<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

// TODO: Add global AuthState provider in the shared root for reactive auth guards and token refresh.
final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);

class AuthState {
  final bool isLoading;
  final String? error;
  final User? user;
  final UserRole selectedRole;

  AuthState({
    required this.isLoading,
    this.error,
    this.user,
    required this.selectedRole,
  });

  factory AuthState.initial() => AuthState(
    isLoading: false,
    error: null,
    user: null,
    selectedRole: UserRole.jobSeeker,
  );

  AuthState copyWith({
    bool? isLoading,
    String? error,
    User? user,
    UserRole? selectedRole,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState.initial();

  void setRole(UserRole role) {
    state = state.copyWith(selectedRole: role, error: null);
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'Email and password are required.',
      );
      return;
    }

    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+");
    if (!emailRegex.hasMatch(email)) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please enter a valid email.',
      );
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        isLoading: false,
        error: 'Password must be at least 6 characters long.',
      );
      return;
    }

    try {
      final user = await ref.read(loginUseCaseProvider).call(email, password);
      state = state.copyWith(user: user, isLoading: false, error: null);

      // Navigate according to role.
      if (user.role == UserRole.employer) {
        context.go('/admin/dashboard');
      } else {
        context.go('/home');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'All fields are required.',
      );
      return;
    }

    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+");
    if (!emailRegex.hasMatch(email)) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please enter a valid email.',
      );
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        isLoading: false,
        error: 'Password must be at least 6 characters long.',
      );
      return;
    }

    try {
      final user = await ref
          .read(registerUseCaseProvider)
          .call(name, email, password, role.value);
      state = state.copyWith(user: user, isLoading: false, error: null);

      // Registration success: go to login as required.
      context.go('/auth/login');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
