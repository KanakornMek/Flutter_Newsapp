import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';
import 'package:webview_flutter/webview_flutter.dart';
class DetailPage extends StatefulWidget {
  final String? urL;
  const DetailPage({Key? key, this.urL}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: widget.urL,
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
