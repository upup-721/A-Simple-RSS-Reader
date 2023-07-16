import 'package:flutter/material.dart';
import '../Browser/Browser.dart';
import '../Browser/BrowserModel.dart';
import 'CellViewModel.dart';

class ArticleCellView extends StatelessWidget {
  ArticleCellViewModel viewModel;

  ArticleCellView(this.viewModel);

  Widget _imageView(String imageUrl) {
    return Container(
      width: viewModel.imageWidth,
      height: viewModel.imageHeight,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _textAreaView() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleView(viewModel.title),
          _descTextView(viewModel.descText)
        ],
      ),
    );
  }

  Widget _titleView(String title) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 15),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _descTextView(String descTitle) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Text(descTitle,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          maxLines: 3,
          overflow: TextOverflow.ellipsis),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(viewModel.link);
        Future.delayed(Duration.zero, () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ArticleBrowser(browserModel: ArticleBrowserModel(viewModel));
          }));
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: viewModel.cellHeight,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x22000000),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_imageView(viewModel.imageUrl), _textAreaView()],
        ),
      ),
    );
  }
}
