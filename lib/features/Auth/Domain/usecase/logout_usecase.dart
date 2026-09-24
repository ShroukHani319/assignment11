import 'package:injectable/injectable.dart';

import '../repo/auth_repo.dart';

@injectable
class LogoutUseCase {
  AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  Future<void> call() async {
    return authRepo.logout();
  }
}