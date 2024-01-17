abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {}

class SignupErrorState extends SignupStates {
  final String error;

  SignupErrorState(this.error);
}

class GetNotesState extends SignupStates {}

class NotesLoadingState78 extends SignupStates {}

class NotesSuccessState78 extends SignupStates {


  
}
class NotesErrorState78 extends SignupStates {
  final String error;
  NotesErrorState78(this.error) {
    print(error);
  }
}
