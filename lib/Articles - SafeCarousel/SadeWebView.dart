import 'package:flutter/material.dart';
import 'package:guardian_eye/screens/constants.dart';

class SafeWebView extends StatelessWidget {
  final String url;
  final String title;
  final int index;

  const SafeWebView(
      {super.key, required this.url, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.grey[50]?.withOpacity(0.3),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(imageSliders[index]),
          ),
        ],
      ),
      // body: WebView(
      //   initialUrl: url,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
