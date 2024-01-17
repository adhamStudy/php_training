import 'package:backend_training/componants/note_list_view.dart';
import 'package:backend_training/cubits/notes_cubit/notes_cubit.dart';
import 'package:backend_training/cubits/notes_cubit/notes_states.dart';
import 'package:backend_training/cubits/setting_cubit/setting_cubit.dart';
import 'package:backend_training/cubits/setting_cubit/setting_state.dart';
import 'package:backend_training/views/login_view.dart';
import 'package:backend_training/views/settings_view.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView();
  static String HomeViewId = '/home_view';
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..getNotesDio(78),
      child: BlocConsumer<NotesCubit, NotesStates>(
        listener: (context, state) {
          if (state is NotesSuccessState) {
            for (int i = 0; i < NotesCubit.get(context).notes.length; i++) {
              print(NotesCubit.get(context).notes[i].title);
            }
          }
          if (state is NoteAddSucessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                //make the scaffoldMessenger on top of the screen
                behavior: SnackBarBehavior.floating,

                duration: const Duration(seconds: 2),
                content: Text('Note added successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is NoteAddErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                //make the scaffoldMessenger on top of the screen
                behavior: SnackBarBehavior.floating,

                duration: const Duration(seconds: 2),
                content: Text('Failed add Note '),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
     
      return BlocConsumer<SettingCubit, SettingStates>(
            listener: (context, state) {
              if (state is SettingLogoutState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    //make the scaffoldMessenger on top of the screen
                    behavior: SnackBarBehavior.floating,

                    duration: const Duration(seconds: 2),
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingView()),
                        );
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    IconButton(
                      onPressed: () {
                        SettingCubit.get(context).logout();
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                body: NoteListView(NotesCubit.get(context).notes),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                 // push the add note screen
                    Navigator.pushNamed(context, '/add_note_view');
                    

                   
                  },
                  child: Icon(Icons.add),
                ),
              );
            },
          );
        },
      ),
    );
  }

 }
