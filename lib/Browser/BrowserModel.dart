// import 'package:my_first_flutter_app/Parser/IFeedParser.dart';

import '../Cell/CellViewModel.dart';

class ArticleBrowserModel {
  String imageUrl = "";
  String title = "";
  String descText = "";
  String link = "";
  String htmlString = "";

  ArticleBrowserModel(ArticleCellViewModel model) {
    imageUrl = model.imageUrl;
    title = model.title;
    descText = model.descText;
    link = model.link;
    htmlString = model.htmlString;
  }
}
