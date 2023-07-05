import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

class AddRssDialog extends StatefulWidget {
  const AddRssDialog({super.key});

  @override
  _AddRssDialogState createState() => _AddRssDialogState();
}

class _AddRssDialogState extends State<AddRssDialog> {
  String input = "";

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('addRss'),
      content: SizedBox(
        height: 90,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Text(
                    'paste',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  onTap: () async {
                    //TODO
                    // var data = await Clipboard.getData(Clipboard.kTextPlain);
                    // if (data != null) {
                    //   setState(() {
                    //     _controller.text = data.toString();
                    //     input = data.toString();
                    //   });
                    // }
                  },
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    child: const Text('clear',
                        style: TextStyle(fontSize: 12, color: Colors.green)),
                    onTap: () {
                      setState(() {
                        _controller.text = '';
                        input = '';
                      });
                    }),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: 'feedsAddress',
                  filled: true,
                  fillColor: Colors.white),
              onChanged: (val) {
                input = val;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (RegexUtil.isURL(input)) {
              //TODO
            } else {
              EasyLoading.showError('非法链接');
            }
          },
          child: const Text('next'),
        ),
      ],
    );
  }
}
