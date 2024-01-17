import 'package:backend_training/cubits/login_cubit/login_cubit.dart';
import 'package:backend_training/cubits/login_cubit/login_states.dart';
import 'package:backend_training/views/home_view.dart';
import 'package:backend_training/views/signup_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView();
  static String LoginViewId = '/login_view';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (LoginCubit.get(context).userState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Success'),
                backgroundColor: Color.fromARGB(255, 4, 216, 15)),
            );
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          }
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Log In'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Log In',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        // if (!isValidEmail(value!)) {
                        //   return 'Please enter a valid email address';
                        // }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  const SizedBox(height: 20),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (context) => ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          LoginCubit.get(context).Login(
                              emailController.text, passwordController.text);
                        }
                      },
                      child: const Text('Log In'),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpView()));
                    },
                    child: const Text('Don\'t have an account? Sign up'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
