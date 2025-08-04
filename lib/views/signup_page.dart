import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginwithjwt/bloc/todo_bloc.dart';
import 'package:loginwithjwt/bloc/todo_event.dart';
import 'package:loginwithjwt/bloc/todo_state.dart';
import 'package:loginwithjwt/views/login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state.signupSuccess == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(SignUpEvent(account: _emailController.text, password: _passwordController.text));
              },
               child: Text("Signup"),
               ),
          ],
        ),
      ),
    );
  }
}
