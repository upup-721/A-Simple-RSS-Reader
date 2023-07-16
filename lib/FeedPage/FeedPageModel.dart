import 'package:my_first_flutter_app/Parser/IFeedParser.dart';
class FeedPageModel {
  String pageTitle = "";
  List<ArticleModel> articles;
  FeedPageModel(this.pageTitle, this.articles);
}
