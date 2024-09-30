import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  final WebViewController controller;
  const Webview({super.key, required this.controller});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late WebViewController _webViewController;
  int progressIndicator = 0;

  @override
  void initState() {
    _webViewController = widget.controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) =>
            _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
        onProgress: (progress) => setState(() {
          progressIndicator = progress;
        }),
        onPageFinished: (url) => setState(() {
          progressIndicator = 100;
        }),
      ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (progressIndicator < 100)
          LinearProgressIndicator(
            value: progressIndicator / 100,
            color: Colors.red,
            backgroundColor: Colors.black,
          ),
        Expanded(child: WebViewWidget(controller: _webViewController))
      ],
    );
  }
}
