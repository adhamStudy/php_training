import 'package:backend_training/constants.dart';
import 'package:backend_training/cubits/signup_cubit/signup_states.dart';
import 'package:backend_training/main.dart';

import 'package:backend_training/models/user_model.dart';
import 'package:backend_training/services/dio_helper.dart';
import 'package:backend_training/services/http_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignupStates> {
  SignUpCubit() : super(SignupInitialState());

  String linkServer = "http://10.0.2.2:8080/second/auth/signup.php";
  String linkNotes =  "http://10.0.2.2:8080/second/notes/view.php";
  
  bool isValidEmail(String email) {
    final emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  static SignUpCubit get(context) => BlocProvider.of(context);
  bool userState = false;

  httpSignUserUp({
    context,
    required String email,
    required String password,
    required String username,
  }) {
    emit(SignupLoadingState());
    //add 2 seconds delay in one line
    Future.delayed(const Duration(seconds: 2), () {});

    HttpHelper.postRequest(linkServer, {
      'username': username,
      'email': email,
      'password': password
    }).then((value) {
      print(value);
      userState = value['userState'];
      if (userState) {
        userModel = UserModel.fromJson(value['userData']);
        myBox!.put('UserModel', userModel);
        myBox!.put('id', userModel.id);
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState(value['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(SignupErrorState(error.toString()));
    });
  }

  void dioUserSignup(
      {required String email,
      required String password,
      required String username}) {
    emit(SignupLoadingState());
    DioHelper.postData(
            url: 'second/auth/signup.php',
            data: {'username': username, 'email': email, 'password': password})
        .then((value) {
      print(value);
      userState = value['userState'];
      if (userState) {
        userModel = UserModel.fromJson(value['userData']);
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState(value['message']));
      }
    }).catchError((e) {
      print(e.toString());
      emit(SignupErrorState(e.toString()));
    });
  }





  void getNotesofUser78(int userId) {
    emit(NotesLoadingState78());
    HttpHelper.postRequest(linkNotes,
    {
      'id': 78,
    
    }).then((value) {
      if (value['userState']) {
        print(value['userData']);
        emit(NotesSuccessState78());
      } else {
        emit(NotesErrorState78(value['message']));
      }
      emit(NotesSuccessState78());
    }).catchError((onError) {
      emit(NotesErrorState78(onError.toString()));
      print(onError.toString());
    });
  }
}
