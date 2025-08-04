import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginwithjwt/bloc/todo_bloc.dart';
import 'package:loginwithjwt/views/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TodoBloc(), child: MaterialApp(home: SignupPage(),),);
  }
}