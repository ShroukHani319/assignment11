import '../../Domain/entity/user_entity.dart';

abstract class AuthState {}

class AuthInial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  UserEntity user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  String? errorMessage;
  AuthError(this.errorMessage);
}