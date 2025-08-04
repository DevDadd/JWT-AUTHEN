import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginwithjwt/bloc/todo_bloc.dart';
import 'package:loginwithjwt/bloc/todo_event.dart';
import 'package:loginwithjwt/bloc/todo_state.dart';
import 'package:loginwithjwt/views/success_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state.isLoggedIn == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessPage()),
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
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(LoginEvent(account: _emailController.text, password: _passwordController.text));
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
