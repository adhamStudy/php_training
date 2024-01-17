

class SignUpModel {
  String? message;
  SignUpModel({
    this.message,
  });

  SignUpModel.fromJson(Map<String, dynamic> json)
    {
      message = json['message'];
    }
}
