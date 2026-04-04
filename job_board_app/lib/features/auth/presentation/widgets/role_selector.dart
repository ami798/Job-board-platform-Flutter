import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_viewmodel.g.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? user;
  final UserRole selectedRole;

  AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
    this.selectedRole = UserRole.jobSeeker,
  });

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? user,
    UserRole? selectedRole,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() => AuthState();

  void setRole(UserRole role) => state = state.copyWith(selectedRole: role);

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(loginUseCaseProvider).call(email, password);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
        return true;
      },
    );
  }
}
