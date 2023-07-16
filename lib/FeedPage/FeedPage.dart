import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/Parser/AtomFeedParser.dart';
import 'package:my_first_flutter_app/Parser/RSSFeedParser.dart';
import 'package:my_first_flutter_app/Repo/RSSRepo.dart';
import 'package:my_first_flutter_app/Cell/CellView.dart';
import 'package:my_first_flutter_app/Cell/CellViewModel.dart';
import 'package:xml/xml.dart';
import 'package:my_first_flutter_app/Parser/IFeedParser.dart';
import 'package:my_first_flutter_app/FeedPage/FeedPageModel.dart';

class RSSFeedPage extends StatefulWidget {
  const RSSFeedPage({super.key, required this.title});
  final String title;

  @override
  State<RSSFeedPage> createState() => _RSSFeedPageState();
}

class _RSSFeedPageState extends State<RSSFeedPage> {
  FeedPageModel? pageModel;

  List<String> urls = [
    "http://yulingtianxia.com/atom.xml",
    "https://www.haijiaoshi.com/feed",
    "https://www.williamlong.info/rss.xml"
  ];
  int currentUrlIndex = 0;

  @override
  void initState() {
    super.initState();
    reloadData();
  }

  void reloadData() {
    IFeedParser parser;
    RSSRepo().reqRSSXML(urls[currentUrlIndex]).then((value) {
      final doc = XmlDocument.parse(utf8.decode(value.bodyBytes));
      // 这个判断很搓， 你改一下
      String type = "";
      if (doc.findAllElements("feed").isNotEmpty) {
        type = doc.findAllElements("feed").first.innerText;
      }
      if (type.isEmpty) {
        // rss
        parser = RSSFeedParser();
      } else {
        //atom
        parser = AtomFeedParser();
      }
      pageModel = parser.parse(value);
      setState(() {}); //---------------------------------------------?
    });
  }

  AppBar navBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(pageModel?.pageTitle ?? "Loading..."),
      actions: [
        ElevatedButton(
          onPressed: () {
            currentUrlIndex += 1;
            currentUrlIndex %= urls.length;
            pageModel = null;
            reloadData();
            //show modal
          },
          child: const Icon(Icons.rss_feed_rounded),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navBar(),
      body: Container(
          color: Colors.white,
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: ListView.builder(
            itemCount: pageModel?.articles.length ?? 0,
            itemExtent: 120,
            itemBuilder: (BuildContext context, int index) {
              if (pageModel?.articles != null) {
                return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                    child: ArticleCellView(ArticleCellViewModel(
                            pageModel!.articles[
                                index]) //------List<ArticleModel> articles
                        ));
              }
              return null;
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          )),
    );
  }
}
