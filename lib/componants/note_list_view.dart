import 'package:backend_training/componants/note_item.dart';
import 'package:backend_training/cubits/notes_cubit/notes_cubit.dart';
import 'package:backend_training/cubits/notes_cubit/notes_states.dart';
import 'package:backend_training/models/note_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteListView extends StatelessWidget {
  NoteListView(this.notes);
  List<NoteModel> notes;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! NotesLoadingState,
          builder: (context) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return NoteItem(noteModel: notes[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  );
                },
                itemCount: notes.length);
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
