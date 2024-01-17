abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class NotesSuccessState extends NotesStates {}

class NotesErrorState extends NotesStates {
  final String error;
  NotesErrorState(this.error) {
    print(error);
  }
  
}

class NoteAddSucessState extends NotesStates{}
class NoteAddLoadingState extends NotesStates{}
class NoteAddErrorState extends NotesStates{}
