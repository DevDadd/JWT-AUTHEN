// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  const TodoState({
    this.isLoading = false, 
    this.isLoggedIn = false, 
    this.signupSuccess = false,
    this.error
  });
  final bool isLoading;
  final bool isLoggedIn;
  final bool signupSuccess;
  final String? error;

  @override
  List<Object?> get props => [isLoading, isLoggedIn, signupSuccess, error];

  TodoState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? signupSuccess,
    String? error,
  }) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      signupSuccess: signupSuccess ?? this.signupSuccess,
      error: error ?? this.error,
    );
  }
}

