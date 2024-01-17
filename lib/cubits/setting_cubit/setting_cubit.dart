import 'package:backend_training/constants.dart';
import 'package:backend_training/cubits/setting_cubit/setting_state.dart';
import 'package:backend_training/main.dart';
import 'package:backend_training/models/user_model.dart';
import 'package:backend_training/services/http_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingInitialState());

  static SettingCubit get(context) => BlocProvider.of(context);
  bool userState = false;
  String linkServer = "http://10.0.2.2:8080/second/auth/update.php";
  void updateUserData(String username, String id) {
    emit(SettingLoadingState());
    HttpHelper.postRequest(linkServer, {'username': username, 'id': id})
        .then((value) {
      print(value);
      
      userState = value['userState'];
      if (userState) {
        userModel = UserModel.fromJson(value['userData']);
        myBox!.put('UserModel', userModel);
        emit(SettingSuccessState());
      } else {
        emit(SettingErrorState('couldnt sing up'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(SettingErrorState(error.toString()));
    });
  }

  void logout() {
    emit(SettingLogoutState());
    userModel = UserModel();
    //clear vlaues of mybox
    myBox!.clear();


  }
}
