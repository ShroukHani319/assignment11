import '../../Domain/entity/user_entity.dart';
import '../../Domain/repo/auth_repo.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRemoteDataSource authRemoteDataSource;

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
    final credintials = await authRemoteDataSource.register(
      email: email,
      password: password,
    );
    return credintials.toUserEntity();
  }
}