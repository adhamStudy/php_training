import 'package:backend_training/componants/custom_snackbar.dart';
import 'package:backend_training/cubits/signup_cubit/signup_cubit.dart';
import 'package:backend_training/cubits/signup_cubit/signup_states.dart';
import 'package:backend_training/views/home_view.dart';
import 'package:backend_training/views/login_view.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static String SignUpViewId = '/signup_view';
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<SignUpCubit, SignupStates>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // for (int i = 0;
              //     i < SignUpCubit.get(context).trainNews.length;
              //     i++) {
              //   print(SignUpCubit.get(context).trainNews[i].title);
              // }
              SignUpCubit.get(context).getNotesofUser78(70);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
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
                      if (!SignUpCubit.get(context).isValidEmail(value!)) {
                        return 'Please enter a valid email address';
                      }
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
                  condition: state is! SignupLoadingState,
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        SignUpCubit.get(context).dioUserSignup(
                          email: emailController.text,
                          password: passwordController.text,
                          username: usernameController.text,
                        );
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  child: const Text('Already have an account? Log in'),
                ),
              ],
            ),
          )),
        );
      },
      listener: (context, state) {
        if (state is SignupSuccessState) {
          if (SignUpCubit.get(context).userState) {
            CustomSnackbar(messageText: 'sign up successfully', isError: false)
                .showCustomSnackbar(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          }
        } else if (state is SignupErrorState) {
          CustomSnackbar(messageText: state.error, isError: true)
              .showCustomSnackbar(context);
        }
      },
    );
  }
}
