import 'package:my_first_flutter_app/Parser/IFeedParser.dart';
import 'package:xml/xml.dart';
import 'package:my_first_flutter_app/FeedPage/FeedPageModel.dart';
import 'dart:convert';
import 'dart:math';

class AtomFeedParser implements IFeedParser {
  @override
  FeedPageModel parse(value) {
    final doc = XmlDocument.parse(utf8.decode(value.bodyBytes));
    String title = doc.findAllElements("title").first.innerText;
    List<ArticleModel> articles = cellModelParser(doc.findAllElements("entry"));
    return FeedPageModel(title, articles);
  }

  List<ArticleModel> cellModelParser(Iterable<XmlElement> elements) {
    List<ArticleModel> cellModelList = [];
    for (XmlElement element in elements) {
      //---------------------------------------------ArticleModel(this.title, this.desc, this.imgUrl, this.link);
      cellModelList.add(ArticleModel(
          element.findElements("title").first.innerText,
          _removeAllHtmlTags(
              element.findAllElements("content").first.innerText),
          "https://random.imagecdn.app/200/${200 + Random().nextInt(300 - 200)}",
          element.findElements("link").first.innerText,
          element.findAllElements("content").first.innerText));
    }
    return cellModelList;
  }

  String _removeAllHtmlTags(String htmlText) {
    RegExp exp =
        RegExp(r'<[^>]*>|&[^;]+;', multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
