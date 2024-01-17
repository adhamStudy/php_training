
import 'package:backend_training/cubits/setting_cubit/setting_cubit.dart';
import 'package:backend_training/cubits/setting_cubit/setting_state.dart';
import 'package:backend_training/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingView extends StatelessWidget {
  SettingView();
  static String SettingViewId = '/setting_view';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingStates>(
      listener: (context, state) {
        if (state is SettingSuccessState) {
          if (SettingCubit.get(context).userState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text('Name updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        } else if (state is SettingErrorState) {
          // Show error message
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Setting'),
          ),
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Setting',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: '         New Name:',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        SettingCubit.get(context)
                            .updateUserData(username.text, myBox!.get('id'));
                      }
                    },
                    child: const Text('Save'),
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
