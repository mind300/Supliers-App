import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplies/feature/password_feature/data/repo/change_pass_repoImpl.dart';
import 'change_pass_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePassRepoImpl authRepository;

  ChangePasswordCubit(this.authRepository) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await authRepository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
          (failure) => emit(ChangePasswordFailure(failure)),
          (_) => emit(ChangePasswordSuccess()),
    );
  }
}
