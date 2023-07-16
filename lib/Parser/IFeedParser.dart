import 'package:my_first_flutter_app/FeedPage/FeedPageModel.dart';

class FeedModel {
  String title = "";
  String link = "";
  List<ArticleModel>? articles;
}

class ArticleModel {
  String title = "";
  String desc = "";
  String imgUrl = "";
  String link = "";
  String htmlString = "";
  ArticleModel(this.title, this.desc, this.imgUrl, this.link, this.htmlString);
}

abstract interface class IFeedParser {
  FeedPageModel parse(value);
}
