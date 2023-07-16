import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'BrowserModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleBrowser extends StatefulWidget {
  const ArticleBrowser({super.key, required this.browserModel});
  final ArticleBrowserModel browserModel;

  @override
  State<ArticleBrowser> createState() => _ArticleBrowserState();
}

class _ArticleBrowserState extends State<ArticleBrowser> {
  late final WebViewController controller;
  late ArticleBrowserModel browserModel;

  double height = 0;

  @override
  void initState() {
    browserModel = widget.browserModel;

    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadHtmlString(htmlStr);

    super.initState();
  }

  Widget titleSection(String title) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                const Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Color.fromARGB(255, 134, 132, 132),
                  ),
                ),
              ],
            ),
          ),
          // /*3*/
          // Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // const Text('41'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String htmlStr = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          ${browserModel.htmlString}
        </div>
      </body>
    </html>""";

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Flutter layout demo'),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 255, 243, 234),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x22000000),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ]),
        child: Column(children: [
          titleSection(browserModel.title),
          // Expanded(child: WebViewWidget(controller: controller)),
          //------------------------------------------------------------------------

          Expanded(
              child: SingleChildScrollView(
            child: Html(
              data: htmlStr,
              extensions: [
                TagExtension(
                  tagsToExtend: {"flutter"},
                  child: const FlutterLogo(),
                ),
              ],
              style: {
                "div": Style(
                  display: Display.block,
                  // backgroundColor: Color.fromARGB(255, 214, 209, 205),
                ),
                "h2": Style(
                    fontFamily: 'serif',
                    // backgroundColor: Colors.black,
                    color: Color.fromARGB(255, 36, 41, 82),
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.xxLarge),
                "p": Style(
                    // textAlign: TextAlign.center,
                    // // backgroundColor: Color.fromARGB(255, 236, 229, 229),
                    margin: Margins(left: Margin.auto(), right: Margin.auto()),
                    width: Width(350, Unit.px),
                    fontFamily: 'FangSong',
                    fontSize: FontSize.xLarge),
                "p > a": Style(
                  textDecoration: TextDecoration.none,
                ),
                "figure": Style(
                    // border: Borderborder
                    )
              },
            ),
          ))
        ]),
      ),
    ));
  }
}


// """
//           <h1>Hello, World!</h1>
//           <p><span style="font-style:italic;">flutter_html</span> supports a variety of HTML and CSS tags and attributes.</p>
//           <p>Over a hundred static tags are supported out of the box.</p>
//           <p>Or you can even define your own using an <code>Extension</code>: <flutter></flutter></p>
//           <p>Its easy to add custom styles to your Html as well using the <code>Style</code> class:</p>
//           <p class="fancy">Here's a fancy &lt;p&gt; element!</p>
//           """