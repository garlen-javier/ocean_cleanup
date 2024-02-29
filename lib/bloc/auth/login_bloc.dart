import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final String? error;

  const LoginState({this.status = LoginStatus.initial, this.error});
}

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(const LoginState());

  Future<void> login(
      {required String username, required String password}) async {
    emit(const LoginState(status: LoginStatus.loading));
    try {
      print('login $username $password');
      emit(const LoginState(status: LoginStatus.success));
    } catch (e) {
      emit(
          const LoginState(status: LoginStatus.failure, error: 'Login failed'));
    }
  }
}
