class TrainNewsModel {
  String? title;
  String? image;
  String? date;

  TrainNewsModel(this.title, this.image, this.date);

  TrainNewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['urlToImage'];
    date = json['urlToImage'];
  }
}
