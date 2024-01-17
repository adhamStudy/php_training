import 'package:backend_training/cubits/notes_cubit/notes_cubit.dart';
import 'package:backend_training/cubits/notes_cubit/notes_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  static String AddNoteScreenId = '/add_note_view';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Note'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _bodyController,
                  decoration: InputDecoration(labelText: 'Body'),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Dispatch an event to add the note
                    NotesCubit.get(context).addNote(
                      title: _titleController.text,
                      body: _bodyController.text,
                    );
                    // Pop the screen
                    Navigator.of(context).pop();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
