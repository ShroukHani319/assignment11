import 'package:injectable/injectable.dart';
import '../entity/user_entity.dart';
import '../repo/auth_repo.dart';


@injectable
class LoginUseCase {
  AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<UserEntity> call(String email, String password) async {
    return authRepo.login(email: email, password: password);
  }
}