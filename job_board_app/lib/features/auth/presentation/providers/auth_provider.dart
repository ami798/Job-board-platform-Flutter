// lib/features/auth/presentation/providers/auth_provider.dart
@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => AuthState.initial();

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(loginUseCaseProvider).call(email, password);

    result.fold(
      (failure) =>
          state = state.copyWith(error: failure.message, isLoading: false),
      (user) => state = state.copyWith(user: user, isLoading: false),
    );
  }
}
