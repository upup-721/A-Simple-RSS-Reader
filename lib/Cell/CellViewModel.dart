import 'package:my_first_flutter_app/Parser/IFeedParser.dart';

class ArticleCellViewModel {
  String imageUrl = "";
  String title = "";
  String descText = "";
  String link = "";
  String htmlString = "";
  double imageWidth = 100;
  double imageHeight = 100;
  double cellHeight = 110;

  ArticleCellViewModel(ArticleModel model) {
    imageUrl = model.imgUrl;
    title = model.title;
    descText = model.desc;
    link = model.link;
    htmlString = model.htmlString;
  }

  // onTapAction(BuildContext context, ArticleModel model) {
  //   print(link);
  //   Future.delayed(Duration.zero, () {
  //     Navigator.push(context, MaterialPageRoute(builder: (_) {
  //       return ArticleBrowser(browserModel: ArticleBrowserModel(model));
  //     }));
  //   });
  // }
}
