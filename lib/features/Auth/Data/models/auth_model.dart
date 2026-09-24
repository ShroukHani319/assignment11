import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/entity/user_entity.dart';


@injectable
class AuthModel {
  String? email;
  String? uid;
  String? name;

  AuthModel({this.email, this.uid, this.name});

  factory AuthModel.fromFirebaseUser(User user) {
    return AuthModel(email: user.email, uid: user.uid, name: user.displayName);
  }

  UserEntity toUserEntity() {
    return UserEntity(email: email, uid: uid!);
  }
}