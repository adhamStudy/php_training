class NoteModel {
  String? title;
  String? body;
  int ?userId;
  NoteModel({this.title, this.body, this.userId});
  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
  }
}
