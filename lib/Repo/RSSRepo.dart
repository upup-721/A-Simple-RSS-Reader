import 'package:http/http.dart' as http;

class RSSRepo {
  static final RSSRepo _singleton = RSSRepo._internal();

  factory RSSRepo() {
    return _singleton;
  }

  RSSRepo._internal(); //-----------------------------?

  String htmlString = "";
  Future<http.Response> reqRSSXML(rssUrl) async {
    final resp = await http.get(Uri.parse(rssUrl));
    resp.headers.containsKey(
        "key"); //--------------------------------------------------------?
    return resp;
  }
}
