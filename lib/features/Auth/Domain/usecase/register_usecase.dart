import 'package:injectable/injectable.dart';
import '../entity/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  Future<UserEntity> call(String email, String password) async {
    return authRepo.register(email: email, password: password);
  }
}