import 'package:my_first_flutter_app/Parser/IFeedParser.dart';
import 'package:xml/xml.dart';
import 'package:my_first_flutter_app/FeedPage/FeedPageModel.dart';
import 'dart:convert';
import 'dart:math';

class RSSFeedParser implements IFeedParser {
  @override
  FeedPageModel parse(value) {
    final doc = XmlDocument.parse(utf8.decode(value.bodyBytes));
    String title = doc.findAllElements("title").first.innerText;
    List<ArticleModel> articles = cellModelParser(doc.findAllElements("item"));
    return FeedPageModel(title, articles);
  }

  List<ArticleModel> cellModelParser(Iterable<XmlElement> elements) {
    List<ArticleModel> cellModelList = [];
    for (XmlElement element in elements) {
      cellModelList.add(ArticleModel(
          element.findElements("title").first.innerText,
          _removeAllHtmlTags(
              element.findAllElements("description").first.innerText),
          "https://random.imagecdn.app/200/${200 + Random().nextInt(300 - 200)}",
          element.findElements("link").first.innerText,
          element.findAllElements("content").first.innerText));
    }
    return cellModelList;
  }

  String _removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r'<[^>]*>|&[^;]+;', //---------[^>]表示除>外的所有其他字符，*表示0个或多个， |是匹配左边或右边
        multiLine: true,
        caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
