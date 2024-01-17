import 'dart:convert';

import 'package:backend_training/cubits/notes_cubit/notes_states.dart';
import 'package:backend_training/main.dart';
import 'package:backend_training/models/note_model.dart';
import 'package:backend_training/services/dio_helper.dart';
import 'package:backend_training/services/http_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());
  static NotesCubit get(context) => BlocProvider.of(context);
  bool userState = false;
  bool addState = false;
  List<NoteModel> notes = [];
  List<dynamic> temp = [];
  String linkServer = "http://10.0.2.2:8080/second/notes/view_data.php";
  void getNotes(int id) async {
    print('*************************** test start the method');
    emit(NotesLoadingState());
    await HttpHelper.postRequest(linkServer, {"id": 78}).then((value) {
      print('*************************** test if the data come successfully');
      value = JsonDecoder().convert(value);

      userState = value['userState'];
      if (userState) {
        print(value['userData']);
        notes = [];
        value['userData'].map((e) {
          notes.add(NoteModel.fromJson(e));
        }).toList();
        emit(NotesSuccessState());
      } else {
        emit(NotesErrorState('couldnt get notes'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NotesErrorState(error.toString()));
    });
  }

  void getNotesDio(int id) {
    emit(NotesLoadingState());
    DioHelper.postData(url: 'second/notes/view_data.php', data: {
      'id': id,
    }).then((value) {
      userState = value['userState'];
      if (userState) {
        temp = value['userData'];
        temp.map((e) {
          notes.add(NoteModel.fromJson(e));
        }).toList();
        emit(NotesSuccessState());
      } else {
        emit(NotesErrorState('couldnt get notes'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NotesErrorState(error.toString()));
    });
  }

  void addNote({required String title, required String body}) {
    emit(NoteAddLoadingState());
    HttpHelper.postRequest('http://10.0.2.2:8080/second/notes/add.php', {
      'title': title,
      'body': body,
      'id': myBox!.get('id'),
    }).then((value) {
      addState = value['userState'];
      if (addState) {
        temp = value['userData'];
        notes = [];
        temp.map((e) {
          notes.add(NoteModel.fromJson(e));
        }).toList();
        emit(NotesSuccessState());
        getNotesDio(myBox!.get('id'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NoteAddErrorState());
    });
  }
  }
