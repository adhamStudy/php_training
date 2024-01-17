class NewsModel {
  String? title;
  String? date;
  String? image;

  NewsModel({this.title, this.date, this.image});
  NewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['publishedAt'];
    image = json['urlToImage'];
  }
}
