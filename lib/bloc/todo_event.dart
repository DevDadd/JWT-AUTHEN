
import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}
class SignUpEvent extends TodoEvent{
  final String account;
  final String password;

  const SignUpEvent({required this.account, required this.password});
}

class LoginEvent extends TodoEvent{
  final String account;
  final String password;

  const LoginEvent({required this.account, required this.password});
}