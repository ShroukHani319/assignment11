import 'package:injectable/injectable.dart';

import '../../Domain/entity/user_entity.dart';
import '../../Domain/repo/auth_repo.dart';
import '../data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await authRemoteDataSource.login(
      email: email,
      password: password,
    );

    return credential.toUserEntity();
  }

  @override
  Future<void> logout() {
    return authRemoteDataSource.logout();
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
  }) async {
    final credentials = await authRemoteDataSource.register(
      email: email,
      password: password,
    );

    return credentials.toUserEntity();
  }
}