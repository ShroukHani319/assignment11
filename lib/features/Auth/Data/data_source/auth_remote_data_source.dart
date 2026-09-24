import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_model.dart';

@injectable
class AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;
  AuthRemoteDataSource(this.firebaseAuth);

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthModel.fromFirebaseUser(credential.user!);
  }

  Future<AuthModel> register({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthModel.fromFirebaseUser(credential.user!);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}