import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/usecase/login_usecase.dart';
import '../../Domain/usecase/logout_usecase.dart';
import '../../Domain/usecase/register_usecase.dart';
import 'auth_state.dart';


@injectable
class AuthCubit extends Cubit<AuthState> {
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  LogoutUseCase logoutUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase, this.logoutUseCase)
      : super(AuthInial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.call(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.call(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutUseCase.call();
    emit(AuthInial());
  }
}