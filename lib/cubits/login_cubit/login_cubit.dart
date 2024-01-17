import 'package:backend_training/constants.dart';
import 'package:backend_training/cubits/login_cubit/login_states.dart';
import 'package:backend_training/main.dart';
import 'package:backend_training/models/user_model.dart';
import 'package:backend_training/services/http_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {


  LoginCubit() : super(LoginInitialState());
  bool userState = false;

  static LoginCubit get(context) => BlocProvider.of(context);
  String linkServer = "http://10.0.2.2:8080/second/auth/login.php";
  void Login(String email, String password) {
    emit(LoginLoadingState());

    HttpHelper.postRequest(linkServer, {'email': email, 'password': password})
        .then((value) {
      print(value);
      userState = value['userState'];
      if (userState) {
          userModel = UserModel.fromJson(value['userData']);
        myBox!.put('UserModel', userModel);
        myBox!.put('id', userModel.id);
      
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(value['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
